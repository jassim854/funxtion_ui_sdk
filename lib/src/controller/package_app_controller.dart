


import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:ui_tool_kit/src/model/follow_trainingplan_model.dart';

class PkgAppController {
  static initHive() async {



    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(FollowTrainingplanModelAdapter());
    }
    if (!Hive.isBoxOpen("trainingplan")) {
      await Hive.openBox<FollowTrainingplanModel>("trainingplan");
    }


  }
}
