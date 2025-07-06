    import 'package:tekmob_hitnews/domain/entities/user_entity.dart';
    import 'package:tekmob_hitnews/data/repositories/auth_repository.dart';

    class GetCurrentUserUseCase {
      final AuthRepository repository;

      GetCurrentUserUseCase(this.repository);

      UserEntity? call() {
        return repository.getCurrentUser();
      }
    }
    