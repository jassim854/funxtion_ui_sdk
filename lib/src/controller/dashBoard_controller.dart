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
      required List<TrainingPlanModel> trainingPlanData}) async {
    isLoading.value = true;
    try {
      CategoryListController.getCategoryTypeDataFn(
          context, ValueNotifier(false));
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
    try {
      await CategoryListController.getListOnDemandData(context,
              confirmedFilter: ValueNotifier([]), limitContentPerPage: '4')
          .then((value) async {
        if (value != null && context.mounted) {
          onDemadDataVideo.addAll(value);
          getOnDemandContentCategoryData(value, videoDataType);
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

          getOnDemandContentCategoryData(value, audioDataType);
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
    addDataCategories(
      workoutData,
      workoutDataType,
    );
    isLoading.value = false;
  }

  static addDataCategories(
    List<WorkoutModel> workoutData,
    Map<int, String> typeData,
  ) {
    List<ContentProvidersCategoryOnDemandModel> data = [];
    if (data.isEmpty) {
      for (var i = 0; i < workoutData.length; i++) {
        data = [];
        for (var typeElement in workoutData[i].types!) {
          for (var j = 0;
              j < CategoryListController.categoryTypeData.length;
              j++) {
            if (CategoryListController.categoryTypeData[j].id == typeElement) {
              data.add(CategoryListController.categoryTypeData[j]);
            }
          }
        }

        typeData.addAll({i: data.map((e) => e.name).join(',')});
      }
    }
  }

  static getOnDemandContentCategoryData(
      List<OnDemandModel> value, Map<int, String> typeData) async {
    await ContentProviderCategoryOnDemandRequest.onDemandCategory()
        .then((data) {
      List<ContentProvidersCategoryOnDemandModel> fetchCategoryData = List.from(
          data!.map((e) => ContentProvidersCategoryOnDemandModel.fromJson(e)));
      for (var i = 0; i < value.length; i++) {
        List<ContentProvidersCategoryOnDemandModel> data = [];
        for (var typeElement in value[i].categories!) {
          for (var j = 0;
              j <
                  (fetchCategoryData.length > 50
                      ? 50
                      : fetchCategoryData.length);
              j++) {
            if (fetchCategoryData[j].id.toString() == typeElement) {
              data.add(fetchCategoryData[j]);
            }
          }
        }

        typeData.addAll({i: data.map((e) => e.name).join(',')});
      }
    });
  }
}
