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

  static shedulePlanFn(context,
      {required ValueNotifier<bool> shedulePlanLoader,
      required List<WorkoutModel?> listSheduleWorkoutData,
      required TrainingPlanModel? trainingPlanData,
      required ValueNotifier<int> weekIndex}) async {
    shedulePlanLoader.value = true;
    listSheduleWorkoutData.clear();
    for (int j = 0; j < trainingPlanData!.weeks!.length; j++) {
      for (int i = 0; i < trainingPlanData.weeks![j].days.length.toInt(); i++) {
        try {
          await WorkoutRequest.workoutById(
                  id: trainingPlanData
                      .weeks![weekIndex.value].days[i].activities.first.id)
              .then((value) {
            if (value != null) {
              WorkoutModel data = WorkoutModel.fromJson(value);
              listSheduleWorkoutData.add(data);
            }
          });
        } on RequestException catch (e) {
          BaseHelper.showSnackBar(context, e.message);
        }
      }
    }

    shedulePlanLoader.value = false;

    return;
  }

  static Future<FitnessGoalModel?> getGoal(context,
      {required TrainingPlanModel? trainingPlanData}) async {
    try {
      Map<String, dynamic>? fetchData =
          await FitnessGoalRequest.fitnessGoalById(
              id: trainingPlanData?.goals.first.toString() ?? '');
      if (fetchData != null) {
        return FitnessGoalModel.fromJson(fetchData);
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
      print(e.response);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> getFitnessType(
      context, String id) async {
    Map<String, dynamic>? fetchData;
    try {
      await FitnessActivityTypeRequest.ftinessActivityTypeById(id: id)
          .then((value) {
        if (value != null) {
          fetchData = value;
        }
      });
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
      print(e.response);
    }
    return fetchData;
  }

  // static String fitnessType(context, String id) {
  //   FitnessActivityTypeModel? data;

  //   getFitnessType(context, id).then((value) {
  //     data = value as FitnessActivityTypeModel;
  //   });
  //   return data?.name ?? "";
  // }
}
