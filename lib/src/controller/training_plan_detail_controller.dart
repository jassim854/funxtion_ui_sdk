import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

class TrainingPlanDetailController {
  static Future<TrainingPlanModel?> getTrainingPlanData(context,
      {required String id}) async {
    try {
      Map<String, dynamic>? fetcheddata =
          await TrainingPlanRequest.trainingPlanById(id: id);
      if (fetcheddata != null) {
        return TrainingPlanModel.fromJson(fetcheddata);
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    return null;
  }

  static int daysPerWeek = 0;
  static shedulePlanFn(context,
      {required ValueNotifier<bool> shedulePlanLoader,
      required List<WorkoutModel?> listSheduleWorkoutData,
      required TrainingPlanModel? trainingPlanData,
      required ValueNotifier<int> weekIndex}) async {
    shedulePlanLoader.value = true;
    listSheduleWorkoutData.clear();
    for (int j = 0; j < trainingPlanData!.weeks!.length; j++) {
      daysPerWeek = 0;
      for (int i = 0; i < trainingPlanData.weeks![j].days.length; i++) {
        try {
          await WorkoutRequest.workoutById(
                  id: trainingPlanData.weeks?[j].days[i].activities.first.id
                          .toString() ??
                      "")
              .then((value) {
            if (value != null) {
              WorkoutModel data = WorkoutModel.fromJson(value);
              listSheduleWorkoutData.add(data);
            }
          });
        } on RequestException catch (e) {
          BaseHelper.showSnackBar(context, e.message);
        }
        daysPerWeek = i + 1;
      }
    }

    shedulePlanLoader.value = false;

    return;
  }

  // static Future<Map<String, dynamic>?> getFitnessType(
  //     context, String id) async {
  //   Map<String, dynamic>? fetchData;
  //   try {
  //     await FitnessActivityTypeRequest.ftinessActivityTypeById(id: id)
  //         .then((value) {
  //       if (value != null) {
  //         fetchData = value;
  //       }
  //     });
  //   } on RequestException catch (e) {
  //     BaseHelper.showSnackBar(context, e.message);

  //   }
  //   return fetchData;
  // }
}
