part of 'local_data_source.dart';

class LocalTasksDataSource {

  Future<Box<LocalUserTasks>> _openUserTasksBox() async {
    return await Hive.openBox<LocalUserTasks>('userTasksBox');
  }

  Future<Either<String, List<LocalTaskModel>>> getTasks({required int userId}) async {
    try {
      final box = await _openUserTasksBox();
      final userTasks = box.values.firstWhere((ut) => ut.userId == userId);
      return Right(userTasks.tasks);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> saveTask({required int userId, required LocalTaskModel task}) async {
    try {
      final box = await _openUserTasksBox();
      LocalUserTasks? userTasks = box.values.firstWhere((ut) => ut.userId == userId,);

      userTasks.tasks.add(task);
      await userTasks.save();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> deleteTaskById({required int userId, required int taskId}) async {
    try {
      final box = await _openUserTasksBox();
      var userTasks = box.values.firstWhere((ut) => ut.userId == userId);
      userTasks.tasks.removeWhere((task) => task.id == taskId);
      await userTasks.save();
      return const Right(null);
        } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> saveTasks({required int userId, required List<LocalTaskModel> tasks}) async {
    try {
      final box = await _openUserTasksBox();
      LocalUserTasks? userTasks = box.values.firstWhereOrNull((ut) => ut.userId == userId);

      if (userTasks == null) {
        userTasks = LocalUserTasks(userId: userId, tasks: []);
        await box.put(userId, userTasks);
      }

      userTasks.tasks.addAll(tasks);

      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }


  Future<Either<String, void>> updateTask({required int userId, required LocalTaskModel updatedTask}) async {
    try {
      final box = await _openUserTasksBox();
      LocalUserTasks? userTasks = box.values.firstWhereOrNull((ut) => ut.userId == userId);

      if (userTasks != null) {

        final taskIndex = userTasks.tasks.indexWhere((task) => task.id == updatedTask.id);
        if (taskIndex != -1) {
          userTasks.tasks[taskIndex] = updatedTask;
          await userTasks.save();
          return const Right(null);
        } else {
          return const Left("Task not found");
        }
      } else {
        return const Left("User tasks not found");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }


  Future<Either<String, LocalTaskModel?>> getTaskById({required int userId, required int taskId}) async {
    try {
      final box = await _openUserTasksBox();
      LocalUserTasks? userTasks = box.values.firstWhereOrNull((ut) => ut.userId == userId);

      if (userTasks != null) {
        LocalTaskModel? task = userTasks.tasks.firstWhereOrNull((task) => task.id == taskId);
        if (task != null) {
          return Right(task);
        } else {
          return const Left("Task not found");
        }
      } else {
        return const Left("User tasks not found");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

}
