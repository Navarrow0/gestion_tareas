
part of '../use_cases.dart';

class GetTaskByUserIdUseCase {
  final UsersRepository repository;

  GetTaskByUserIdUseCase(this.repository);

  Future<Either<String, List<TaskEntity>>> call({required int userId}) {
    return repository.getTasksByIdUser(userId: userId);
  }
}
