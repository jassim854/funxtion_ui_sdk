import 'dart:async';

import 'package:flutter/material.dart';

import 'package:funxtion/funxtion_sdk.dart';
import 'package:hive/hive.dart';

import '../../ui_tool_kit.dart';

class ListController {
  static Future<List<OnDemandModel>?> getListOnDemandData(BuildContext context,
      {String? mainSearch,
      int? limitContentPerPage,
      required int pageNumber,
      required ValueNotifier<List<SelectedFilterModel>>
          confirmedFilter}) async {
    try {
      final fetcheddata = await OnDemandRequest.listOnDemand(
        queryParameters: {
          "filter[where][type][eq]": 'virtual-class',
          "filter[offset]": pageNumber,
          "filter[limit]": limitContentPerPage ?? 10,
          if (checkfilter('duration', confirmedFilter.value))
            "filter[where][duration][in]":
                searchFilter('duration', confirmedFilter.value),
          if (mainSearch != null) "filter[where][q][contains]": mainSearch,
          if (checkfilter("level", confirmedFilter.value))
            "filter[where][level][in]":
                searchFilter('level', confirmedFilter.value),
          if (checkfilter('categories', confirmedFilter.value))
            "filter[where][categories][in]":
                searchFilter('categories', confirmedFilter.value),
          if (checkfilter('equipment', confirmedFilter.value))
            "filter[where][equipment][in]":
                searchFilter('equipment', confirmedFilter.value),
          if (checkfilter('instructor', confirmedFilter.value))
            "filter[where][instructor][in]":
                searchFilter('instructor', confirmedFilter.value),
        },
      );
      if (fetcheddata != null) {
        final List<OnDemandModel> data =
            List.from(fetcheddata.map((e) => OnDemandModel.fromJson(e)));
        return data;
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    return null;
  }

  static Future<List<OnDemandModel>?> getListOnDemandAudioData(context,
      {String? mainSearch,
      int? limitContentPerPage,
      required int pageNumber,
      required ValueNotifier<List<SelectedFilterModel>>
          confirmedFilter}) async {
    try {
      // log(" level query ${searchFilter('level', confirmedFilter.value)}");
      final fetcheddata = await OnDemandRequest.listOnDemand(
        queryParameters: {
          "filter[where][type][eq]": 'audio-workout',
          "filter[limit]": limitContentPerPage ?? 10,
          "filter[offset]": pageNumber,
          if (checkfilter('duration', confirmedFilter.value))
            "filter[where][duration][in]":
                searchFilter('duration', confirmedFilter.value),
          if (mainSearch != null) "filter[where][q][contains]": mainSearch,
          if (checkfilter('level', confirmedFilter.value))
            "filter[where][level][in]":
                searchFilter('level', confirmedFilter.value),
          if (checkfilter('categories', confirmedFilter.value))
            "filter[where][categories][in]":
                searchFilter('categories', confirmedFilter.value),
          if (checkfilter('equipment', confirmedFilter.value))
            "filter[where][equipment][in]":
                searchFilter('equipment', confirmedFilter.value),
          if (checkfilter('instructor', confirmedFilter.value))
            "filter[where][instructor][in]":
                searchFilter('instructor', confirmedFilter.value),
        },
      );
      if (fetcheddata != null) {
        final List<OnDemandModel> data =
            List.from(fetcheddata.map((e) => OnDemandModel.fromJson(e)));
        return data;
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    return null;
  }

  static Future<List<WorkoutModel>?> getListWorkoutData(context,
      {String? mainSearch,
      int? limitContentPerPage,
      required int pageNumber,
      required ValueNotifier<List<SelectedFilterModel>>
          confirmedFilter}) async {
    try {
      final fetcheddata = await WorkoutRequest.listOfWorkout(
        queryParameters: {
          "filter[limit]": limitContentPerPage ?? 10,
          "filter[offset]": pageNumber,
          if (mainSearch != null) "filter[where][q][contains]": mainSearch,
          if (checkfilter('goals', confirmedFilter.value))
            "filter[where][goals][in]":
                searchFilter('goals', confirmedFilter.value),
          if (checkfilter('body_parts', confirmedFilter.value))
            "filter[where][body_parts][in]":
                searchFilter('body_parts', confirmedFilter.value),
          if (checkfilter('level', confirmedFilter.value))
            "filter[where][level][in]":
                searchFilter('level', confirmedFilter.value),
          if (checkfilter('duration', confirmedFilter.value))
            "filter[where][duration][in]":
                searchFilter('duration', confirmedFilter.value),
          if (checkfilter('types', confirmedFilter.value))
            "filter[where][types][in]":
                searchFilter('types', confirmedFilter.value),
          if (checkfilter('locations', confirmedFilter.value))
            "filter[where][locations][in]":
                searchFilter('locations', confirmedFilter.value),
        },
      );
      if (fetcheddata != null) {
        final List<WorkoutModel> data =
            List.from(fetcheddata.map((e) => WorkoutModel.fromJson(e)));
        return data;
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    return null;
  }

  static Future<List<TrainingPlanModel>?> getListTrainingPlanData(context,
      {String? mainSearch,
      int? limitContentPerPage,
      required int pageNumber,
      required ValueNotifier<List<SelectedFilterModel>>
          confirmedFilter}) async {
    try {
      final fetcheddata = await TrainingPlanRequest.listOfTrainingPlan(
        queryParameters: {
          "filter[limit]": limitContentPerPage ?? 10,
          "filter[offset]": pageNumber,
          if (mainSearch != null) "filter[where][q][contains]": mainSearch,
          if (checkfilter('goals', confirmedFilter.value))
            "filter[where][goals][in]":
                searchFilter('goals', confirmedFilter.value),
          if (checkfilter('level', confirmedFilter.value))
            "filter[where][level][in]":
                searchFilter('level', confirmedFilter.value),
          if (checkfilter('locations', confirmedFilter.value))
            "filter[where][locations][in]":
                searchFilter('locations', confirmedFilter.value),
          if (checkfilter('max_days_per_week', confirmedFilter.value))
            "filter[where][max_days_per_week][in]":
                searchFilter('max_days_per_week', confirmedFilter.value),
        },
      );
      if (fetcheddata != null) {
        final List<TrainingPlanModel> data =
            List.from(fetcheddata.map((e) => TrainingPlanModel.fromJson(e)));
        return data;
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    return null;
  }

  static List<FollowTrainingplanModel> searchFilterLocal(
    ValueNotifier<List<SelectedFilterModel>> confirmedFilter,
    Box<FollowTrainingplanModel> box,
  ) {
    List<FollowTrainingplanModel> result = [];
    if (checkfilter('goals', confirmedFilter.value)) {
      result.addAll(box.values
          .toList()
          .where((element) => element.goalsId
              .contains(searchFilter('goals', confirmedFilter.value) ?? ""))
          .toList());
    }
    if (checkfilter('level', confirmedFilter.value)) {
      result.addAll(box.values.toList().where((element) => element.levelName
          .contains(searchFilter('level', confirmedFilter.value) ?? "")));
    }

    if (checkfilter('locations', confirmedFilter.value)) {
      result.addAll(box.values.toList().where((element) => element.location
          .contains(searchFilter('locations', confirmedFilter.value) ?? "")));
    }

    if (checkfilter('max_days_per_week', confirmedFilter.value)) {
      result.addAll(box.values.toList().where((element) => element.daysPerWeek
          .contains(
              searchFilter('max_days_per_week', confirmedFilter.value) ?? "")));
    }
    return result;
  }

  static bool checkfilter(
      String type, List<SelectedFilterModel>? confirmedFilter) {
    if (confirmedFilter != null) {
      for (var element in confirmedFilter) {
        if (element.filterType.toLowerCase() == type) {
          return true;
        }
      }
    }
    return false;
  }

  static String? searchFilter(
      String type, List<SelectedFilterModel>? confirmedFilter) {
    List<String> filters = [];

    if (confirmedFilter != null) {
      for (var element in confirmedFilter) {
        if (element.filterType.toLowerCase() == type) {
          if (element.filterId.toString() != "null") {
            filters.add(element.filterId.toString());
          } else {
            filters.add(element.filterName);
          }
        }
      }

      if (filters.isNotEmpty) {
        // log(filters.map((e) => e.toLowerCase().trim()).join(","));
        return filters.map((e) => e.toLowerCase().trim()).join(",");
      }
    }
    return null;
  }

  static List<FiltersModel> filterListData = [];
  static Future<List<FiltersModel>> runComplexTask(
    context,
    CategoryName name,
    ValueNotifier<bool> filterLoader,
  ) async {
    filterLoader.value = true;
    if (filterListData.isEmpty) {
      filterListData.clear();
      if (name == CategoryName.videoClasses ||
          name == CategoryName.audioClasses) {
        try {
          await OnDemandRequest.onDemandFilter().then((value) {
            for (var element in value!) {
              if (element['key'] == "q" ||
                  element['key'] == "type" ||
                  element['key'] == "content_package") {
              } else if (element['values'].length > 2) {
                filterListData.add(FiltersModel.fromJson(element));
              }
            }

            //  Map<String, dynamic> jsoon={};
          });
        } on RequestException catch (e) {
          BaseHelper.showSnackBar(context, e.message);
        }
      } else if (name == CategoryName.workouts) {
        try {
          await WorkoutRequest.workoutFilters().then((value) {
            for (var element in value!) {
              if (element['key'] == "q" ||
                  element['key'] == "content_package") {
              } else if (element['values'].length > 2) {
                filterListData.add(FiltersModel.fromJson(element));
              }
            }
          });
        } on RequestException catch (e) {
          BaseHelper.showSnackBar(context, e.message);
        }
      } else if (name == CategoryName.trainingPlans) {
        try {
          await TrainingPlanRequest.trainingPlanFilters().then((value) {
            for (var element in value!) {
              if (element['key'] == "q" ||
                  element['key'] == "type" ||
                  element['key'] == "content_package" ||
                  element['key'] == "max_days_per_week") {
              } else if (element['values'].length > 2) {
                filterListData.add(FiltersModel.fromJson(element));
              }
            }

            //  Map<String, dynamic> jsoon={};
          });
        } on RequestException catch (e) {
          BaseHelper.showSnackBar(context, e.message);
        }
      }
    }
    filterLoader.value = false;
    return filterListData;
  }

  static void deleteAFilter(context, String e,
      ValueNotifier<List<SelectedFilterModel>> confirmedFilter) {
    confirmedFilter.value.removeWhere((element) => element.filterName == e);
  }

  static void addFilter(
      SelectedFilterModel value,
      List<SelectedFilterModel> selectedFilter,
      ValueNotifier<List<SelectedFilterModel>> confirmedFilter) {
    if (selectedFilter.any((element) =>
        element.filterName == value.filterName &&
        element.filterType == value.filterType)) {
      if (confirmedFilter.value.isNotEmpty) {
        // restConfirmFilterAlso = true;
      }
      selectedFilter.removeWhere((element) =>
          element.filterName == value.filterName &&
          element.filterType == value.filterType);

      return;
    } else {
      selectedFilter.add(value);

      return;
    }
  }

  static bool isShowFilter = false;
  static void showAllFiltter() {
    isShowFilter = true;
  }

  static void hideAllFilter() {
    isShowFilter = false;
  }

  static bool restConfirmFilterAlso = false;
  static void resetFilter(context, List<SelectedFilterModel> selectedFilter,
      ValueNotifier<List<SelectedFilterModel>> confirmedFilter) {
    if (confirmedFilter.value.isNotEmpty) {
      restConfirmFilterAlso = true;
      confirmedFilter.value.clear();
    }
    selectedFilter.clear();
    // slderValue = 1;
  }

  static void clearAppliedFilter(
      ValueNotifier<List<SelectedFilterModel>> confirmedFilter) {
    confirmedFilter.value.clear();

    hideAllFilter();
  }

  static void confirmFilter({
    required ValueNotifier<List<SelectedFilterModel>> confirmedFilter,
    required List<SelectedFilterModel> selectedFilter,
  }) {
    confirmedFilter.value = selectedFilter;
  }

  static Map<int, String> workoutDataType = {};
  static Map<int, String> videoDataType = {};
  static Map<int, String> audioDataType = {};

  static Timer? timer;
  static void delayedFunction({
    required VoidCallback fn,
  }) async {
    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer(const Duration(milliseconds: 750), fn);
  }

  static int itemCount({
    required CategoryName categoryName,
    required List<OnDemandModel> listOndemandData,
    required List<WorkoutModel> listWorkoutData,
  }) {
    return categoryName == CategoryName.videoClasses
        ? listOndemandData.length
        : categoryName == CategoryName.workouts
            ? listWorkoutData.length
            : listOndemandData.length;
  }

  static List? chekList({
    required CategoryName categoryName,
    required List<OnDemandModel> listOndemandData,
    required List<WorkoutModel> listWorkoutData,
  }) {
    switch (categoryName) {
      case CategoryName.videoClasses:
        return listOndemandData;

      case CategoryName.audioClasses:
        return listOndemandData;

      case CategoryName.workouts:
        return listWorkoutData;

      default:
        return [];
    }
  }

  static String title({
    required int index,
    required CategoryName categoryName,
    required List<OnDemandModel> listOndemandData,
    required List<WorkoutModel> listWorkoutData,
  }) {
    return categoryName == CategoryName.videoClasses
        ? listOndemandData[index].title.toString()
        : categoryName == CategoryName.workouts
            ? listWorkoutData[index].title.toString()
            : listOndemandData[index].title.toString();
  }

  static String subtitle(
    BuildContext context, {
    required int index,
    required CategoryName categoryName,
    required List<OnDemandModel> listOndemandData,
    required List<WorkoutModel> listWorkoutData,
    required Map<int, String> categoryTypeData,
    required Map<int, String> onDemandCategoryVideoData,
    required Map<int, String> onDemandCategoryAudioData,
  }) {
    return categoryName == CategoryName.videoClasses
        ? "${listOndemandData[index].duration} ${context.loc.minText} • ${onDemandCategoryVideoData[index] == "" ? "" : "${onDemandCategoryVideoData[index]} • "}${listOndemandData[index].level.toString()}"
        : categoryName == CategoryName.workouts
            ? "${listWorkoutData[index].duration} ${context.loc.minText} • ${categoryTypeData[index] == "" ? "" : "${categoryTypeData[index]} • "}${listWorkoutData[index].level.toString()}"
            : "${listOndemandData[index].duration} ${context.loc.minText} • ${onDemandCategoryAudioData[index] == "" ? "" : "${onDemandCategoryAudioData[index]} • "}${listOndemandData[index].level}";
  }

  static String imageUrl({
    required int index,
    required CategoryName categoryName,
    required List<OnDemandModel> listOndemandData,
    required List<WorkoutModel> listWorkoutData,
  }) {
    return categoryName == CategoryName.videoClasses
        ? listOndemandData[index].image.toString()
        : categoryName == CategoryName.workouts
            ? listWorkoutData[index].image.toString()
            : listOndemandData[index].image.toString();
  }
}
