import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ui_tool_kit/src/model/follow_trainingplan_model.dart';

class PkgAppController {
  static getPath({required ValueNotifier isInitlize}) async {
    isInitlize.value=false;
    await getApplicationDocumentsDirectory().then((value) async {
      Hive.init(value.path);
      // Hive.deleteBoxFromDisk("trainingplan");
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(FollowTrainingplanModelAdapter());
      }
      if (!Hive.isBoxOpen("trainingplan")) {
        await Hive.openBox<FollowTrainingplanModel>("trainingplan");
      }
    });
    isInitlize.value=true;
  }
}
