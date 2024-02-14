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
      workoutData: (fields[1] as List).cast<LocalWorkout>(),
      workoutCount: fields[2] as int,
      totalWorkoutLength: fields[3] as int,
      outOfSequence: fields[4] as bool,
      trainingPlanImg: fields[6] as String,
      trainingPlanTitle: fields[5] as String,
      daysPerWeek: fields[10] as String,
      goalsId: fields[7] as String,
      levelName: fields[8] as String,
      location: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FollowTrainingplanModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.trainingplanId)
      ..writeByte(1)
      ..write(obj.workoutData)
      ..writeByte(2)
      ..write(obj.workoutCount)
      ..writeByte(3)
      ..write(obj.totalWorkoutLength)
      ..writeByte(4)
      ..write(obj.outOfSequence)
      ..writeByte(5)
      ..write(obj.trainingPlanTitle)
      ..writeByte(6)
      ..write(obj.trainingPlanImg)
      ..writeByte(7)
      ..write(obj.goalsId)
      ..writeByte(8)
      ..write(obj.levelName)
      ..writeByte(9)
      ..write(obj.location)
      ..writeByte(10)
      ..write(obj.daysPerWeek);
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

class LocalWorkoutAdapter extends TypeAdapter<LocalWorkout> {
  @override
  final int typeId = 1;

  @override
  LocalWorkout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalWorkout(
      workoutTitle: fields[0] as String,
      workoutSubtitle: fields[1] as String,
      workoutId: fields[2] as String,
      workoutImg: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocalWorkout obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.workoutTitle)
      ..writeByte(1)
      ..write(obj.workoutSubtitle)
      ..writeByte(2)
      ..write(obj.workoutId)
      ..writeByte(3)
      ..write(obj.workoutImg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalWorkoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
