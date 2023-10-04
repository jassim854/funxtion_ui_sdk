import 'dart:async';

import 'package:flutter/material.dart';

import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

class CategoryListController {
  static Future<List<OnDemandModel>?> getListOnDemandData(context,
      {String? mainSearch,
      String? limitContentPerPage,
      String? pageNumber,
      required ValueNotifier<List<TypeFilterModel>> confirmedFilter}) async {
    print(pageNumber);
    try {
      // log(" level query ${searchFilter('level', confirmedFilter.value)}");
      List<OnDemandModel> fetcheddata = await OnDemandRequest.listOnDemand(
        whereDurationIncludes: searchFilter('duration', confirmedFilter.value),

        whereLimitContentPerPageIsEqualTo: limitContentPerPage ?? '20',

        whereNameIsEqualTo: mainSearch,

        whereLevelFieldEqualTo: searchFilter('level', confirmedFilter.value),

        wherePageNumberIsEqualTo: pageNumber ?? '1',
        //   whereCategoriesIdInclude: ,
        //   whereCategoriesIdIsEqualTo: ,
        //   whereCategoriesIdsAnd: ,
        //   whereContentProviderIdIsEqualTo: ,
        //   whereContentProviderIdsAnd: ,
        //   whereContentProviderIdsIncludes: ,
        //   whereDurationAnd: ,
        //   whereDurationEqualTo: ,
        //   whereEquipmentIdsAnd: ,
        //   whereEquipmentIdsIncludes: ,
        //   whereInstructorsIdIsEqualTo: ,
        //  whereInstructorsIdsAnd: ,
        //  whereInstructorsIdsInclude: ,
        //  whereLevelFieldAnd: ,
        //  whereLevelFieldIncludes: ,
        //  whereOrderingAccordingToNameEqualTo: ,
        //  whereTypeAnd: ,
        //  whereTypeInclude: ,
        whereTypeIsEqualTo: 'virtual-class',
      ) as List<OnDemandModel>;

      if (fetcheddata.isEmpty) {
        return fetcheddata;
      } else {
        return fetcheddata;
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
      print(e.response);
    }

    return null;
  }

  static Future<List<OnDemandModel>?> getListOnDemandAudioData(context,
      {String? mainSearch,
      String? limitContentPerPage,
      String? pageNumber,
      required ValueNotifier<List<TypeFilterModel>> confirmedFilter}) async {
    print(pageNumber);
    try {
      // log(" level query ${searchFilter('level', confirmedFilter.value)}");
      List<OnDemandModel> fetcheddata = await OnDemandRequest.listOnDemand(
        whereDurationIncludes: searchFilter('duration', confirmedFilter.value),

        whereLimitContentPerPageIsEqualTo: limitContentPerPage ?? '20',

        // whereTypeInclude: searchFilter('type', confirmedFilter.value),
        whereNameIsEqualTo: mainSearch,

        whereLevelFieldEqualTo: searchFilter('level', confirmedFilter.value),

        wherePageNumberIsEqualTo: pageNumber ?? '1',
        //   whereCategoriesIdInclude: ,
        //   whereCategoriesIdIsEqualTo: ,
        //   whereCategoriesIdsAnd: ,
        //   whereContentProviderIdIsEqualTo: ,
        //   whereContentProviderIdsAnd: ,
        //   whereContentProviderIdsIncludes: ,
        //   whereDurationAnd: ,
        //   whereDurationEqualTo: ,
        //   whereEquipmentIdsAnd: ,
        //   whereEquipmentIdsIncludes: ,
        //   whereInstructorsIdIsEqualTo: ,
        //  whereInstructorsIdsAnd: ,
        //  whereInstructorsIdsInclude: ,
        //  whereLevelFieldAnd: ,
        //  whereLevelFieldIncludes: ,
        //  whereOrderingAccordingToNameEqualTo: ,
        //  whereTypeAnd: ,
        //  whereTypeInclude: ,
        whereTypeIsEqualTo: 'audio-workout',
      ) as List<OnDemandModel>;

      if (fetcheddata.isEmpty) {
        return fetcheddata;
      } else {
        return fetcheddata;
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
      print(e.response);
    }

    return null;
  }

  static Future<List<WorkoutModel>?> getListWorkoutData(context,
      {String? mainSearch,
      String? limitContentPerPage,
      String? pageNumber,
      required ValueNotifier<List<TypeFilterModel>> confirmedFilter}) async {
    print(pageNumber);
    try {
      List<WorkoutModel> fetcheddata = await WorkoutRequest.listOfWorkout(
        // whereOrderingAccordingToNameEqualTo: 'asc',
        whereWorkoutNameContains: mainSearch,
        whereDurationIncludes: searchFilter('duration', confirmedFilter.value),

        whereLimitContentPerPageIsEqualTo: limitContentPerPage ?? '20',
        whereLocationInclude: searchFilter('location', confirmedFilter.value),
        whereLevelFieldInclude: searchFilter('level', confirmedFilter.value),

        wherePageNumberIsEqualTo: pageNumber ?? '1',
        // whereBodyPartIdIsEqualTo: ,
        // whereBodyPartsIdsAnd: ,
        // whereBodyPartsIdsInclude: ,
        // whereDurationAnd: ,

        // whereGoalIdIsEqualTo: ,
        // whereGoalIdsAnd: ,
        whereGoalIdsInclude: searchFilter('goal', confirmedFilter.value),
        // whereLevelFieldAnd: ,

        // whereLocationAnd: ,

        // whereTypeIdIsEqualTo: ,
        // whereTypeIdsAnd: ,
        whereTypeIdsInclude: searchFilter('type', confirmedFilter.value),
      ) as List<WorkoutModel>;

      if (fetcheddata.isEmpty) {
        return fetcheddata;
      } else {
        return fetcheddata;
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
      print(e.response);
    }

    return null;
  }

  static Future<List<TrainingPlanModel>?> getListTrainingPlanData(context,
      {String? mainSearch,
      String? limitContentPerPage,
      String? pageNumber,
      required ValueNotifier<List<TypeFilterModel>> confirmedFilter}) async {
    print(pageNumber);

    try {
      List<TrainingPlanModel> fetcheddata =
          await TrainingPlanRequest.listOfTrainingPlan(
        whereDaysPerWeekInclude:
            searchFilter('workout per week', confirmedFilter.value),

        whereNameContains: mainSearch,
        whereLimitContentPerPageIsEqualTo: limitContentPerPage ?? '20',
        whereLocationInclude: searchFilter('location', confirmedFilter.value),

        wherePageNumberIsEqualTo: pageNumber ?? '1',
        // whereDaysPerWeekAnd: ,

        // whereGoalIdIsEqualTo: ,
        // whereGoalIdsAnd: ,
        whereGoalIdsInclude: searchFilter('goal', confirmedFilter.value),
        // whereLevelFieldAnd: ,
        whereLevelFieldInclude: searchFilter('level', confirmedFilter.value),
        // whereLocationAnd: ,
        // whereOrderingAccordingToNameEqualTo: ,
      ) as List<TrainingPlanModel>;

      if (fetcheddata.isEmpty) {
        return fetcheddata;
      } else {
        return fetcheddata;
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
      print(e.response);
    }

    return null;
  }

  static String? searchFilter(
      String type, List<TypeFilterModel>? confirmedFilter) {
    List<String> filters = [];
    if (confirmedFilter != null) {
      for (var element in confirmedFilter) {
        if (element.type == type) {
          filters.add(element.filter);
        }
      }
      if (filters.isNotEmpty) {
        print(filters
            .map((e) => e.toLowerCase().trim())
            .join(",")
            .replaceAll('medium', 'intermediate')
            .replaceAll('10 min', '0-15')
            .replaceAll('20 min', '16-30')
            .replaceAll('30 min', '31-45')
            .replaceAll('45 min', '46-60')
            .replaceAll('build strength', "3")
            .replaceAll('strength', '18')
            .replaceAll('cardio', '4')
            .replaceAll('hiit', '8')
            .replaceAll('build muscle', '1')
            .replaceAll('lose weight', "2")
            .replaceAll('fitness', '4')
            .replaceAll('flexibilty', '6')
            .replaceAll('tone up', '5')
            .replaceAll('2.0', '2')
            .replaceAll('3.0', '3')
            .replaceAll('4.0', '4')
            .replaceAll('5.0', '5')
            .replaceAll('gym', 'club'));
        return filters
            .map((e) => e.toLowerCase().trim())
            .join(",")
            .replaceAll('medium', 'intermediate')
            .replaceAll('10 min', '0-15')
            .replaceAll('20 min', '16-30')
            .replaceAll('30 min', '31-45')
            .replaceAll('45 min', '46-60')
            .replaceAll('build strength', "3")
            .replaceAll('strength', '18')
            .replaceAll('cardio', '4')
            .replaceAll('hiit', '8')
            .replaceAll('build muscle', '1')
            .replaceAll('lose weight', "2")
            .replaceAll('fitness', '4')
            .replaceAll('flexibilty', '6')
            .replaceAll('tone up', '5')
            .replaceAll('2.0', '2')
            .replaceAll('3.0', '3')
            .replaceAll('4.0', '4')
            .replaceAll('5.0', '5')
            .replaceAll('gym', 'club');
      }

      // print(filters);
    }
    return null;
  }

  static List<IconTextModel> level = [
    IconTextModel(text: 'Beginner', imageName: AppAssets.chartLowIcon),
    IconTextModel(text: 'Medium', imageName: AppAssets.chatMidIcon),
    IconTextModel(text: 'Advanced', imageName: AppAssets.chartFullIcon),
  ];
  static List<IconTextModel> duration = [
    IconTextModel(
      text: '10 min',
    ),
    IconTextModel(
      text: '20 min',
    ),
    IconTextModel(
      text: '30 min',
    ),
    IconTextModel(
      text: '45 min',
    )
  ];
  static List<IconTextModel> durationWeek = [
    IconTextModel(
      text: '3 weeks',
    ),
    IconTextModel(
      text: '4 weeks',
    ),
    IconTextModel(
      text: '5 weeks',
    ),
    IconTextModel(
      text: '6 weeks',
    )
  ];
  static List<IconTextModel> location = [
    IconTextModel(text: 'Home', imageName: AppAssets.homeIcon),
    IconTextModel(text: 'Gym', imageName: AppAssets.gymIcon),
    IconTextModel(text: 'Outdoor', imageName: AppAssets.outdoorIcon),
  ];
  static List<IconTextModel> type = [
    IconTextModel(
      text: 'Yoga',
    ),
    IconTextModel(
      text: 'HIIT',
    ),
    IconTextModel(
      text: 'Strength',
    ),
    IconTextModel(
      text: 'Cardio',
    ),
    IconTextModel(
      text: 'Pilates',
    ),
    IconTextModel(
      text: 'Disco',
    )
  ];
  static List<IconTextModel> goals = [
    IconTextModel(
      text: 'Build Muscle',
    ),
    IconTextModel(
      text: 'Build Strength',
    ),
    IconTextModel(
      text: 'Lose Weight',
    ),
    IconTextModel(
      text: 'Fitness',
    ),
    IconTextModel(
      text: 'Flexibilty',
    ),
    IconTextModel(
      text: 'Tone Up',
    ),
  ];
  static void deleteAFilter(
      context, String e, ValueNotifier<List<TypeFilterModel>> confirmedFilter) {
    confirmedFilter.value.removeWhere((element) => element.filter == e);
  }

  static void addFilter(
      TypeFilterModel value,
      List<TypeFilterModel> selectedFilter,
      ValueNotifier<List<TypeFilterModel>> confirmedFilter) {
    if (selectedFilter.any((element) =>
        element.filter == value.filter && element.type == value.type)) {
      if (confirmedFilter.value.isNotEmpty) {
        restConfirmFilterAlso = true;
      }
      selectedFilter.removeWhere((element) =>
          element.filter == value.filter && element.type == value.type);

      return;
    } else {
      selectedFilter.add(value);

      return;
    }
  }

  static double slderValue = 1;
  static void addAFilter(
      TypeFilterModel value, List<TypeFilterModel> selectedFilter) {
    if (selectedFilter.any((element) => element.type == value.type)) {
      selectedFilter.removeWhere((element) => element.type == value.type);
      selectedFilter.add(value);

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
  static void resetFilter(context, List<TypeFilterModel> selectedFilter,
      ValueNotifier<List<TypeFilterModel>> confirmedFilter) {
    if (confirmedFilter.value.isNotEmpty) {
      restConfirmFilterAlso = true;
    }
    selectedFilter.clear();
    slderValue = 1;
  }

  static void clearAppliedFilter(
      ValueNotifier<List<TypeFilterModel>> confirmedFilter) {
    confirmedFilter.value.clear();
    slderValue = 1;
    hideAllFilter();
  }

  static void confirmFilter({
    required ValueNotifier<List<TypeFilterModel>> confirmedFilter,
    required List<TypeFilterModel> selectedFilter,
  }) {
    confirmedFilter.value = selectedFilter;
  }

  static Timer? timer;
  static void delayedFunction({
    required VoidCallback fn,
  }) async {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }

    timer = Timer(const Duration(milliseconds: 425), fn);
  }

  static int itemCount(
      {required CategoryName categoryName,
      required List<OnDemandModel> listOndemandData,
      required List<WorkoutModel> listWorkoutData,
      required List<TrainingPlanModel> listTrainingPLanData}) {
    return categoryName == CategoryName.videoClasses
        ? listOndemandData.length
        : categoryName == CategoryName.workouts
            ? listWorkoutData.length
            : categoryName == CategoryName.trainingPLans
                ? listTrainingPLanData.length
                : listOndemandData.length;
  }

  static String title(
      {required int index,
      required CategoryName categoryName,
      required List<OnDemandModel> listOndemandData,
      required List<WorkoutModel> listWorkoutData,
      required List<TrainingPlanModel> listTrainingPLanData}) {
    return categoryName == CategoryName.videoClasses
        ? listOndemandData[index].title.toString()
        : categoryName == CategoryName.workouts
            ? listWorkoutData[index].title.toString()
            : categoryName == CategoryName.trainingPLans
                ? listTrainingPLanData[index].title.toString()
                : listOndemandData[index].title.toString();
  }

  static String subtitle(
      {required int index,
      required CategoryName categoryName,
      required List<OnDemandModel> listOndemandData,
      required List<WorkoutModel> listWorkoutData,
      required List<TrainingPlanModel> listTrainingPLanData}) {
    return categoryName == CategoryName.videoClasses
        ? "${listOndemandData[index].duration.substring(listOndemandData[index].duration.indexOf('-') + 1)} min • ${listOndemandData[index].type}` • ${listOndemandData[index].level}"
        : categoryName == CategoryName.workouts
            ? "${listWorkoutData[index].duration.substring(listWorkoutData[index].duration.indexOf('-') + 1)} min • ${listWorkoutData[index].types.map((e) => e)}` • ${listWorkoutData[index].level}"
            : categoryName == CategoryName.trainingPLans
                ? "${listTrainingPLanData[index].weeksTotal} weeks • ${listTrainingPLanData[index].types}` • ${listTrainingPLanData[index].level}"
                : "${listOndemandData[index].duration.substring(listOndemandData[index].duration.indexOf('-') + 1)} min • ${listOndemandData[index].type}` • ${listOndemandData[index].level}";
  }

  static String imageUrl(
      {required int index,
      required CategoryName categoryName,
      required List<OnDemandModel> listOndemandData,
      required List<WorkoutModel> listWorkoutData,
      required List<TrainingPlanModel> listTrainingPLanData}) {
    return categoryName == CategoryName.videoClasses
        ? listOndemandData[index].image.toString()
        : categoryName == CategoryName.workouts
            ? listWorkoutData[index].image.toString()
            : categoryName == CategoryName.trainingPLans
                ? listTrainingPLanData[index].image.toString()
                : listOndemandData[index].image.toString();
  }

}
