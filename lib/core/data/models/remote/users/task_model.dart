import 'package:gestion_tareas/core/domain/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  TaskModel({this.userId, this.id, this.title, this.completed});

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}

extension TaskModelExtension on TaskModel {
  TaskEntity toEntity() {
    return TaskEntity(
      userId: userId,
      id: id,
      title: title,
      completed: completed
    );
  }
}