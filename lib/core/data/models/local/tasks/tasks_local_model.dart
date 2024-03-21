import 'package:gestion_tareas/core/domain/entities/entities.dart';
import 'package:hive/hive.dart';

part 'tasks_local_model.g.dart';


@HiveType(typeId: 0)
class LocalUserTasks extends HiveObject {
  @HiveField(0)
  final int userId;

  @HiveField(1)
  final List<LocalTaskModel> tasks;

  LocalUserTasks({required this.userId, required this.tasks});
}


@HiveType(typeId: 1)
class LocalTaskModel extends HiveObject {
  @HiveField(0)
  final int? userId;

  @HiveField(1)
  final int? id;

  @HiveField(2)
  final String? title;

  @HiveField(3)
  final bool? completed;

  LocalTaskModel({this.userId, this.id, this.title, this.completed});

  TaskEntity toEntity() {
    return TaskEntity(
        userId: userId,
        id: id,
        title: title,
        completed: completed
    );
  }

}