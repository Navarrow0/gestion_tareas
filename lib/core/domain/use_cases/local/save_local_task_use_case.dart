part of '../use_cases.dart';

class SaveLocalTaskUseCase {
  final LocalTasksRepository _tasksRepository;

  SaveLocalTaskUseCase(this._tasksRepository);

  Future<Either<String, void>> call({required int userId, required TaskEntity task}) async {
    return await _tasksRepository.saveTask(userId: userId, task: task);
  }
}