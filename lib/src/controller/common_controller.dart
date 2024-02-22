import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

class CommonController {
  static List<ContentProvidersCategoryOnDemandModel> categoryTypeData = [];
  static List<ContentProvidersCategoryOnDemandModel> onDemandCategoryData = [];
  static List<FitnessGoalModel> listOfFitnessGoal = [];
  static List<EquipmentModel> equipmentListData = [];

  static getListEquipmentData(context) async {
    try {
      await EquipmentRequest.listOfEquipment().then((value) {
        if (value != null) {
          List<EquipmentModel> fetchData =
              List.from(value.map((e) => EquipmentModel.fromJson(e)));
          equipmentListData.addAll(fetchData);
        }
      });
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
  }

  static getEquipmentFilterData(
      {required List<int> equipmentIds,
      required List<EquipmentModel> filterEquipmentData}) {
    Set<int> newIdsList = {};
    newIdsList.addAll(equipmentIds);
    for (var i = 0; i < newIdsList.length; i++) {
      for (var j = 0; j < equipmentListData.length; j++) {
        if (newIdsList.toList()[i] == equipmentListData[j].id) {
          filterEquipmentData.add(equipmentListData[j]);
        }
      }
    }
  }

  static Future getListGoalData(
    context,
  ) async {
    try {
      await FitnessGoalRequest.listOfFitnessGoal().then((value) {
        if (value != null) {
          List<FitnessGoalModel> fetchData =
              List.from(value.map((e) => FitnessGoalModel.fromJson(e)));
          listOfFitnessGoal.addAll(fetchData);
        }
      });
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
  }

  static getFilterFitnessGoalData(context,
      {required bool shouldBreakLoop,
      List<TrainingPlanModel>? trainingPlanData,
      TrainingPlanModel? trainingData,
      WorkoutModel? workoutData,
      required Map<int, String> filterFitnessGoalData}) {
    List<FitnessGoalModel> tempList = [];
    int currentI = filterFitnessGoalData.length;
    if (trainingData != null) {
      for (var i = 0; i < trainingData.goals.length; i++) {
        for (var element in listOfFitnessGoal) {
          if (element.id == trainingData.goals[i]) {
            tempList.add(element);
          }
          if (shouldBreakLoop == true) {
            break;
          }
        }
        if (shouldBreakLoop == true) {
          break;
        }

        filterFitnessGoalData
            .addAll({0: tempList.map((e) => e.name).join(',')});
      }
    } else if (trainingPlanData != null) {
      for (var j = 0; j < trainingPlanData.length; j++) {
        tempList.clear();

        for (var i = 0; i < trainingPlanData[j].goals.length; i++) {
          for (var element in listOfFitnessGoal) {
            if (element.id == trainingPlanData[j].goals[i]) {
              tempList.add(element);
            }
          }

          if (shouldBreakLoop == true) {
            break;
          }
        }

        if (shouldBreakLoop == true) {
          break;
        }
        filterFitnessGoalData
            .addAll({currentI + j: tempList.map((e) => e.name).join(',')});
      }
    } else if (workoutData != null) {
      if (workoutData.goals != null) {
        for (var i = 0; i < workoutData.goals!.length; i++) {
          for (var element in listOfFitnessGoal) {
            if (element.id == workoutData.goals![i]) {
              tempList.add(element);
            }
            if (shouldBreakLoop == true) {
              break;
            }
          }
          if (shouldBreakLoop == true) {
            break;
          }

          filterFitnessGoalData
              .addAll({0: tempList.map((e) => e.name).join(',')});
        }
      }
    }
  }

  static getListCategoryTypeDataFn(
    context,
  ) async {
    if (categoryTypeData.isEmpty) {
      try {
        await ContentProviderCategoryOnDemandRequest.contentCategory()
            .then((value) {
          List<ContentProvidersCategoryOnDemandModel> fetchData = List.from(
              value!.map(
                  (e) => ContentProvidersCategoryOnDemandModel.fromJson(e)));

          categoryTypeData.addAll(fetchData);
        });
      } on RequestException catch (e) {
        BaseHelper.showSnackBar(context, e.message);
      }
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

  static getListFilterOnDemandCategoryTypeFn(int count,
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

      onDemandCategoryFilterData
          .addAll({count + i: data.map((e) => e.name).join(',')});
    }
  }
}
