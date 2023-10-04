import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

class WorkoutDetailController {
  static Future<WorkoutModel?> getworkoutData(context,
      {required String id}) async {
    try {
      WorkoutModel fetcheddata =
          await WorkoutRequest.workoutById(id: id) as WorkoutModel;
      return fetcheddata;
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    return null;
  }

  static Future<ExerciseModel?> getExercise(String id) async {
    ExerciseModel exerciseModel =
        await ExerciseRequest.exerciseById(id: id) as ExerciseModel;
    return exerciseModel;
  }

  static Future<FitnessGoalModel?> getGoal(context, String id) async {
    try {
      return await FitnessGoalRequest.fitnessGoalById(id: id)
          as FitnessGoalModel;
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
      print(e.response);
    }
    return null;
  }

  static Future<BodyPartModel?> getBodyPart(context, String id) async {
    try {
      return await BodyPartsRequest.bodyPartById(id: id) as BodyPartModel;
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
      print(e.response);
    }
    return null;
  }

  static  getWarmUpData(context,
      {required ValueNotifier<bool> warmUpLoader,
      required WorkoutModel? workoutData,
      required List<ExerciseModel> exerciseData}) async {
    warmUpLoader.value = true;
    exerciseData.clear();
    for (var i = 0;
        i < workoutData!.phases![0].items.first.seExercises!.length;
        i++) {
      try {
        await ExerciseRequest.exerciseById(
                id: workoutData
                    .phases![0].items.first.seExercises![i].exerciseId)
            .then((value) {
          if (value != null) {
            exerciseData.add(value);
          }
        });
      } on RequestException catch (e) {
        BaseHelper.showSnackBar(context, e.message);
      }
    }
    warmUpLoader.value = false;
  }

  static getTrainingData(context,
      {required ValueNotifier<bool> trainingLoader,
      required WorkoutModel? workoutData,
      required List<ExerciseModel> exerciseWorkoutData}) async {
    trainingLoader.value = true;
    exerciseWorkoutData.clear();
    for (var i = 0;
        i <
            workoutData!
                .phases![1].items.first.ctRounds!.first.exercises.length;
        i++) {
      try {
        await ExerciseRequest.exerciseById(
                id: workoutData.phases?[1].items.first.ctRounds?.first
                        .exercises[i].exerciseId ??
                    "")
            .then((value) {
          if (value != null) {
            exerciseWorkoutData.add(value);
          }
        });
      } on RequestException catch (e) {
        BaseHelper.showSnackBar(context, e.message);
      }
    }
    trainingLoader.value = false;
  }

  static getTrainingData2(context,
      {required ValueNotifier<bool> trainingLoader,
      required WorkoutModel? workoutData,
      required List<ExerciseModel> exerciseWorkoutData}) async {
    trainingLoader.value = true;
    exerciseWorkoutData.clear();
    for (var i = 0;
        i < workoutData!.phases![1].items.first.rftExercises!.length;
        i++) {
      try {
        await ExerciseRequest.exerciseById(
                id: workoutData
                        .phases?[1].items.first.rftExercises?[i].exerciseId ??
                    "")
            .then((value) {
          if (value != null) {
            exerciseWorkoutData.add(value);
          }
        });
      } on RequestException catch (e) {
        BaseHelper.showSnackBar(context, e.message);
      }
    }
    trainingLoader.value = false;
  }
}
