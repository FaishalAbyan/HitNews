import 'package:tekmob_hitnews/domain/entities/user_entity.dart';
import 'package:tekmob_hitnews/data/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<UserEntity> call(String email, String password) async {
    return await repository.signInWithEmailAndPassword(email, password);
  }
}
