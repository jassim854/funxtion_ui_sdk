import 'dart:developer';

import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

class CommonController {
  static List<ContentProvidersCategoryOnDemandModel> categoryTypeData = [];
  static List<ContentProvidersCategoryOnDemandModel> onDemandCategoryData = [];

  static Future getListGoalData(
      context,
      int count,
      List<TrainingPlanModel> trainingPlanData,
      bool shouldBreakLoop,
      Map<int, String> fitnessGoalData) async {


    List<FitnessGoalModel> listOfFitnessGoal = [];
    for (var j = 0; j < trainingPlanData.length; j++) {
      listOfFitnessGoal.clear();
      for (var i = 0; i < trainingPlanData[j].goals.length; i++) {
        try {
          await FitnessGoalRequest.fitnessGoalById(
                  id: trainingPlanData[j].goals[i].toString())
              .then((value) {
            if (value != null) {
              FitnessGoalModel fetchData = FitnessGoalModel.fromJson(value);
              listOfFitnessGoal.add(fetchData);
            }
          });
        } on RequestException catch (e) {
          BaseHelper.showSnackBar(context, e.message);
        }
        if (shouldBreakLoop == true) {
          break;
        }
      }

      if (shouldBreakLoop == true) {
        break;
      }
      fitnessGoalData
          .addAll({count + j: listOfFitnessGoal.map((e) => e.name).join(',')});
    }
  }

  static getListCategoryTypeDataFn(
    context,
  ) async {
    try {
      await ContentProviderCategoryOnDemandRequest.contentCategory()
          .then((value) {
        List<ContentProvidersCategoryOnDemandModel> fetchData = List.from(value!
            .map((e) => ContentProvidersCategoryOnDemandModel.fromJson(e)));
        for (var i = 0; i <= 50; i++) {
          categoryTypeData.add(fetchData[i]);
        }
      });
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
  }

  static filterCategoryTypeData(
      List<WorkoutModel> workoutData, Map<int, String> categoryFilterTypeData) {
    List<ContentProvidersCategoryOnDemandModel> data = [];
    int currentI = categoryFilterTypeData.length;
    for (var i = 0; i < workoutData.length; i++) {
      data.clear();
      for (var typeElement in workoutData[i].types!) {
        for (var j = 0; j < categoryTypeData.length; j++) {
          if (categoryTypeData[j].id == typeElement) {
            data.add(categoryTypeData[j]);
          }
        }
      }

      categoryFilterTypeData
          .addAll({currentI + i: data.map((e) => e.name).join(',')});
    }
  }

  static getOnDemandContentCategoryFn(context) async {
    try {
      await ContentProviderCategoryOnDemandRequest.onDemandCategory()
          .then((data) {
        List<ContentProvidersCategoryOnDemandModel> fetchCategoryData =
            List.from(data!
                .map((e) => ContentProvidersCategoryOnDemandModel.fromJson(e)));
        onDemandCategoryData.addAll(fetchCategoryData);
      });
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
  }

  static getListFilterOnDemandCategoryTypeFn(
    int count,
      List<OnDemandModel> value, Map<int, String> onDemandCategoryFilterData) {


    for (var i = 0; i < value.length; i++) {
      List<ContentProvidersCategoryOnDemandModel> data = [];
      for (var typeElement in value[i].categories!) {
        for (var j = 0;
            j <
                (onDemandCategoryData.length > 50
                    ? 50
                    : onDemandCategoryData.length);
            j++) {
          if (onDemandCategoryData[j].id.toString() == typeElement) {
            data.add(onDemandCategoryData[j]);
          }
        }
      } 

      onDemandCategoryFilterData.addAll({count+ i: data.map((e) => e.name).join(',')});
    } 
  }
}
