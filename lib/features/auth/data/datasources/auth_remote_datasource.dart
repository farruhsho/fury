import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

/// Remote datasource for authentication
class AuthRemoteDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  GoogleSignIn? _googleSignIn;

  AuthRemoteDatasource({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _googleSignIn = googleSignIn;

  // ===== Email/Password Authentication =====

  /// Register with email and password
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
    required String username,
    String? displayName,
  }) async {
    try {
      print('📧 [AUTH] Starting email registration for: $email');

      // Check if username is already taken
      final usernameQuery = await _firestore
          .collection('users')
          .where('username', isEqualTo: username.toLowerCase())
          .get();

      if (usernameQuery.docs.isNotEmpty) {
        throw const AuthException(
          message: 'Username is already taken',
          code: 'username-already-exists',
        );
      }

      // Create user with email and password
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw const AuthException(message: 'Failed to create user');
      }

      // Create user document in Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        email: email,
        username: username.toLowerCase(),
        displayName: displayName ?? username,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(newUser.id)
          .set(newUser.toFirestore());

      print('✅ [AUTH] User registered successfully: ${newUser.id}');
      return newUser;
    } on FirebaseAuthException catch (e) {
      print('❌ [AUTH] FirebaseAuthException - Code: ${e.code}, Message: ${e.message}');
      throw AuthException(
        message: _getAuthErrorMessage(e.code),
        code: e.code,
      );
    } catch (e) {
      print('❌ [AUTH] Unexpected error: $e');
      throw AuthException(message: e.toString());
    }
  }

  /// Sign in with email and password
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      print('📧 [AUTH] Starting email sign in for: $email');

      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw const AuthException(message: 'Failed to sign in');
      }

      // Get user document from Firestore
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        throw const AuthException(message: 'User data not found');
      }

      print('✅ [AUTH] User signed in successfully: ${userCredential.user!.uid}');
      return UserModel.fromFirestore(userDoc);
    } on FirebaseAuthException catch (e) {
      print('❌ [AUTH] FirebaseAuthException - Code: ${e.code}, Message: ${e.message}');
      throw AuthException(
        message: _getAuthErrorMessage(e.code),
        code: e.code,
      );
    } catch (e) {
      print('❌ [AUTH] Unexpected error: $e');
      throw AuthException(message: e.toString());
    }
  }

  // ===== Google Sign-In =====

  /// Sign in with Google
  Future<UserModel> signInWithGoogle() async {
    try {
      print('🔵 [AUTH] Starting Google Sign-In');

      // Lazy initialize GoogleSignIn if not already initialized
      _googleSignIn ??= GoogleSignIn();

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn!.signIn();

      if (googleUser == null) {
        throw const AuthException(message: 'Google Sign-In was cancelled');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential = await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw const AuthException(message: 'Failed to sign in with Google');
      }

      final firebaseUser = userCredential.user!;

      // Check if user exists in Firestore
      final userDoc = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (userDoc.exists) {
        print('✅ [AUTH] Existing Google user signed in: ${firebaseUser.uid}');
        return UserModel.fromFirestore(userDoc);
      } else {
        // Create new user - generate username from email
        final emailUsername = firebaseUser.email?.split('@').first ?? 'user';
        var username = emailUsername.toLowerCase();

        // Check if username is taken and add numbers if needed
        int suffix = 1;
        while (true) {
          final existingUser = await _firestore
              .collection('users')
              .where('username', isEqualTo: username)
              .get();

          if (existingUser.docs.isEmpty) break;
          username = '${emailUsername.toLowerCase()}$suffix';
          suffix++;
        }

        final newUser = UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email,
          username: username,
          displayName: firebaseUser.displayName ?? username,
          avatarUrl: firebaseUser.photoURL,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await _firestore
            .collection('users')
            .doc(newUser.id)
            .set(newUser.toFirestore());

        print('✅ [AUTH] New Google user created: ${newUser.id}');
        return newUser;
      }
    } on FirebaseAuthException catch (e) {
      print('❌ [AUTH] FirebaseAuthException - Code: ${e.code}, Message: ${e.message}');
      throw AuthException(
        message: e.message ?? 'Google Sign-In failed',
        code: e.code,
      );
    } catch (e) {
      print('❌ [AUTH] Unexpected error: $e');
      throw AuthException(message: e.toString());
    }
  }

  // ===== Phone Authentication (for future) =====

  /// Send OTP to phone number
  Future<String> sendOTP(String phoneNumber) async {
    try {
      String? verificationId;
      String? errorMessage;

      print('🔵 [SMS] Starting phone verification for: $phoneNumber');

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('✅ [SMS] Auto-verification completed (Android only)');
          // Auto-verification (Android only)
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print('❌ [SMS] Verification failed - Code: ${e.code}, Message: ${e.message}');
          errorMessage = e.message ?? 'Verification failed';
          throw AuthException(
            message: e.message ?? 'Verification failed',
            code: e.code,
          );
        },
        codeSent: (String verId, int? resendToken) {
          print('📤 [SMS] Code sent callback triggered - VerificationID: $verId');
          verificationId = verId;
        },
        codeAutoRetrievalTimeout: (String verId) {
          print('⏱️ [SMS] Auto-retrieval timeout - VerificationID: $verId');
          verificationId = verId;
        },
        timeout: const Duration(seconds: 60),
      );

      // Wait for verification ID with longer timeout
      int attempts = 0;
      while (verificationId == null && errorMessage == null && attempts < 15) {
        await Future.delayed(const Duration(milliseconds: 500));
        attempts++;
      }

      if (errorMessage != null) {
        print('❌ [SMS] Error occurred: $errorMessage');
        throw AuthException(message: errorMessage!);
      }

      if (verificationId == null) {
        print('❌ [SMS] Timeout: Verification ID not received after 7.5 seconds');
        throw const AuthException(
          message: 'SMS sending timeout. Please check:\n'
              '1. Phone number format (include country code)\n'
              '2. Firebase Console Phone Auth is enabled\n'
              '3. SMS quota not exceeded\n'
              '4. Valid phone number'
        );
      }

      print('✅ [SMS] Verification ID received successfully: $verificationId');
      return verificationId!;
    } on FirebaseAuthException catch (e) {
      print('❌ [SMS] FirebaseAuthException - Code: ${e.code}, Message: ${e.message}');
      throw AuthException(
        message: e.message ?? 'Authentication error',
        code: e.code,
      );
    } catch (e) {
      print('❌ [SMS] Unexpected error: $e');
      throw AuthException(message: e.toString());
    }
  }
  
  /// Verify OTP code
  Future<UserModel> verifyOTP({
    required String phoneNumber,
    required String verificationId,
    required String code,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );
      
      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      
      if (userCredential.user == null) {
        throw const AuthException(message: 'Failed to sign in');
      }
      
      // Check if user exists in Firestore
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      
      if (userDoc.exists) {
        // Return existing user
        return UserModel.fromFirestore(userDoc);
      } else {
        // Create new user
        final newUser = UserModel(
          id: userCredential.user!.uid,
          phoneNumber: phoneNumber,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        await _firestore
            .collection('users')
            .doc(newUser.id)
            .set(newUser.toJson());
        
        return newUser;
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        message: e.message ?? 'Verification failed',
        code: e.code,
      );
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }
  
  /// Get current user
  /// 
  /// This method waits for Firebase Auth to finish restoring the session
  /// before checking the current user. This is important because on app restart,
  /// Firebase Auth needs time to restore the persisted authentication state.
  Future<UserModel?> getCurrentUser() async {
    try {
      print('🔍 [AUTH] Checking current user...');
      
      // IMPORTANT: Wait for Firebase Auth to restore the session
      // On app restart, currentUser might be null initially even if user was logged in
      // We need to wait for authStateChanges to emit the first value
      User? firebaseUser = _firebaseAuth.currentUser;
      
      if (firebaseUser == null) {
        print('🔄 [AUTH] Waiting for Firebase Auth to restore session...');
        
        // Wait for the first auth state change (session restoration)
        // This will return null if no user is logged in, or the user if logged in
        firebaseUser = await _firebaseAuth.authStateChanges().first.timeout(
          const Duration(seconds: 5),
          onTimeout: () {
            print('⏱️ [AUTH] Auth state restoration timed out');
            return null;
          },
        );
        
        if (firebaseUser == null) {
          print('ℹ️ [AUTH] No Firebase user found after waiting - user is not authenticated');
          return null;
        }
        
        print('✅ [AUTH] Firebase user restored from session: ${firebaseUser.uid}');
      } else {
        print('✅ [AUTH] Firebase user already available: ${firebaseUser.uid}');
      }
      
      print('🔄 [AUTH] Fetching user data from Firestore...');
      
      // Add timeout to prevent hanging
      final userDoc = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              print('⏱️ [AUTH] Firestore connection timed out after 10 seconds');
              throw const AuthException(message: 'Connection timed out. Please check your internet connection.');
            },
          );
      
      if (!userDoc.exists) {
        print('⚠️ [AUTH] User document does not exist in Firestore for UID: ${firebaseUser.uid}');
        print('ℹ️ [AUTH] User may need to complete profile setup');
        // Return a minimal user model to indicate the user is authenticated but needs profile setup
        return UserModel(
          id: firebaseUser.uid,
          phoneNumber: firebaseUser.phoneNumber,
          email: firebaseUser.email,
          displayName: firebaseUser.displayName,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      }
      
      print('✅ [AUTH] User data retrieved successfully from Firestore');
      return UserModel.fromFirestore(userDoc);
    } on AuthException catch (e) {
      // Auth exceptions (like timeout) should be logged but return null
      // This allows the app to redirect to login instead of hanging
      print('⚠️ [AUTH] AuthException in getCurrentUser: ${e.message}');
      return null;
    } catch (e) {
      // Any other exception should also return null to prevent hanging
      // Network errors, Firestore errors, etc. should not block the app
      print('❌ [AUTH] Unexpected error in getCurrentUser: $e');
      print('ℹ️ [AUTH] Treating as unauthenticated and returning null');
      return null;
    }
  }
  
  /// Update user profile
  Future<UserModel> updateProfile({
    required String userId,
    String? displayName,
    String? username,
    String? bio,
    String? avatarUrl,
  }) async {
    try {
      final updates = <String, dynamic>{
        'updatedAt': FieldValue.serverTimestamp(),
      };
      
      if (displayName != null) updates['displayName'] = displayName;
      if (username != null) updates['username'] = username;
      if (bio != null) updates['bio'] = bio;
      if (avatarUrl != null) updates['avatarUrl'] = avatarUrl;
      
      await _firestore
          .collection('users')
          .doc(userId)
          .update(updates);
      
      final userDoc = await _firestore
          .collection('users')
          .doc(userId)
          .get();
      
      return UserModel.fromFirestore(userDoc);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
  
  /// Update FCM token for push notifications
  Future<void> updateFcmToken(String token) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        print('⚠️ [AUTH] Cannot update FCM token - no user signed in');
        return;
      }
      
      print('📱 [AUTH] Updating FCM token for user: ${currentUser.uid}');
      
      await _firestore.collection('users').doc(currentUser.uid).update({
        'fcmToken': token,
        'fcmTokenUpdatedAt': FieldValue.serverTimestamp(),
      });
      
      print('✅ [AUTH] FCM token updated successfully');
    } catch (e) {
      print('❌ [AUTH] Error updating FCM token: $e');
      // Don't throw - FCM token update is not critical
    }
  }
  
  /// Sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }
  
  /// Delete account
  Future<void> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw const AuthException(message: 'No user signed in');
      }

      // Delete user document from Firestore
      await _firestore.collection('users').doc(user.uid).delete();

      // Delete Firebase Auth user
      await user.delete();
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }
  
  /// Search users by username or display name
  Future<List<UserModel>> searchUsers(String query) async {
    try {
      print('🔍 [AUTH] Searching users with query: $query');
      
      if (query.isEmpty) {
        return [];
      }
      
      final currentUser = _firebaseAuth.currentUser;
      
      // Remove @ symbol if present and convert to lowercase
      String searchQuery = query.trim();
      if (searchQuery.startsWith('@')) {
        searchQuery = searchQuery.substring(1);
      }
      final lowercaseQuery = searchQuery.toLowerCase();
      
      print('🔍 [AUTH] Processed search query: $lowercaseQuery');
      
      // Search by username first
      final usernameSnapshot = await _firestore
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: lowercaseQuery)
          .where('username', isLessThanOrEqualTo: '$lowercaseQuery\uf8ff')
          .limit(20)
          .get();
      
      // Also search by displayName (case-insensitive using lowercase version)
      final displayNameSnapshot = await _firestore
          .collection('users')
          .where('displayNameLower', isGreaterThanOrEqualTo: lowercaseQuery)
          .where('displayNameLower', isLessThanOrEqualTo: '$lowercaseQuery\uf8ff')
          .limit(20)
          .get();
      
      print('📊 [AUTH] Username search: ${usernameSnapshot.docs.length}, DisplayName search: ${displayNameSnapshot.docs.length}');
      
      // Combine results, removing duplicates
      final Set<String> seenIds = {};
      final List<UserModel> users = [];
      
      for (final doc in [...usernameSnapshot.docs, ...displayNameSnapshot.docs]) {
        if (!seenIds.contains(doc.id) && doc.id != currentUser?.uid) {
          seenIds.add(doc.id);
          users.add(UserModel.fromFirestore(doc));
        }
      }
      
      print('✅ [AUTH] Found ${users.length} unique users');
      return users;
    } catch (e) {
      print('❌ [AUTH] Error searching users: $e');
      throw ServerException(message: e.toString());
    }
  }

  // ===== Helper Methods =====

  /// Get user-friendly error message from Firebase auth error code
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered. Please sign in instead.';
      case 'invalid-email':
        return 'Invalid email address format.';
      case 'operation-not-allowed':
        return 'Email/password authentication is not enabled.';
      case 'weak-password':
        return 'Password is too weak. Please use at least 6 characters.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
