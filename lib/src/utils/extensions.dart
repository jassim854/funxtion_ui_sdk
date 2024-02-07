import 'package:flutter/material.dart';
import 'package:ui_tool_kit/src/model/model.dart';

import '../../ui_tool_kit.dart';

extension SpaceExtension on num {
  height() {
    return SizedBox(
      height: toDouble(),
    );
  }

  width() {
    return SizedBox(
      width: toDouble(),
    );
  }
}

extension NavigationExtensions on BuildContext {
  void popPage({Object? result}) {
    return Navigator.of(this).pop(result);
  }

  void multiPopPage({required int popPageCount, Object? result}) {
    switch (popPageCount) {
      case 2:
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        break;
      case 3:
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        break;
      case 4:
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        break;
      case 5:
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        break;
      case 6:
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        break;
      case 7:
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        Navigator.of(this).pop(result);
        break;
      default:
        return;
    }
  }

  Future<bool> maybePopPage({Object? result}) {
    return Navigator.of(this).maybePop(result);
  }

  void navigateTo(
    Widget screen,
  ) {
    Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  void navigatepushReplacement(Widget screen) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(
      builder: (context) => screen,
    ));
  }

  void navigateToRemovedUntil(Widget screen) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => route.isFirst,
    );
  }
}

extension DynanicSizeExtension on BuildContext {
  double get dynamicHeight => MediaQuery.of(this).size.height;

  double get dynamicWidth => MediaQuery.of(this).size.width;
  Size get dynamicSize => MediaQuery.of(this).size;
}

extension HideKeypad on BuildContext {
  void hideKeypad() => FocusScope.of(this).unfocus();
}

extension OmitSymbolText on String {
  // getTextAfterSymbol() {
  //   int atIndex = indexOf('-');
  //   int lastAtIndex = lastIndexOf('-');

  //   if (atIndex != -1 && atIndex == lastAtIndex) {
  //     return substring(atIndex + 1);
  //   } else {
  //     return "";
  //   }
  // }

  String capitalizeFirst() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  // removeSymbolGetText() {
  //   int atIndex = indexOf('-');

  //   return "${substring(0, atIndex).capitalizeFirst()} ${substring(atIndex + 1).capitalizeFirst()}";
  // }
}

extension ImageExtension on int {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}

extension HMSextension on int {
  String get mordernDurationTextWidget =>
      "${Duration(seconds: this).inHours.remainder(60).toString()}:${Duration(seconds: this).inMinutes.remainder(60).toString().padLeft(2, '0')}:${Duration(seconds: this).inSeconds.remainder(60).toString().padLeft(2, '0')}";
}

extension HeaderTitle on Map<ExerciseDetailModel, ExerciseModel> {
  String currentHeaderTitle(int index) => entries
              .toList()[index]
              .key
              .exerciseCategoryName ==
          ItemType.singleExercise
      ? "Single Exercise"
      : entries.toList()[index].key.exerciseCategoryName == ItemType.circuitTime
          ? 'Circuit Time'
          : entries.toList()[index].key.exerciseCategoryName == ItemType.rft
              ? "RFT Exercises"
              : entries.toList()[index].key.exerciseCategoryName ==
                      ItemType.superSet
                  ? "Super Set"
                  : entries.toList()[index].key.exerciseCategoryName ==
                          ItemType.circuitRep
                      ? "Circuit Repetition"
                      : entries.toList()[index].key.exerciseCategoryName ==
                              ItemType.amrap
                          ? "AmRap"
                          : entries.toList()[index].key.exerciseCategoryName ==
                                  ItemType.enom
                              ? "Enom"
                              : '';

