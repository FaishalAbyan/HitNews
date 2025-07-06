import 'package:tekmob_hitnews/data/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() async {
    return await repository.signOut();
  }
}
