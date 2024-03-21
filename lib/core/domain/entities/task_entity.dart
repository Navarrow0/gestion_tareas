
part of 'entities.dart';

class TaskEntity {
  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  TaskEntity({this.userId, this.id, this.title, this.completed});


  LocalTaskModel toModel() {
    return LocalTaskModel(
      userId: userId,
      id: id,
      title: title,
      completed: completed,
    );
  }

  TaskEntity copyWith({
    int? userId,
    int? id,
    String? title,
    bool? completed,
  }) {
    return TaskEntity(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
