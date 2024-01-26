
import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ui_tool_kit/src/model/follow_trainingplan_model.dart';


class PkgAppController {
  static getPath() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    // Hive.deleteBoxFromDisk("trainingplan");
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(FollowTrainingplanModelAdapter());
    }
    if (!Hive.isBoxOpen("trainingplan")) {
      await Hive.openBox<FollowTrainingplanModel>("trainingplan");
    }

    log(directory.path);
  }
  
}
