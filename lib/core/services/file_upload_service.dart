import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

/// Service for uploading files to Firebase Storage
class FileUploadService {
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  FileUploadService({
    FirebaseStorage? storage,
    FirebaseAuth? auth,
  })  : _storage = storage ?? FirebaseStorage.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Upload a file and return the download URL
  Future<String> uploadFile({
    required File file,
    required String folder,
    String? fileName,
    Function(double)? onProgress,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    // Generate unique filename if not provided
    final fileExtension = path.extension(file.path);
    final uploadFileName = fileName ?? '${const Uuid().v4()}$fileExtension';
    
    // Create reference
    final ref = _storage.ref().child('$folder/$userId/$uploadFileName');

    // Upload file
    final uploadTask = ref.putFile(file);

    // Listen to progress
    if (onProgress != null) {
      uploadTask.snapshotEvents.listen((taskSnapshot) {
        final progress = taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;
        onProgress(progress);
      });
    }

    // Wait for upload to complete
    final snapshot = await uploadTask;

    // Get download URL
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  /// Upload an image with optional compression
  Future<String> uploadImage({
    required File file,
    String? fileName,
    Function(double)? onProgress,
  }) async {
    return await uploadFile(
      file: file,
      folder: 'images',
      fileName: fileName,
      onProgress: onProgress,
    );
  }

  /// Upload a video
  Future<String> uploadVideo({
    required File file,
    String? fileName,
    Function(double)? onProgress,
  }) async {
    return await uploadFile(
      file: file,
      folder: 'videos',
      fileName: fileName,
      onProgress: onProgress,
    );
  }

  /// Upload an audio file
  Future<String> uploadAudio({
    required File file,
    String? fileName,
    Function(double)? onProgress,
  }) async {
    return await uploadFile(
      file: file,
      folder: 'audio',
      fileName: fileName,
      onProgress: onProgress,
    );
  }

  /// Upload a document
  Future<String> uploadDocument({
    required File file,
    String? fileName,
    Function(double)? onProgress,
  }) async {
    return await uploadFile(
      file: file,
      folder: 'documents',
      fileName: fileName,
      onProgress: onProgress,
    );
  }

  /// Delete a file from storage
  Future<void> deleteFile(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } catch (e) {
      // File might not exist, ignore error
    }
  }

  /// Get file metadata
  Future<FullMetadata> getFileMetadata(String url) async {
    final ref = _storage.refFromURL(url);
    return await ref.getMetadata();
  }
}
