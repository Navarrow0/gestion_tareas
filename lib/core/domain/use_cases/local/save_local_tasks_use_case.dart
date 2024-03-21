part of '../use_cases.dart';

class SaveLocalTasksUseCase {
  final LocalTasksRepository _tasksRepository;

  SaveLocalTasksUseCase(this._tasksRepository);

  Future<Either<String, void>> call({required int userId, required List<TaskEntity> tasks}) async {
    return await _tasksRepository.saveTasks(userId: userId, tasks: tasks);
  }
}