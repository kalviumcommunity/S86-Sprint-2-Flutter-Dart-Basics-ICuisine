import 'package:firebase_auth/firebase_auth.dart';

/// Authentication service for managing user sign up, login, and logout
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign up with email and password
  /// Returns User object if successful, null otherwise
  Future<User?> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('Sign up error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      print('Unexpected error during sign up: $e');
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  /// Sign in with email and password
  /// Returns User object if successful, null otherwise
  Future<User?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('Sign in error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      print('Unexpected error during sign in: $e');
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  /// Sign out current user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Sign out error: $e');
      throw 'Failed to sign out. Please try again.';
    }
  }

  /// Reset password via email
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print('Password reset error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      print('Unexpected error during password reset: $e');
      throw 'Failed to send password reset email. Please try again.';
    }
  }

  /// Delete current user account
  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      print('Account deletion error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      print('Unexpected error during account deletion: $e');
      throw 'Failed to delete account. Please try again.';
    }
  }

  /// Handle Firebase Authentication exceptions with user-friendly messages
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak. Please use at least 6 characters.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-not-found':
        return 'No account found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'Email/Password sign-in is not enabled. Please enable it in Firebase Console → Authentication → Sign-in method.';
      case 'requires-recent-login':
        return 'Please log in again to complete this action.';
      case 'configuration-not-found':
        return 'Firebase authentication is not properly configured. Please enable Email/Password authentication in Firebase Console.';
      case 'invalid-credential':
        return 'The credentials provided are invalid. Please check your email and password.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection and try again.';
      case 'internal-error':
        return 'An internal error occurred. Please try again later.';
      default:
        return e.message ?? 'Authentication failed: ${e.code}. Please try again.';
    }
  }
}
