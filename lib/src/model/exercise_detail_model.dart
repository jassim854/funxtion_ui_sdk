import 'package:ui_tool_kit/ui_tool_kit.dart';

class ExerciseDetailModel {
  ItemType exerciseCategoryName;
  int exerciseNo;
  int? setsCount;
  String? exerciseNotes;
  String? mainNotes;
  List<SetGoalTargetAndResistentTarget>? goalTargets;
  List<SetGoalTargetAndResistentTarget>? resistanceTargets;
  int? mainRest;
  int? mainSets;
  int? mainRestRound;
  int? mainWork;
  int? inSetRest;
  int? rftRounds;
    int? amrapDuration;
      int? emomRest;
  ExerciseDetailModel(
      {required this.exerciseCategoryName,
      required this.exerciseNo,
      this.mainNotes,
      this.setsCount,
      this.exerciseNotes,
      this.rftRounds,
      this.inSetRest,
      this.mainRest,
      this.mainRestRound,
      this.mainSets,
      this.mainWork,
      this.goalTargets,
      this.resistanceTargets,
      this.amrapDuration,
      this.emomRest
      });

  @override
  String toString() {
    return "exerciseCategoryName : $exerciseCategoryName , exerciseNo : $exerciseNo , amrapDuration : $amrapDuration , emomRest : $emomRest ,  setsCount : $setsCount notexerciseNoteses : $exerciseNotes ,  mainNotes : $mainNotes , resistanceTargets : $resistanceTargets , goalTargets : $goalTargets , rftRounds : $rftRounds   inSetRest ; $inSetRest ,  mainRest : $mainRest , mainRestRound : $mainRestRound , mainSets : $mainSets, mainWork : $mainWork ";
  }
}
