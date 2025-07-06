import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tekmob_hitnews/data/models/user_model.dart';
import 'package:tekmob_hitnews/data/services/auth_service.dart';
import 'package:tekmob_hitnews/domain/entities/user_entity.dart';

// Antarmuka (abstract class) untuk Auth Repository
abstract class AuthRepository {
  Stream<UserEntity?> get authStateChanges;
  UserEntity? getCurrentUser();
  Future<UserEntity> signInWithEmailAndPassword(String email, String password);
  Future<UserEntity> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

// Implementasi konkret dari Auth Repository
class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl(this.authService);

  @override
  Stream<UserEntity?> get authStateChanges {
    return authService.authStateChanges.map((authState) {
      if (authState.event == AuthChangeEvent.signedIn &&
          authState.session?.user != null) {
        return UserModel.fromSupabaseUser(authState.session!.user!).toEntity();
      }
      return null;
    });
  }

  @override
  UserEntity? getCurrentUser() {
    final user = authService.getCurrentSupabaseUser();
    return user != null ? UserModel.fromSupabaseUser(user).toEntity() : null;
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final response = await authService.signInWithEmailAndPassword(
      email,
      password,
    );
    if (response.user != null) {
      return UserModel.fromSupabaseUser(response.user!).toEntity();
    }
    throw Exception('Failed to sign in: User data not found.');
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final response = await authService.signUpWithEmailAndPassword(
      email,
      password,
    );
    if (response.user != null) {
      return UserModel.fromSupabaseUser(response.user!).toEntity();
    }
    throw Exception('Failed to sign up: User data not found.');
  }

  @override
  Future<void> signOut() {
    return authService.signOut();
  }
}
