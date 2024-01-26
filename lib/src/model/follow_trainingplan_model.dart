import 'package:hive/hive.dart';
part 'follow_trainingplan_model.g.dart';

@HiveType(typeId: 0)
class FollowTrainingplanModel extends HiveObject {
  @HiveField(0)
  String trainingplanId;
  @HiveField(1)
  List<Map<String, String>> workoutData = [];

  @HiveField(2)
  int workoutCount;
  @HiveField(3)
  int totalWorkoutLength;
  @HiveField(4)
  bool outOfSequence;
  @HiveField(5)
  String trainingPlanTitle;
  @HiveField(6)
  String trainingPlanImg;
  @HiveField(7)
  String goalsId;
  @HiveField(8)
  String levelName;
  @HiveField(9)
  String location;
  @HiveField(10)
  String daysPerWeek;

  FollowTrainingplanModel({
    required this.trainingplanId,
    required this.workoutData,
    required this.workoutCount,
    required this.totalWorkoutLength,
    required this.outOfSequence,
    required this.trainingPlanImg,
    required this.trainingPlanTitle,
    required this.daysPerWeek,
    required this.goalsId,
    required this.levelName,
    required this.location,
  });

  // @override
  // String toString() {
  //   return 'trainingplan id : $trainingplanId ,current workout no : $workoutCount , total workout no : $totalWorkoutLength ';
  // }
}
