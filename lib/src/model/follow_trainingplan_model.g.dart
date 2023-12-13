// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_trainingplan_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FollowTrainingplanModelAdapter
    extends TypeAdapter<FollowTrainingplanModel> {
  @override
  final int typeId = 0;

  @override
  FollowTrainingplanModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FollowTrainingplanModel(
      trainingplanId: fields[0] as String,
      workoutId: fields[1] as String?,
      workoutCount: fields[2] as int?,
      totalWorkoutLength: fields[3] as int?,
      outOfSequence: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, FollowTrainingplanModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.trainingplanId)
      ..writeByte(1)
      ..write(obj.workoutId)
      ..writeByte(2)
      ..write(obj.workoutCount)
      ..writeByte(3)
      ..write(obj.totalWorkoutLength)
      ..writeByte(4)
      ..write(obj.outOfSequence);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FollowTrainingplanModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
