// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_content_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentSearchLocalModelAdapter
    extends TypeAdapter<RecentSearchLocalModel> {
  @override
  final int typeId = 1;

  @override
  RecentSearchLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentSearchLocalModel(
      recentSearch: (fields[0] as Map).cast<DateTime, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecentSearchLocalModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.recentSearch);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentSearchLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecentlyVisitedLocalModelAdapter
    extends TypeAdapter<RecentlyVisitedLocalModel> {
  @override
  final int typeId = 2;

  @override
  RecentlyVisitedLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentlyVisitedLocalModel(
      recentlyVisited: (fields[0] as Map).cast<DateTime, Resu>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecentlyVisitedLocalModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.recentlyVisited);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyVisitedLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResuAdapter extends TypeAdapter<Resu> {
  @override
  final int typeId = 3;

  @override
  Resu read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Resu(
      collection: fields[0] as LocalCategoryName?,
      matchScore: fields[1] as double?,
      entityId: fields[2] as String?,
      title: fields[3] as String?,
      duration: fields[4] as int?,
      categories: (fields[5] as List?)?.cast<String>(),
      goals: (fields[6] as List?)?.cast<String>(),
      level: fields[7] as String?,
      image: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Resu obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.collection)
      ..writeByte(1)
      ..write(obj.matchScore)
      ..writeByte(2)
      ..write(obj.entityId)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.categories)
      ..writeByte(6)
      ..write(obj.goals)
      ..writeByte(7)
      ..write(obj.level)
      ..writeByte(8)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResuAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocalCategoryNameAdapter extends TypeAdapter<LocalCategoryName> {
  @override
  final int typeId = 4;

  @override
  LocalCategoryName read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LocalCategoryName.videoClasses;
      case 1:
        return LocalCategoryName.workouts;
      case 2:
        return LocalCategoryName.trainingPlans;
      case 3:
        return LocalCategoryName.audioClasses;
      default:
        return LocalCategoryName.videoClasses;
    }
  }

  @override
  void write(BinaryWriter writer, LocalCategoryName obj) {
    switch (obj) {
      case LocalCategoryName.videoClasses:
        writer.writeByte(0);
        break;
      case LocalCategoryName.workouts:
        writer.writeByte(1);
        break;
      case LocalCategoryName.trainingPlans:
        writer.writeByte(2);
        break;
      case LocalCategoryName.audioClasses:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalCategoryNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
