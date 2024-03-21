part of '../use_cases.dart';

class DeleteLocalTaskByIdUseCase {
  final LocalTasksRepository _tasksRepository;

  DeleteLocalTaskByIdUseCase(this._tasksRepository);

  Future<Either<String, void>> call({required int taskId, required int userId}) async {
    return await _tasksRepository.deleteTaskById(taskId: taskId, userId: userId);
  }
}