  String infoHeader(int index) => entries
              .toList()[index]
              .key
              .exerciseCategoryName ==
          ItemType.singleExercise
      ? "Exercises can be combined into multiple sets with different metrics connected to it."
      : entries.toList()[index].key.exerciseCategoryName == ItemType.circuitTime
          ? 'A time-based circuit is a combination of exercises performed with a prescribed work-rest interval. Each round can have a different work-rest interval and/or different exercises'
          : entries.toList()[index].key.exerciseCategoryName == ItemType.rft
              ? "RFT is short for 'rounds for time'. Participants need to complete the set amount of rounds and reps as soon as possible. A round is a sequence of all exercises. The time it takes the participants to complete the set number of rounds is their score"
              : entries.toList()[index].key.exerciseCategoryName ==
                      ItemType.superSet
                  ? "The concept of a superset is to perform 2 exercises back to back, followed by a short rest (but not always)."
                  : entries.toList()[index].key.exerciseCategoryName ==
                          ItemType.circuitRep
                      ? "A repetition-based circuit is a combination of exercises performed with short rest periods between them for a set number of repetitions. Each round can have a different number of reps, rest interval, and/or exercises."
                      : entries.toList()[index].key.exerciseCategoryName ==
                              ItemType.amrap
                          ? "AMRAP is short for 'as many reps as possible'. Participants need to complete as many repetitions of the given exercise sequence in a set amount of time. The total number of repetitions completed is the participant's score."
                          : entries.toList()[index].key.exerciseCategoryName ==
                                  ItemType.enom
                              ? " EMOM is short for 'every minute on the minute'. In this type of workout, the participant has to complete the exercises at the start of every minute for a set number of minutes. Each minute can have different exercises with different values."
                              : '';
  String currentHeaderSubTitle({
    required int index,
    required Map<ExerciseDetailModel, ExerciseModel> seExercise,
    required Map<ExerciseDetailModel, ExerciseModel> circuitTimeExercise,
    required Map<ExerciseDetailModel, ExerciseModel> rftExercise,
    required Map<ExerciseDetailModel, ExerciseModel> ssExercise,
    required Map<ExerciseDetailModel, ExerciseModel> circuitRepExercise,
    required Map<ExerciseDetailModel, ExerciseModel> amrapExercise,
    required Map<ExerciseDetailModel, ExerciseModel> enomExercise,
  }) =>
      entries.toList()[index].key.exerciseCategoryName ==
              ItemType.singleExercise
          ? "${seExercise.length} exercises"
          : entries.toList()[index].key.exerciseCategoryName ==
                  ItemType.circuitTime
              ? "${circuitTimeExercise.entries.toList()[circuitTimeExercise.length - 1].key.setsCount!.toInt() + 1} ${circuitTimeExercise.entries.toList()[circuitTimeExercise.length - 1].key.setsCount!.toInt() + 1 == 1 ? "round" : "round"} • ${circuitTimeExercise.length} exercises"
              : entries.toList()[index].key.exerciseCategoryName == ItemType.rft
                  ? "${rftExercise.length} exercises"
                  : entries.toList()[index].key.exerciseCategoryName ==
                          ItemType.superSet
                      ? "${ssExercise.entries.toList()[ssExercise.length - 1].key.setsCount!.toInt() + 1} ${ssExercise.entries.toList()[ssExercise.length - 1].key.setsCount!.toInt() + 1 == 1 ? "round" : "round"} • ${ssExercise.length} exercises"
                      : entries.toList()[index].key.exerciseCategoryName ==
                              ItemType.circuitRep
                          ? "${circuitRepExercise.entries.toList()[circuitRepExercise.length - 1].key.setsCount!.toInt() + 1} ${circuitRepExercise.entries.toList()[circuitRepExercise.length - 1].key.setsCount!.toInt() + 1 == 1 ? "round" : "round"} • ${circuitRepExercise.length} exercises"
                          : entries.toList()[index].key.exerciseCategoryName ==
                                  ItemType.amrap
                              ? "${amrapExercise.entries.toList()[amrapExercise.length - 1].key.setsCount!.toInt() + 1} ${amrapExercise.entries.toList()[amrapExercise.length - 1].key.setsCount!.toInt() + 1 == 1 ? "round" : "round"} • ${amrapExercise.length} exercises"
                              : entries
                                          .toList()[index]
                                          .key
                                          .exerciseCategoryName ==
                                      ItemType.enom
                                  ? "${enomExercise.entries.toList()[enomExercise.length - 1].key.setsCount!.toInt() + 1} ${enomExercise.entries.toList()[enomExercise.length - 1].key.setsCount!.toInt() + 1 == 1 ? "round" : "round"} • ${enomExercise.length} exercises"
                                  : '';
}

