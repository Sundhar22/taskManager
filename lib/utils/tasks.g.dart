// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TasksAdapter extends TypeAdapter<Tasks> {
  @override
  final int typeId = 0;

  @override
  Tasks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tasks(
      alarm: fields[7] as bool,
      tittle: fields[0] as String?,
      endTime: fields[2] as DateTime?,
      startTime: fields[1] as DateTime?,
      startDate: fields[3] as DateTime?,
      endDate: fields[4] as DateTime?,
      description: fields[5] as String?,
    )
      ..isComplete = fields[6] as bool
      ..toCallDeleted = fields[8] as bool;
  }

  @override
  void write(BinaryWriter writer, Tasks obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.tittle)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.isComplete)
      ..writeByte(8)
      ..write(obj.toCallDeleted)
      ..writeByte(7)
      ..write(obj.alarm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
