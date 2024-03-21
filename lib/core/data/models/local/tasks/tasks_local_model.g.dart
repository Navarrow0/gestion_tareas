// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalUserTasksAdapter extends TypeAdapter<LocalUserTasks> {
  @override
  final int typeId = 0;

  @override
  LocalUserTasks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalUserTasks(
      userId: fields[0] as int,
      tasks: (fields[1] as List).cast<LocalTaskModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, LocalUserTasks obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.tasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalUserTasksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocalTaskModelAdapter extends TypeAdapter<LocalTaskModel> {
  @override
  final int typeId = 1;

  @override
  LocalTaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalTaskModel(
      userId: fields[0] as int?,
      id: fields[1] as int?,
      title: fields[2] as String?,
      completed: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalTaskModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalTaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