extension ExerciseSubTitle on ExerciseDetailModel {
  String get getGoalAndResistantTargets {
    if (goalTargets!.isNotEmpty && resistanceTargets!.isNotEmpty) {
      return "${goalTargets?.map((element) {
        if (element.type == GoalTargetType.value) {
          if (element.metric == Metric.weight) {
            return "${element.value?.toInt()} kg";
          }
          if (element.metric == Metric.angle) {
            return "${element.value?.toInt()} angle";
          }
          if (element.metric == Metric.distance) {
            return "${element.value?.toInt()} distance";
          }
          if (element.metric == Metric.duration) {
            return "${element.value?.toInt()} duration";
          }
          if (element.metric == Metric.height) {
            return "${element.value?.toInt()} height";
          }
          if (element.metric == Metric.irm) {
            return "${element.value?.toInt()} irm";
          }
          if (element.metric == Metric.level) {
            return "${element.value?.toInt()} level";
          }
          if (element.metric == Metric.repetitions) {
            return "${element.value?.toInt()} repetitions";
          }
          if (element.metric == Metric.watt) {
            return "${element.value?.toInt()} watt";
          }
        } else {
          if (element.metric == Metric.weight) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} kg";
          }
          if (element.metric == Metric.angle) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} angle";
          }
          if (element.metric == Metric.distance) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} distance";
          }
          if (element.metric == Metric.duration) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} duration";
          }
          if (element.metric == Metric.height) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} height";
          }
          if (element.metric == Metric.irm) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} irm";
          }
          if (element.metric == Metric.level) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} level";
          }
          if (element.metric == Metric.repetitions) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} repetitions";
          }
          if (element.metric == Metric.watt) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} watt";
          }
        }
      }).join(" • ")} ${resistanceTargets?.map((element) {
        if (element.type == GoalTargetType.value) {
          if (element.metric == Metric.weight) {
            return "${element.value?.toInt()} kg";
          }
          if (element.metric == Metric.angle) {
            return "${element.value?.toInt()} angle";
          }
          if (element.metric == Metric.distance) {
            return "${element.value?.toInt()} distance";
          }
          if (element.metric == Metric.duration) {
            return "${element.value?.toInt()} duration";
          }
          if (element.metric == Metric.height) {
            return "${element.value?.toInt()} height";
          }
          if (element.metric == Metric.irm) {
            return "${element.value?.toInt()} irm";
          }
          if (element.metric == Metric.level) {
            return "${element.value?.toInt()} level";
          }
          if (element.metric == Metric.repetitions) {
            return "${element.value?.toInt()} repetitions";
          }
          if (element.metric == Metric.watt) {
            return "${element.value?.toInt()} watt";
          }
        } else {
          if (element.metric == Metric.weight) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} kg";
          }
          if (element.metric == Metric.angle) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} angle";
          }
          if (element.metric == Metric.distance) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} distance";
          }
          if (element.metric == Metric.duration) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} duration";
          }
          if (element.metric == Metric.height) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} height";
          }
          if (element.metric == Metric.irm) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} irm";
          }
          if (element.metric == Metric.level) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} level";
          }
          if (element.metric == Metric.repetitions) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} repetitions";
          }
          if (element.metric == Metric.watt) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} watt";
          }
        }
      }).join(" • ")}";
    } else if (goalTargets!.isNotEmpty) {
      return "${goalTargets?.map((element) {
        if (element.type == GoalTargetType.value) {
          if (element.metric == Metric.weight) {
            return "${element.value?.toInt()} kg";
          }
          if (element.metric == Metric.angle) {
            return "${element.value?.toInt()} angle";
          }
          if (element.metric == Metric.distance) {
            return "${element.value?.toInt()} distance";
          }
          if (element.metric == Metric.duration) {
            return "${element.value?.toInt()} duration";
          }
          if (element.metric == Metric.height) {
            return "${element.value?.toInt()} height";
          }
          if (element.metric == Metric.irm) {
            return "${element.value?.toInt()} irm";
          }
          if (element.metric == Metric.level) {
            return "${element.value?.toInt()} level";
          }
          if (element.metric == Metric.repetitions) {
            return "${element.value?.toInt()} repetitions";
          }
          if (element.metric == Metric.watt) {
            return "${element.value?.toInt()} watt";
          }
        } else {
          if (element.metric == Metric.weight) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} kg";
          }
          if (element.metric == Metric.angle) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} angle";
          }
          if (element.metric == Metric.distance) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} distance";
          }
          if (element.metric == Metric.duration) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} duration";
          }
          if (element.metric == Metric.height) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} height";
          }
          if (element.metric == Metric.irm) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} irm";
          }
          if (element.metric == Metric.level) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} level";
          }
          if (element.metric == Metric.repetitions) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} repetitions";
          }
          if (element.metric == Metric.watt) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} watt";
          }
        }
      }).join(" • ")}";
    } else if (resistanceTargets!.isNotEmpty) {
      return "${resistanceTargets?.map((element) {
        if (element.type == GoalTargetType.value) {
          if (element.metric == Metric.weight) {
            return "${element.value?.toInt()} kg";
          }
          if (element.metric == Metric.angle) {
            return "${element.value?.toInt()} angle";
          }
          if (element.metric == Metric.distance) {
            return "${element.value?.toInt()} distance";
          }
          if (element.metric == Metric.duration) {
            return "${element.value?.toInt()} duration";
          }
          if (element.metric == Metric.height) {
            return "${element.value?.toInt()} height";
          }
          if (element.metric == Metric.irm) {
            return "${element.value?.toInt()} irm";
          }
          if (element.metric == Metric.level) {
            return "${element.value?.toInt()} level";
          }
          if (element.metric == Metric.repetitions) {
            return "${element.value?.toInt()} repetitions";
          }
          if (element.metric == Metric.watt) {
            return "${element.value?.toInt()} watt";
          }
        } else {
          if (element.metric == Metric.weight) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} kg";
          }
          if (element.metric == Metric.angle) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} angle";
          }
          if (element.metric == Metric.distance) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} distance";
          }
          if (element.metric == Metric.duration) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} duration";
          }
          if (element.metric == Metric.height) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} height";
          }
          if (element.metric == Metric.irm) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} irm";
          }
          if (element.metric == Metric.level) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} level";
          }
          if (element.metric == Metric.repetitions) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} repetitions";
          }
          if (element.metric == Metric.watt) {
            return "${element.min?.toInt()} - ${element.max?.toInt()} watt";
          }
        }
      }).join(" • ")}";
    } else {
      return "";
    }
  }
}

