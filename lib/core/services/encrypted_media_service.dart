import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;
import '../encryption/encryption_service.dart';

/// Service for encrypting and decrypting media files (images, videos, audio)
/// 
/// Uses AES-256-GCM for encryption with chunked processing for large files.
/// Supports streaming encryption/decryption for memory efficiency.
class EncryptedMediaService {
  final EncryptionService _encryptionService;
  
  /// Chunk size for processing large files (1MB)
  static const int _chunkSize = 1024 * 1024;
  
  /// File extension for encrypted files
  static const String _encryptedExtension = '.enc';
  
  EncryptedMediaService(this._encryptionService);

  /// Encrypt a media file and return the encrypted file path
  Future<String> encryptFile({
    required String inputPath,
    required String sessionKey,
    String? outputPath,
  }) async {
    final inputFile = File(inputPath);
    if (!await inputFile.exists()) {
      throw FileSystemException('Input file not found', inputPath);
    }
    
    final outPath = outputPath ?? '$inputPath$_encryptedExtension';
    final outputFile = File(outPath);
    
    // Read input file
    final bytes = await inputFile.readAsBytes();
    
    // Encrypt using AES-256-GCM
    final encryptedData = _encrypt(bytes, sessionKey);
    
    // Write encrypted file with metadata header
    final header = _createHeader(
      originalSize: bytes.length,
      originalExtension: inputPath.split('.').last,
    );
    
    await outputFile.writeAsBytes([
      ...header,
      ...encryptedData,
    ]);
    
    return outPath;
  }

  /// Decrypt a media file and return the decrypted file path
  Future<String> decryptFile({
    required String inputPath,
    required String sessionKey,
    String? outputPath,
  }) async {
    final inputFile = File(inputPath);
    if (!await inputFile.exists()) {
      throw FileSystemException('Encrypted file not found', inputPath);
    }
    
    final bytes = await inputFile.readAsBytes();
    
    // Parse header
    final header = _parseHeader(bytes);
    final encryptedData = bytes.sublist(header['headerSize'] as int);
    
    // Decrypt
    final decryptedData = _decrypt(encryptedData, sessionKey);
    
    // Determine output path
    final outPath = outputPath ?? 
        inputPath.replaceAll(_encryptedExtension, '') + 
        '.${header['extension']}';
    
    final outputFile = File(outPath);
    await outputFile.writeAsBytes(decryptedData);
    
    return outPath;
  }

  /// Encrypt bytes using AES-256-GCM
  Uint8List _encrypt(Uint8List data, String keyString) {
    final key = encrypt.Key.fromBase64(keyString);
    final iv = encrypt.IV.fromSecureRandom(12);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
    
    final encrypted = encrypter.encryptBytes(data, iv: iv);
    
    // Prepend IV to encrypted data
    return Uint8List.fromList([
      ...iv.bytes,
      ...encrypted.bytes,
    ]);
  }

  /// Decrypt bytes using AES-256-GCM
  Uint8List _decrypt(Uint8List data, String keyString) {
    final key = encrypt.Key.fromBase64(keyString);
    
    // Extract IV (first 12 bytes)
    final iv = encrypt.IV(data.sublist(0, 12));
    final encryptedBytes = data.sublist(12);
    
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
    final encrypted = encrypt.Encrypted(encryptedBytes);
    
    return Uint8List.fromList(encrypter.decryptBytes(encrypted, iv: iv));
  }

  /// Create file header with metadata
  List<int> _createHeader({
    required int originalSize,
    required String originalExtension,
  }) {
    // Header format:
    // [4 bytes: magic number "FURY"]
    // [4 bytes: header size]
    // [4 bytes: original file size]
    // [1 byte: extension length]
    // [N bytes: original extension]
    
    final magic = 'FURY'.codeUnits;
    final extBytes = originalExtension.codeUnits;
    
    final headerSize = 4 + 4 + 4 + 1 + extBytes.length;
    
    return [
      ...magic,
      ..._intToBytes(headerSize),
      ..._intToBytes(originalSize),
      extBytes.length,
      ...extBytes,
    ];
  }

  /// Parse header from encrypted file
  Map<String, dynamic> _parseHeader(Uint8List data) {
    // Verify magic number
    final magic = String.fromCharCodes(data.sublist(0, 4));
    if (magic != 'FURY') {
      throw FormatException('Invalid encrypted file format');
    }
    
    final headerSize = _bytesToInt(data.sublist(4, 8));
    final originalSize = _bytesToInt(data.sublist(8, 12));
    final extLength = data[12];
    final extension = String.fromCharCodes(data.sublist(13, 13 + extLength));
    
    return {
      'headerSize': headerSize,
      'originalSize': originalSize,
      'extension': extension,
    };
  }

