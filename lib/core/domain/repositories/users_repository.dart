part of 'repositories.dart';

abstract class UsersRepository {
  Future<Either<String, List<UserEntity>>> getUsers();
  Future<Either<String, List<TaskEntity>>> getTasksByIdUser({required int userId});
}