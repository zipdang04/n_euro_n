// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exerciseInstance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseInstanceAdapter extends TypeAdapter<ExerciseInstance> {
  @override
  final int typeId = 0;

  @override
  ExerciseInstance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseInstance(
      id: fields[0] as int,
      exerciseName: fields[1] as String,
      score: fields[2] as int,
      dateTime: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseInstance obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.exerciseName)
      ..writeByte(2)
      ..write(obj.score)
      ..writeByte(3)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseInstanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
