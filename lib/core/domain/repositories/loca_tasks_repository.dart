part of 'repositories.dart';

abstract class LocalTasksRepository {
  Future<Either<String, List<TaskEntity>>> getTasks({required int userId});

  Future<Either<String, void>> saveTask({required int userId, required TaskEntity task});

  Future<Either<String, void>> deleteTaskById({required int userId, required int taskId});

  Future<Either<String, void>> saveTasks({required int userId, required List<TaskEntity> tasks});

  Future<Either<String, void>> updateTask({required int userId, required TaskEntity updatedTask});

  Future<Either<String, TaskEntity?>> getTaskById({required int userId, required int taskId});
}