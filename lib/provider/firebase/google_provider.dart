import 'package:farmhouse_app/services/firebase/google_services.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuthenticationProvider extends ChangeNotifier {
  final GoogleServices _authService = GoogleServices();
  
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
    
    // Initialize with current user
    _user = _authService.currentUser;
  }

  // Sign in with Google
  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    _clearError();

    try {
      final userCredential = await _authService.signInWithGoogle();
      
      if (userCredential == null) {
        _setError('Sign in was cancelled');
        return false;
      }

      _user = userCredential.user;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _handleFirebaseError(e);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      _setError('Failed to sign out: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Delete account
  Future<bool> deleteAccount() async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.deleteAccount();
      _user = null;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _handleFirebaseError(e);
      return false;
    } catch (e) {
      _setError('Failed to delete account: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Helper methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  void _handleFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'account-exists-with-different-credential':
        _setError('An account already exists with a different credential');
        break;
      case 'invalid-credential':
        _setError('Invalid credentials provided');
        break;
      case 'operation-not-allowed':
        _setError('Google sign-in is not enabled');
        break;
      case 'user-disabled':
        _setError('This user account has been disabled');
        break;
      case 'user-not-found':
        _setError('No user found with this credential');
        break;
      case 'wrong-password':
        _setError('Wrong password provided');
        break;
      case 'requires-recent-login':
        _setError('This operation requires recent authentication');
        break;
      default:
        _setError('Authentication error: ${e.message}');
    }
  }
}