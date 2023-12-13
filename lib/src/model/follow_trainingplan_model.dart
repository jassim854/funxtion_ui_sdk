import 'package:hive/hive.dart';

import '../../ui_tool_kit.dart';
part 'follow_trainingplan_model.g.dart';

@HiveType(typeId: 0)
class FollowTrainingplanModel extends HiveObject {
  @HiveField(0)
  String trainingplanId;
  @HiveField(1)
  String? workoutId;
  @HiveField(2)
  int? workoutCount;
  @HiveField(3)
  int? totalWorkoutLength;
  @HiveField(4)
  bool? outOfSequence;
  FollowTrainingplanModel(
      {required this.trainingplanId,
      this.workoutId,
      this.workoutCount,
      this.totalWorkoutLength,
      this.outOfSequence});

  // @override
  // String toString() {
  //   return 'trainingplan id : $trainingplanId ,current workout no : $workoutCount , total workout no : $totalWorkoutLength ';
  // }
}
