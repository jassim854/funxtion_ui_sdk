import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class DashBoardController {
  static getData(BuildContext context,
      {required ValueNotifier<bool> isLoading,
      required Map<int, String> workoutDataType,
      required Map<int, String> videoDataType,
      required Map<int, String> audioDataType,
      required List<OnDemandModel> onDemadDataVideo,
      required List<OnDemandModel> audioData,
      required List<WorkoutModel> workoutData,
      required List<TrainingPlanModel> trainingPlanData,
      required Map<int, String> filterFitnessGoalData}) async {
    isLoading.value = true;

    await CommonController.getListCategoryTypeDataFn(
      context,
    );
    await CommonController.getListGoalData(context);
    await CommonController.getOnDemandContentCategoryFn(context);
    try {
      await CategoryListController.getListTrainingPlanData(context,
              confirmedFilter: ValueNotifier([]), limitContentPerPage: "4")
          .then((value) {
        if (value != null && context.mounted) {
          trainingPlanData.addAll(value);
        }
      });
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
    try {
      await CategoryListController.getListOnDemandData(context,
              confirmedFilter: ValueNotifier([]), limitContentPerPage: '4')
          .then((value) async {
        if (value != null && context.mounted) {
          onDemadDataVideo.addAll(value);
        }
      });
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    try {
      await CategoryListController.getListOnDemandAudioData(context,
              confirmedFilter: ValueNotifier([]), limitContentPerPage: "4")
          .then((value) async {
        if (value != null && context.mounted) {
          audioData.addAll(value);
        }
      });
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    try {
      await CategoryListController.getListWorkoutData(context,
              confirmedFilter: ValueNotifier([]), limitContentPerPage: "4")
          .then((value) async {
        if (value != null && context.mounted) {
          workoutData.addAll(value);
        }
      });
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
    CommonController.getFilterFitnessGoalData(context,
        shouldBreakLoop: false,
        trainingPlanData: trainingPlanData,
        filterFitnessGoalData: filterFitnessGoalData);
    CommonController.getListFilterOnDemandCategoryTypeFn(
        0, audioData, audioDataType);
    CommonController.getListFilterOnDemandCategoryTypeFn(
        0, onDemadDataVideo, videoDataType);
    CommonController.filterCategoryTypeData(workoutData, workoutDataType);
    isLoading.value = false;
  }
}
