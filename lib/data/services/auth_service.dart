import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final GoTrueClient _authClient = Supabase.instance.client.auth;

  // Mendapatkan stream perubahan status autentikasi
  Stream<AuthState> get authStateChanges => _authClient.onAuthStateChange;

  // Mendapatkan pengguna saat ini
  User? getCurrentSupabaseUser() {
    return _authClient.currentUser;
  }

  // Login dengan email dan password
  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final AuthResponse response = await _authClient.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unexpected error occurred during sign-in: $e');
    }
  }

  // Mendaftar dengan email dan password
  Future<AuthResponse> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final AuthResponse response = await _authClient.signUp(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unexpected error occurred during sign-up: $e');
    }
  }

  // Logout pengguna
  Future<void> signOut() async {
    try {
      await _authClient.signOut();
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unexpected error occurred during sign-out: $e');
    }
  }
}
