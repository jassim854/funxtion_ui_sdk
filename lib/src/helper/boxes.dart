import 'package:hive/hive.dart';
import 'package:ui_tool_kit/src/model/follow_trainingplan_model.dart';

class Boxes {
  static Box<FollowTrainingplanModel> getData() =>
      Hive.box<FollowTrainingplanModel>('trainingplan');
}
