import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ui_tool_kit.dart';

class HiveLocalController {
  static openTrainingBox() async {
    await Hive.initFlutter();
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? getValue = pref.getBool("trainingplan");
    if (getValue == null) {
      await pref.setBool("trainingplan", true);
      await Hive.deleteBoxFromDisk("trainingplan");
    }

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(FollowTrainingplanModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(LocalWorkoutAdapter());
    }
    if (!Hive.isBoxOpen("trainingplan")) {
      await Hive.openBox<FollowTrainingplanModel>("trainingplan");
    }
  }

  static openSearchBox() async {
    await Hive.initFlutter();
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? getValue = pref.getBool("recentlyVisited");
    bool? getValue1 = pref.getBool("recentSearch");
    if (getValue == null) {
      await pref.setBool("recentlyVisited", true);
      await Hive.deleteBoxFromDisk("recentlyVisited");
    }
    if (getValue1 == null) {
      await pref.setBool("recentSearch", true);
      await Hive.deleteBoxFromDisk("recentSearch");
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(LocalResultAdapter());
    }
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(LocalCategoryNameAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(RecentSearchLocalModelAdapter());
    }
    if (!Hive.isBoxOpen("recentSearch")) {
      await Hive.openBox<RecentSearchLocalModel>("recentSearch");
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(
        RecentlyVisitedLocalModelAdapter(),
      );
    }

    if (!Hive.isBoxOpen("recentlyVisited")) {
      await Hive.openBox<RecentlyVisitedLocalModel>("recentlyVisited");
    }
  }
}
