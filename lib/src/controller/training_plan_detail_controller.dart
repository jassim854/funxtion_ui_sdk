import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

class TrainingPlanDetailController {
 
  static Future<TrainingPlanModel?> getTrainingPlanData(context,
      {required String id}) async {
    try {
      TrainingPlanModel fetcheddata =
          await TrainingPlanRequest.trainingPlanById(id: id)
              as TrainingPlanModel;
      return fetcheddata;
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    return null;
  }
static  shedulePlanFn(context, {required   ValueNotifier<bool> shedulePlanLoader,required   List<WorkoutModel?> listSheduleWorkoutData,required  TrainingPlanModel? trainingPlanData,required   ValueNotifier<int> weekIndex  }) async {
    shedulePlanLoader.value = true;
    listSheduleWorkoutData.clear();
    for (int i = 0;
        i < trainingPlanData!.weeks![weekIndex.value].days.length.toInt();
        i++) {
      await getWeekSheduleWorkout(
        context,
              trainingPlanData!
                  .weeks![weekIndex.value].days[i].activities.first.id)
          .then((value) {
        listSheduleWorkoutData.add(value);
      });
    }
    shedulePlanLoader.value = false;

    return;
  }



 static Future<FitnessGoalModel?> getGoal(context, {required TrainingPlanModel? trainingPlanData}) async {
    try {
      return await FitnessGoalRequest.fitnessGoalById(
              id: trainingPlanData?.goals.first.toString() ?? '')
          as FitnessGoalModel;
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
      print(e.response);
    }
    return null;
  }

 static Future<FitnessActivityTypeModel?> getFitnessType(context, String id) async {
    try {
      return await FitnessActivityTypeRequest.ftinessActivityTypeById(id: id);
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
      print(e.response);
    }
    return null;
  }

 static String fitnessType(context, String id) {
    FitnessActivityTypeModel? data;

    getFitnessType(context, id).then((value) {
      data = value as FitnessActivityTypeModel;
    });
    return data?.name ?? "";
  }

 static Future<WorkoutModel?> getWeekSheduleWorkout(context, String index) async {
    try {
      return await WorkoutRequest.workoutById(id: index);
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
      print(e.response);
    }
    return null;
  }
}
