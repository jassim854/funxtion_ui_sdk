import 'package:hive/hive.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';
part 'search_content_local_model.g.dart';

@HiveType(typeId: 1)
class RecentSearchLocalModel extends HiveObject {
  @HiveField(0)
  Map<DateTime, String> recentSearch = {};

  RecentSearchLocalModel({
    required this.recentSearch,
  });
}

@HiveType(typeId: 2)
class RecentlyVisitedLocalModel extends HiveObject {
  @HiveField(0)
  Map<DateTime, Resu> recentlyVisited = {};

  RecentlyVisitedLocalModel({
    required this.recentlyVisited,
  });
}

@HiveType(typeId: 3)
class Resu extends HiveObject {
  @HiveField(0)
  LocalCategoryName? collection;
  @HiveField(1)
  double? matchScore;
  @HiveField(2)
  String? entityId;
  @HiveField(3)
  String? title;
  @HiveField(4)
  int? duration;
  @HiveField(5)
  List<String>? categories;
  @HiveField(6)
  List<String>? goals;
  @HiveField(7)
  String? level;
  @HiveField(8)
  String? image;

  Resu({
    this.collection ,
    this.matchScore,
    this.entityId,
    this.title,
    this.duration,
    this.categories,
    this.goals,
    this.level,
    this.image,
  });
}

@HiveType(typeId: 4)
enum LocalCategoryName {
  @HiveField(0)
  videoClasses,
  @HiveField(1)
  workouts,
  @HiveField(2)
  trainingPlans,
  @HiveField(3)
  audioClasses,

}
