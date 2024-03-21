part of '../use_cases.dart';

class GetLocalTaskByIdUseCase {
  final LocalTasksRepository _tasksRepository;

  GetLocalTaskByIdUseCase(this._tasksRepository);

  Future<Either<String, TaskEntity?>> call({required int taskId, required int userId}) async {
    return await _tasksRepository.getTaskById(taskId: taskId, userId: userId);
  }
}