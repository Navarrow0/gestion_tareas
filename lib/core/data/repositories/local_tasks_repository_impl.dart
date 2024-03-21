
part of 'repositories.dart';

class LocalTasksRepositoryImpl implements LocalTasksRepository {
  final LocalTasksDataSource _tasksLocalDataSource;

  LocalTasksRepositoryImpl(this._tasksLocalDataSource);

  @override
  Future<Either<String, void>> deleteTaskById({required int userId, required int taskId}) async {
    return await _tasksLocalDataSource.deleteTaskById(userId: userId, taskId: taskId);
  }

  @override
  Future<Either<String, List<TaskEntity>>> getTasks({required int userId}) async {
    final either = await _tasksLocalDataSource.getTasks(userId: userId);
    return either.fold(
          (l) => Left(l),
          (r) => Right(r.map((taskModel) => taskModel.toEntity()).toList()),
    );
  }

  @override
  Future<Either<String, void>> saveTask({required int userId, required TaskEntity task}) async {
    final taskModel = task.toModel();
    return await _tasksLocalDataSource.saveTask(userId: userId, task: taskModel);
  }

  @override
  Future<Either<String, void>> saveTasks({required int userId, required List<TaskEntity> tasks}) async {
    final taskModels = tasks.map((task) => task.toModel()).toList();
    return await _tasksLocalDataSource.saveTasks(userId: userId, tasks: taskModels);
  }

  @override
  Future<Either<String, TaskEntity?>> getTaskById({required int userId, required int taskId}) async {
    try {
      final result = await _tasksLocalDataSource.getTaskById(userId: userId, taskId: taskId);
      return result.fold(
            (l) => Left(l),
            (r) => Right(r?.toEntity())
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> updateTask({required int userId, required TaskEntity updatedTask}) async {
    try {
      final taskModel = updatedTask.toModel();
      final result = await _tasksLocalDataSource.updateTask(userId: userId, updatedTask: taskModel);
      return result;
    } catch (e) {
      return Left(e.toString());
    }
  }
}
