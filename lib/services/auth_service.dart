import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Current user getter
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Email & Password Authentication ///
  
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw _parseAuthError(e);
    }
  }

  Future<User?> registerWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw _parseAuthError(e);
    }
  }

  /// Password Management ///
  
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) {
      throw Exception('User not authenticated');
    }

    // Reauthenticate user
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword.trim(),
    );
    await user.reauthenticateWithCredential(credential);

    // Update password
    await user.updatePassword(newPassword.trim());
  }

  /// Session Management ///
  
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Error Handling ///
  
  String _parseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Please enter a valid email address';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password, please try again';
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'weak-password':
        return 'Password must be at least 6 characters';
      case 'requires-recent-login':
        return 'Please log in again to perform this action';
      default:
        return 'Authentication error: ${e.message ?? 'Unknown error'}';
    }
  }
}