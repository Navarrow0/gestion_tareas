import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_tareas/core/config/utils.dart';
import 'package:gestion_tareas/core/domain/entities/entities.dart';
import 'package:gestion_tareas/core/presentation/screens/providers/providers.dart';

class TaskState extends Equatable {
  final List<TaskEntity>? tasks;
  final TaskEntity? taskDetail;
  final bool isLoading;
  final String? errorMessage;

  const TaskState({
    this.tasks,
    this.isLoading = false,
    this.errorMessage,
    this.taskDetail
  });

  TaskState copyWith({
    List<TaskEntity>? tasks,
    TaskEntity? taskDetail,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      taskDetail: taskDetail ?? this.taskDetail,
    );
  }

  @override
  List<Object?> get props => [tasks, taskDetail];
}

class UserTasksProvider extends StateNotifier<TaskState> {
  UserTasksProvider(this.ref) : super(const TaskState());

  Ref ref;

  Future<void> getTasks({required int userId}) async {

    state = state.copyWith(isLoading: true, errorMessage: null);

    final localTasksEither = await ref.read(getLocalTaskUseCase).call(userId: userId);
    final localTasksExist = localTasksEither.fold(
          (l) => false,
          (tasks) => tasks.isNotEmpty,
    );

    if (localTasksExist) {
      localTasksEither.fold(
            (l) => state = state.copyWith(isLoading: false, errorMessage: l),
            (tasks) => state = state.copyWith(tasks: tasks, isLoading: false),
      );
      return;
    }

    final tasks = await ref.read(getTaksUsecase).call(userId: userId);

    tasks.fold(
          (l) => state = state.copyWith(isLoading: false, errorMessage: l), (tasks) async {
        final saveResult = await ref.read(saveLocalTasksUseCase).call(userId: userId,tasks: tasks);
        saveResult.fold(
              (l) => state = state.copyWith(isLoading: false, errorMessage: l),
              (_) => state = state.copyWith(tasks: tasks, isLoading: false),
        );
      },
    );
  }


  Future<void> addTask({
    required int userId,
    required String title,
    required Function({String? successMessage, String? errorMessage}) onResult,
  }) async {
    final newTask = TaskEntity(
      title: title,
      userId: userId,
      completed: false,
      id: generateNumericUuid(),
    );

    final saveResult = await ref.read(saveLocalTaskUseCase).call(userId: userId, task: newTask);
    saveResult.fold(
          (l) => onResult(errorMessage: "Error al guardar la tarea: $l"),
          (_) {
        final updatedTasks = [...?state.tasks, newTask];
        state = state.copyWith(tasks: updatedTasks);
        onResult(successMessage: "Tarea agregada correctamente");
      },
    );
  }

  Future<void> deleteTaskById({required int userId, required int taskId,
    required Function({String? successMessage, String? errorMessage}) onResult,}) async {
    final deleteResult = await ref.read(deleteTaskByIdUseCaseProvider).call(userId: userId, taskId: taskId);

    deleteResult.fold(
          (l) => state = state.copyWith(errorMessage: l),
          (_) {
        final updatedTasks = state.tasks?.where((task) => task.id != taskId).toList();
        state = state.copyWith(tasks: updatedTasks);
        onResult(successMessage: "Tarea eliminada correctamente");
      },
    );
  }

  Future<void> getTaskById({required int userId, required int taskId}) async {
    state = state.copyWith(isLoading: true);

    final taskEither = await ref.read(getLocalTaskByIdUseCase).call(userId: userId, taskId: taskId);

    taskEither.fold(
          (l) => state = state.copyWith(isLoading: false, errorMessage: l),
          (task) {
        state = state.copyWith(taskDetail: task, isLoading: false);
      },
    );
  }

  Future<void> updateTask({required int userId, required TaskEntity updatedTask,
    required Function({String? successMessage, String? errorMessage}) onResult,}) async {
    state = state.copyWith(isLoading: true);

    final result = await ref.read(updateLocalTaskUseCase).call(userId: userId, taskEntity: updatedTask);
    result.fold(
          (error) {state = state.copyWith(isLoading: false, errorMessage: error);
            onResult(errorMessage: "Error al guardar la tarea: $error");},
          (_) {
        final updatedTasks = state.tasks?.map((task) {
          return task.id == updatedTask.id ? updatedTask : task;
        }).toList();
        state = state.copyWith(tasks: updatedTasks, isLoading: false);
        onResult(successMessage: "Tarea actualizada correctamente");
      },
    );
  }


}

final userTaskProvider =
    StateNotifierProvider.autoDispose<UserTasksProvider, TaskState>(
  (ref) => UserTasksProvider(ref),
);
