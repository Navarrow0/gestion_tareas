part of '../use_cases.dart';

class GetLocalTasksUseCase {
  final LocalTasksRepository _tasksRepository;

  GetLocalTasksUseCase(this._tasksRepository);

  Future<Either<String, List<TaskEntity>>> call({required int userId}) async {
    return await _tasksRepository.getTasks(userId: userId);
  }
}
