import 'package:flutter/material.dart';
import 'package:tekmob_hitnews/domain/entities/user_entity.dart';
import 'package:tekmob_hitnews/domain/usecases/auth/sign_in_usecase.dart';
import 'package:tekmob_hitnews/domain/usecases/auth/sign_up_usecase.dart';
import 'package:tekmob_hitnews/domain/usecases/auth/sign_out_usecase.dart';
import 'package:tekmob_hitnews/domain/usecases/auth/get_current_user_usecase.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthProvider({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.getCurrentUserUseCase,
  }) {
    // Note: Untuk Supabase, StreamBuilder di main.dart sudah menangani ini,
    // tapi jika ada kebutuhan untuk state internal di provider, bisa diaktifkan.
  }

  UserEntity? _currentUser;
  UserEntity? get currentUser => _currentUser;

  AuthStatus _status = AuthStatus.initial;
  AuthStatus get status => _status;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  // Metode untuk memeriksa status pengguna saat ini (misalnya saat aplikasi dimulai)
  void checkCurrentUser() {
    _currentUser = getCurrentUserUseCase();
    _status =
        _currentUser != null
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      _currentUser = await signInUseCase(email, password);
      _status = AuthStatus.authenticated;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString().replaceFirst(
        'Exception: ',
        '',
      ); // Hapus "Exception: "
      _currentUser = null;
    } finally {
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      _currentUser = await signUpUseCase(email, password);
      _status = AuthStatus.authenticated;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _currentUser = null;
    } finally {
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _status = AuthStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      await signOutUseCase();
      _currentUser = null;
      _status = AuthStatus.unauthenticated;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      notifyListeners();
    }
  }
}
