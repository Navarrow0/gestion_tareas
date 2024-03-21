part of '../use_cases.dart';

class UpdateLocalTaskUseCase {
  final LocalTasksRepository _tasksRepository;

  UpdateLocalTaskUseCase(this._tasksRepository);

  Future<Either<String, void>> call({required int userId, required TaskEntity taskEntity, }) async {
    return await _tasksRepository.updateTask(userId: userId, updatedTask: taskEntity);
  }
}