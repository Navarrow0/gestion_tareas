
part of '../use_cases.dart';

class GetUsersUseCase {
  final UsersRepository repository;

  GetUsersUseCase(this.repository);

  Future<Either<String, List<UserEntity>>> call() {
    return repository.getUsers();
  }
}