extension ResistanceTarget on ExerciseDetailModel {
  getResistanceTarget() {
    if (resistanceTargets?.isNotEmpty ?? false) {
      Map<String, String> data = {};
      for (var element in resistanceTargets!) {
        if (element.type == GoalTargetType.value) {
          if (element.metric == Metric.weight) {
            data.addAll({"kg": "${element.value?.toInt()}"});
          }
          if (element.metric == Metric.angle) {
            data.addAll({"angle": "${element.value?.toInt()}"});
          }
          if (element.metric == Metric.distance) {
            data.addAll({"distance": "${element.value?.toInt()}"});
          }
          if (element.metric == Metric.duration) {
            data.addAll({"duration": "${element.value?.toInt()}"});
          }
          if (element.metric == Metric.height) {
            data.addAll({"height": "${element.value?.toInt()}"});
          }
          if (element.metric == Metric.irm) {
            data.addAll({"irm": "${element.value?.toInt()}"});
          }
          if (element.metric == Metric.level) {
            data.addAll({"level": "${element.value?.toInt()}"});
          }
          if (element.metric == Metric.repetitions) {
            data.addAll({"repetitions": "${element.value?.toInt()}"});
          }

          if (element.metric == Metric.watt) {
            data.addAll({"watt": "${element.value?.toInt()}"});
          }
        } else {
          if (element.metric == Metric.weight) {
            "${element.min?.toInt()} - ${element.max?.toInt()} kg";

            data.addAll({
              "kg Range": "${element.min?.toInt()} - ${element.max?.toInt()}"
            });
          }
          if (element.metric == Metric.angle) {
            data.addAll({
              "angle Range": "${element.min?.toInt()} - ${element.max?.toInt()}"
            });
          }
          if (element.metric == Metric.distance) {
            data.addAll({
              "distance Range":
                  "${element.min?.toInt()} - ${element.max?.toInt()}"
            });
          }
          if (element.metric == Metric.duration) {
            data.addAll({
              "duration Range":
                  "${element.min?.toInt()} - ${element.max?.toInt()}"
            });
          }
          if (element.metric == Metric.height) {
            data.addAll({
              "height Range":
                  "${element.min?.toInt()} - ${element.max?.toInt()}"
            });
          }
          if (element.metric == Metric.irm) {
            data.addAll({
              "irm Range": "${element.min?.toInt()} - ${element.max?.toInt()}"
            });
          }
          if (element.metric == Metric.level) {
            data.addAll({
              "level Range": "${element.min?.toInt()} - ${element.max?.toInt()}"
            });
          }
          if (element.metric == Metric.repetitions) {
            data.addAll({
              "repetitions Range":
                  "${element.min?.toInt()} - ${element.max?.toInt()}"
            });
          }
          if (element.metric == Metric.watt) {
            data.addAll({
              "watt Range": "${element.min?.toInt()} - ${element.max?.toInt()}"
            });
          }
        }
      }
      return data;
    }
  }
}

extension ExtensionCategoryName on LocalCategoryName? {
  CategoryName getCategoryName() {
    if (this == LocalCategoryName.audioClasses) {
      return CategoryName.audioClasses;
    } else if (this == LocalCategoryName.videoClasses) {
      return CategoryName.videoClasses;
    } else if (this == LocalCategoryName.workouts) {
      return CategoryName.workouts;
    } else {
      return CategoryName.trainingPlans;
    }
  }
}

extension ExtensionLocalCategoryName on CategoryName? {
  LocalCategoryName getLocalCategoryName() {
    if (this == CategoryName.audioClasses) {
      return LocalCategoryName.audioClasses;
    } else if (this == CategoryName.videoClasses) {
      return LocalCategoryName.videoClasses;
    } else if (this == CategoryName.workouts) {
      return LocalCategoryName.workouts;
    } else {
      return LocalCategoryName.trainingPlans;
    }
  }
}
