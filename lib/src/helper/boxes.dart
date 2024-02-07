import 'package:hive/hive.dart';


import 'package:ui_tool_kit/ui_tool_kit.dart';

class Boxes {
  static Box<FollowTrainingplanModel> getTrainingPlanBox() =>
      Hive.box<FollowTrainingplanModel>('trainingplan');
  static Box<RecentSearchLocalModel> getRecentSearchBox() =>
      Hive.box<RecentSearchLocalModel>('recentSearch');
  static Box<RecentlyVisitedLocalModel>   getRecentlyVisitedBox() =>
      Hive.box<RecentlyVisitedLocalModel>('recentlyVisited');
}
