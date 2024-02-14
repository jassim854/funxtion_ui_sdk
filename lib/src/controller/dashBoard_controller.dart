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
    if (context.mounted) {
      await CommonController.getListGoalData(context);
    }
    if (context.mounted) {
      await CommonController.getOnDemandContentCategoryFn(context);
    }
    try {
      if (context.mounted) {
        await ListController.getListTrainingPlanData(context,
                pageNumber:0,
                confirmedFilter: ValueNotifier([]),
                limitContentPerPage: 4)
            .then((value) {
          if (value != null && context.mounted) {
            trainingPlanData.addAll(value);
          }
        });
      }
    } on RequestException catch (e) {
      if (context.mounted) {
        BaseHelper.showSnackBar(context, e.message);
      }
    }
    try {
      if (context.mounted) {
        await ListController.getListOnDemandData(context,
                pageNumber: 0,
                confirmedFilter: ValueNotifier([]),
                limitContentPerPage: 4)
            .then((value) async {
          if (value != null && context.mounted) {
            onDemadDataVideo.addAll(value);
          }
        });
      }
    } on RequestException catch (e) {
      if (context.mounted) {
        BaseHelper.showSnackBar(context, e.message);
      }
    }

    try {
      if (context.mounted) {
        await ListController.getListOnDemandAudioData(context,
                pageNumber: 0,
                confirmedFilter: ValueNotifier([]),
                limitContentPerPage: 4)
            .then((value) async {
          if (value != null && context.mounted) {
            audioData.addAll(value);
          }
        });
      }
    } on RequestException catch (e) {
      if (context.mounted) {
        BaseHelper.showSnackBar(context, e.message);
      }
    }

    try {
      if (context.mounted) {
        await ListController.getListWorkoutData(context,
                pageNumber: 0,
                confirmedFilter: ValueNotifier([]),
                limitContentPerPage:4)
            .then((value) async {
          if (value != null && context.mounted) {
            workoutData.addAll(value);
          }
        });
      }
    } on RequestException catch (e) {
      if (context.mounted) {
        BaseHelper.showSnackBar(context, e.message);
      }
    }
    if (context.mounted) {
      CommonController.getFilterFitnessGoalData(context,
          shouldBreakLoop: false,
          trainingPlanData: trainingPlanData,
          filterFitnessGoalData: filterFitnessGoalData);
    }

    CommonController.getListFilterOnDemandCategoryTypeFn(
        0, audioData, audioDataType);
    CommonController.getListFilterOnDemandCategoryTypeFn(
        0, onDemadDataVideo, videoDataType);
    CommonController.filterCategoryTypeData(workoutData, workoutDataType);
    if (CommonController.equipmentListData.isEmpty) {
      CommonController.getListEquipmentData(context);
    }
    isLoading.value = false;
  }
}