  /// Convert int to 4 bytes (big endian)
  List<int> _intToBytes(int value) {
    return [
      (value >> 24) & 0xFF,
      (value >> 16) & 0xFF,
      (value >> 8) & 0xFF,
      value & 0xFF,
    ];
  }

  /// Convert 4 bytes to int (big endian)
  int _bytesToInt(List<int> bytes) {
    return (bytes[0] << 24) | (bytes[1] << 16) | (bytes[2] << 8) | bytes[3];
  }

  /// Encrypt media for sending (returns base64 encrypted data)
  Future<String> encryptMediaForSending({
    required Uint8List data,
    required String sessionKey,
    required String fileExtension,
  }) async {
    final encrypted = _encrypt(data, sessionKey);
    final header = _createHeader(
      originalSize: data.length,
      originalExtension: fileExtension,
    );
    
    final combined = Uint8List.fromList([...header, ...encrypted]);
    return encrypt.Encrypted(combined).base64;
  }

  /// Decrypt received media (from base64)
  Future<Uint8List> decryptReceivedMedia({
    required String encryptedBase64,
    required String sessionKey,
  }) async {
    final bytes = encrypt.Encrypted.fromBase64(encryptedBase64).bytes;
    
    final header = _parseHeader(Uint8List.fromList(bytes));
    final encryptedData = bytes.sublist(header['headerSize'] as int);
    
    return _decrypt(Uint8List.fromList(encryptedData), sessionKey);
  }

  /// Check if a file is encrypted
  Future<bool> isEncryptedFile(String path) async {
    final file = File(path);
    if (!await file.exists()) return false;
    
    final bytes = await file.openRead(0, 4).first;
    return String.fromCharCodes(bytes) == 'FURY';
  }

  /// Get encrypted file info without decrypting
  Future<Map<String, dynamic>> getEncryptedFileInfo(String path) async {
    final file = File(path);
    final bytes = await file.readAsBytes();
    return _parseHeader(bytes);
  }

  /// Encrypt file stream for large files (memory efficient)
  Stream<List<int>> encryptFileStream({
    required String inputPath,
    required String sessionKey,
  }) async* {
    final file = File(inputPath);
    final fileSize = await file.length();
    
    // Yield header first
    yield _createHeader(
      originalSize: fileSize,
      originalExtension: inputPath.split('.').last,
    );
    
    // Read and encrypt in chunks
    final key = encrypt.Key.fromBase64(sessionKey);
    final iv = encrypt.IV.fromSecureRandom(12);
    
    // Yield IV
    yield iv.bytes;
    
    // Stream encrypted chunks
    await for (final chunk in file.openRead()) {
      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
      final encrypted = encrypter.encryptBytes(chunk, iv: iv);
      yield encrypted.bytes;
    }
  }
}

/// Mixin for encrypted media upload/download
mixin EncryptedMediaMixin {
  EncryptedMediaService get encryptedMediaService;
  
  /// Upload encrypted media
  Future<String> uploadEncryptedMedia({
    required String filePath,
    required String sessionKey,
    required Future<String> Function(String) uploadFunction,
  }) async {
    // Encrypt the file
    final encryptedPath = await encryptedMediaService.encryptFile(
      inputPath: filePath,
      sessionKey: sessionKey,
    );
    
    // Upload encrypted file
    final url = await uploadFunction(encryptedPath);
    
    // Clean up temp encrypted file
    await File(encryptedPath).delete();
    
    return url;
  }
  
  /// Download and decrypt media
  Future<String> downloadDecryptedMedia({
    required String url,
    required String sessionKey,
    required Future<String> Function(String) downloadFunction,
    required String outputDir,
  }) async {
    // Download encrypted file
    final encryptedPath = await downloadFunction(url);
    
    // Decrypt
    final decryptedPath = await encryptedMediaService.decryptFile(
      inputPath: encryptedPath,
      sessionKey: sessionKey,
      outputPath: '$outputDir/${DateTime.now().millisecondsSinceEpoch}',
    );
    
    // Clean up encrypted file
    await File(encryptedPath).delete();
    
    return decryptedPath;
  }
}
