import 'dart:async';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      final fetcheddata = await OnDemandRequest.listOnDemand(
        queryParameters: {
          if (checkfilter('duration', confirmedFilter.value))
            "filter[where][duration][in]":
                searchFilter('duration', confirmedFilter.value),
          "filter[limit]": limitContentPerPage ?? '10',
          if (mainSearch != null) "filter[where][q][contains]": mainSearch,
          if (checkfilter('level', confirmedFilter.value))
            "filter[where][level][in]":
                searchFilter('level', confirmedFilter.value),
          "filter[offset]": pageNumber ?? 1,
          "filter[where][type][eq]": 'virtual-class',
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
      final fetcheddata = await OnDemandRequest.listOnDemand(
        queryParameters: {
          if (checkfilter('duration', confirmedFilter.value))
            "filter[where][duration][in]":
                searchFilter('duration', confirmedFilter.value),
          "filter[limit]": limitContentPerPage ?? '10',
          if (mainSearch != null) "filter[where][q][contains]": mainSearch,
          if (checkfilter('level', confirmedFilter.value))
            "filter[where][level][in]":
                searchFilter('level', confirmedFilter.value),
          "filter[offset]": pageNumber ?? 1,
          "filter[where][type][eq]": 'audio-workout',
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
      print(e.response);
    }

    return null;
  }

  static Future<List<WorkoutModel>?> getListWorkoutData(context,
      {String? mainSearch,
      String? limitContentPerPage,
      required String pageNumber,
      required ValueNotifier<List<TypeFilterModel>> confirmedFilter}) async {
    print(pageNumber);
    // if (checkfilter('level', confirmedFilter.value)) {
    //   log("${searchFilter('level', confirmedFilter.value)}");
    // }

    try {
      final fetcheddata = await WorkoutRequest.listOfWorkout(
        queryParameters: {
          "filter[limit]": limitContentPerPage ?? '10',
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
      final fetcheddata = await TrainingPlanRequest.listOfTrainingPlan(
        queryParameters: {
          "filter[limit]": limitContentPerPage ?? '10',
          "filter[offset]": pageNumber ?? '1',
          if (mainSearch != null) "filter[where][q][contains]": mainSearch,
          if (checkfilter('goals', confirmedFilter.value))
            "filter[where][goals][in]":
                searchFilter('goals', confirmedFilter.value),
          if (checkfilter('level', confirmedFilter.value))
            "filter[where][level][in]":
                searchFilter('level', confirmedFilter.value),
          if (searchFilter('locations', confirmedFilter.value) != null)
            "filter[where][locations][in]":
                searchFilter('locations', confirmedFilter.value),
          if (searchFilter('max_days_per_week', confirmedFilter.value) != null)
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
      print(e.response);
    }

    return null;
  }

  static void getFiltrationData(List<dynamic> args) {}
  static bool checkfilter(String type, List<TypeFilterModel>? confirmedFilter) {
    if (confirmedFilter != null) {
      for (var element in confirmedFilter) {
        if (element.type == type) {
          return true;
        }
      }
    }
    return false;
  }

  static String? searchFilter(
      String type, List<TypeFilterModel>? confirmedFilter) {
    List<String> filters = [];

    if (confirmedFilter != null) {
      for (var element in confirmedFilter) {
        if (element.type == type) {
          if (element.id.toString() != "null") {
            filters.add(element.id.toString());
          } else {
            filters.add(element.filter);
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

  // static List<IconTextModel> level = [
  //   IconTextModel(text: 'Beginner', imageName: AppAssets.chartLowIcon),
  //   IconTextModel(text: 'Medium', imageName: AppAssets.chatMidIcon),
  //   IconTextModel(text: 'Advanced', imageName: AppAssets.chartFullIcon),
  // ];
  // static List<IconTextModel> duration = [
  //   IconTextModel(
  //     text: '0-15',
  //   ),
  //   IconTextModel(
  //     text: '16-30',
  //   ),
  //   IconTextModel(
  //     text: '31-45',
  //   ),
  //   IconTextModel(
  //     text: '46-60',
  //   )
  // ];
  // static List<IconTextModel> durationWeek = [
  //   IconTextModel(
  //     text: '3 weeks',
  //   ),
  //   IconTextModel(
  //     text: '4 weeks',
  //   ),
  //   IconTextModel(
  //     text: '5 weeks',
  //   ),
  //   IconTextModel(
  //     text: '6 weeks',
  //   )
  // ];
  // static List<IconTextModel> location = [
  //   IconTextModel(text: 'Home', imageName: AppAssets.homeIcon),
  //   IconTextModel(text: 'Gym', imageName: AppAssets.gymIcon),
  //   IconTextModel(text: 'Outdoor', imageName: AppAssets.outdoorIcon),
  // ];
  // static Set<IconTextModel> categoryTypeFilters = {};
  // static Set<IconTextModel> typesFilters = {};
  // static Set<IconTextModel> goalsFilters = {};
  // static Set<IconTextModel> equipmentFilter = {};
  // static Set<IconTextModel> instructorFilter = {};
  // static Set<IconTextModel> bodyPartFilter = {};

  static List<OnDemandFiltersModel> onDemandfiltersData = [];
  static Future<List<OnDemandFiltersModel>> runComplexTask(
    context,
    CategoryName name,
    ValueNotifier<bool> filterLoader,
  ) async {
    filterLoader.value = true;
    if (onDemandfiltersData.isEmpty) {
      onDemandfiltersData.clear();
      if (name == CategoryName.videoClasses ||
          name == CategoryName.audioClasses) {
        try {
          await OnDemandRequest.onDemandFilter().then((value) {
            for (var element in value!) {
              if (element['key'] == "q" ||
                  element['key'] == "type" ||
                  element['key'] == "content_package") {
                print('got it');
              } else if (element['values'].length < 2) {
                print('only one content provider');
              } else {
                onDemandfiltersData.add(OnDemandFiltersModel.fromJson(element));
              }
            }

            //  Map<String, dynamic> jsoon={};
          });
        } on RequestException catch (e) {
          BaseHelper.showSnackBar(context, e.message);
        }
        // if (categoryTypeFilters.isEmpty) {
        //   try {
        //     ContentProviderCategoryOnDemandRequest.onDemandCategory()
        //         .then((value) async {
        //       if (value != null) {
        //         List<ContentProvidersCategoryOnDemandModel> data = List.from(
        //             value.map((e) =>
        //                 ContentProvidersCategoryOnDemandModel.fromJson(e)));
        //         ReceivePort receivePort = ReceivePort();
        //         categoryTypeFilters.clear();
        //         await Isolate.spawn(
        //           onDemandCategoryFn,
        //           [
        //             receivePort.sendPort,
        //             data,
        //           ],
        //         );
        //         final done = await receivePort.first;
        //         categoryTypeFilters.addAll(done);
        //         print('done $categoryTypeFilters');
        //       }
        //     });
        //   } on RequestException catch (e) {
        //     print(e.message);
        //   }
        // }
        // if (equipmentFilter.isEmpty) {
        //   try {
        //     EquipmentRequest.listOfEquipment().then((value) async {
        //       if (value != null) {
        //         List<EquipmentModel> data =
        //             List.from(value.map((e) => EquipmentModel.fromJson(e)));
        //         ReceivePort receivePort = ReceivePort();
        //         equipmentFilter.clear();
        //         await Isolate.spawn(
        //           equipmentFilterFn,
        //           [
        //             receivePort.sendPort,
        //             data,
        //           ],
        //         );
        //         final done = await receivePort.first;
        //         equipmentFilter.addAll(done);
        //         print('done $equipmentFilter');
        //       }
        //     });
        //   } on RequestException catch (e) {
        //     print(e.message);
        //   }
        // }
        // if (instructorFilter.isEmpty) {
        //   try {
        //     InstructorRequest.listOfInstructors().then((value) async {
        //       if (value != null) {
        //         List<InstructorModel> data =
        //             List.from(value.map((e) => InstructorModel.fromJson(e)));
        //         ReceivePort receivePort = ReceivePort();
        //         instructorFilter.clear();
        //         await Isolate.spawn(
        //           instructorFilterFn,
        //           [
        //             receivePort.sendPort,
        //             data,
        //           ],
        //         );
        //         final done = await receivePort.first;
        //         instructorFilter.addAll(done);
        //         print('done $instructorFilter');
        //       }
        //     });
        //   } on RequestException catch (e) {
        //     print(e.message);
        //   }
        // }
      } else if (name == CategoryName.workouts) {
        try {
          await WorkoutRequest.workoutFilters().then((value) {
            for (var element in value!) {
              if (element['key'] == "q" ||
                  element['key'] == "content_package") {
                print('got it');
              } else if (element['values'].length < 2) {
                print('only one content provider');
              } else {
                onDemandfiltersData.add(OnDemandFiltersModel.fromJson(element));
              }
            }

            //  Map<String, dynamic> jsoon={};
          });
        } on RequestException catch (e) {
          BaseHelper.showSnackBar(context, e.message);
        }
        // if (typesFilters.isEmpty) {
        //   try {
        //     ContentProviderCategoryOnDemandRequest.contentCategory()
        //         .then((value) async {
        //       if (value != null) {
        //         List<ContentProvidersCategoryOnDemandModel> data = List.from(
        //             value.map((e) =>
        //                 ContentProvidersCategoryOnDemandModel.fromJson(e)));
        //         ReceivePort receivePort = ReceivePort();
        //         typesFilters.clear();
        //         await Isolate.spawn(
        //           categoryListDataFn,
        //           [
        //             receivePort.sendPort,
        //             data,
        //           ],
        //         );
        //         final done = await receivePort.first;
        //         typesFilters.addAll(done);
        //         print('done $typesFilters');
        //       }
        //     });
        //   } on RequestException catch (e) {
        //     print(e.message);
        //   }
        // }

        //   if (bodyPartFilter.isEmpty) {
        //     try {
        //       BodyPartsRequest.bodyParts().then((value) async {
        //         if (value != null) {
        //           List<BodyPartModel> data =
        //               List.from(value.map((e) => BodyPartModel.fromJson(e)));
        //           ReceivePort receivePort = ReceivePort();
        //           bodyPartFilter.clear();
        //           await Isolate.spawn(
        //             bodyPartListFn,
        //             [
        //               receivePort.sendPort,
        //               data,
        //             ],
        //           );
        //           final done = await receivePort.first;
        //           bodyPartFilter.addAll(done);
        //           print('done $bodyPartFilter');
        //         }
        //       });
        //     } on RequestException catch (e) {
        //       print(e.message);
        //     }
        //   }
      } else if (name == CategoryName.trainingPLans) {
        try {
          await TrainingPlanRequest.trainingPlanFilters().then((value) {
            for (var element in value!) {
              if (element['key'] == "q" ||
                  element['key'] == "type" ||
                  element['key'] == "content_package") {
                print('got it');
              } else if (element['values'].length < 2) {
                print('only one content provider');
              } else {
                onDemandfiltersData.add(OnDemandFiltersModel.fromJson(element));
              }
            }

            //  Map<String, dynamic> jsoon={};
          });
        } on RequestException catch (e) {
          BaseHelper.showSnackBar(context, e.message);
        }
        // if (goalsFilters.isEmpty) {
        //   try {
        //     FitnessGoalRequest.listOfFitnessGoal().then((value) async {
        //       if (value != null) {
        //         List<FitnessGoalModel> data =
        //             List.from(value.map((e) => FitnessGoalModel.fromJson(e)));
        //         ReceivePort receivePort = ReceivePort();
        //         goalsFilters.clear();
        //         await Isolate.spawn(
        //           goalListFn,
        //           [
        //             receivePort.sendPort,
        //             data,
        //           ],
        //         );
        //         final done = await receivePort.first;
        //         goalsFilters.addAll(done);
        //         print('done $goalsFilters');
        //       }
        //     });
        //   } on RequestException catch (e) {
        //     print(e.message);
        //   }
        // }
      }
      // List<OnDemandFiltersModel> toRemove = [];
      // for (var element in onDemandfiltersData) {
      //   if (element.key == 'q' || element.key == "type") {
      //     toRemove.add(element);
      //   }
      // }
      // for (var element in toRemove) {
      //   onDemandfiltersData.remove(element);
      // }
    }
    filterLoader.value = false;
    return onDemandfiltersData;
  }

  // static void instructorFilterFn(List<dynamic> args) {
  //   SendPort sendPort = args[0] as SendPort;
  //   Set<IconTextModel> instructorFilterData = {};
  //   for (var element in args[1]) {
  //     instructorFilterData.add(
  //       IconTextModel(text: element.name, id: element.id.toString()),
  //     );
  //   }
  //   Isolate.exit(sendPort, instructorFilterData);
  // }

  // static void equipmentFilterFn(List<dynamic> args) {
  //   SendPort sendPort = args[0] as SendPort;
  //   Set<IconTextModel> equipmentFilterData = {};
  //   for (var element in args[1]) {
  //     equipmentFilterData.add(
  //       IconTextModel(text: element.name, id: element.id.toString()),
  //     );
  //   }
  //   Isolate.exit(sendPort, equipmentFilterData);
  // }

  // static void onDemandCategoryFn(List<dynamic> args) {
  //   SendPort sendPort = args[0] as SendPort;
  //   Set<IconTextModel> onDemandCategoryData = {};
  //   for (var element in args[1]) {
  //     onDemandCategoryData.add(
  //       IconTextModel(text: element.name, id: element.id.toString()),
  //     );
  //   }
  //   Isolate.exit(sendPort, onDemandCategoryData);
  // }

  // static void goalListFn(List<dynamic> args) {
  //   SendPort sendPort = args[0] as SendPort;
  //   Set<IconTextModel> goalListData = {};
  //   for (var element in args[1]) {
  //     goalListData.add(
  //       IconTextModel(text: element.name, id: element.id.toString()),
  //     );
  //   }
  //   Isolate.exit(sendPort, goalListData);
  // }

  // static void bodyPartListFn(List<dynamic> args) {
  //   SendPort sendPort = args[0] as SendPort;
  //   Set<IconTextModel> bodyPartsData = {};
  //   for (var element in args[1]) {
  //     bodyPartsData.add(
  //       IconTextModel(text: element.name, id: element.id.toString()),
  //     );
  //   }
  //   Isolate.exit(sendPort, bodyPartsData);
  // }

  // static void categoryListDataFn(List<dynamic> args) async {
  //   SendPort sendPort = args[0] as SendPort;
  //   Set<IconTextModel> listType = {};
  //   for (var e in args[1]) {
  //     if (listType.every((element) => element.text != e.name)) {
  //       listType.add(
  //         IconTextModel(text: e.name, id: e.id.toString()),
  //       );
  //     } else if (listType.isEmpty) {
  //       listType.add(
  //         IconTextModel(text: e.name, id: e.id.toString()),
  //       );
  //     }
  //   }
  //   Isolate.exit(sendPort, listType);
  // }

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

  // static double slderValue = 1;
  // static void addAFilter(
  //     TypeFilterModel value, List<TypeFilterModel> selectedFilter) {
  //   if (selectedFilter.any((element) => element.type == value.type)) {
  //     selectedFilter.removeWhere((element) => element.type == value.type);
  //     selectedFilter.add(value);

  //     return;
  //   } else {
  //     selectedFilter.add(value);

  //     return;
  //   }
  // }

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
    // slderValue = 1;
  }

  static void clearAppliedFilter(
      ValueNotifier<List<TypeFilterModel>> confirmedFilter) {
    confirmedFilter.value.clear();
    // slderValue = 1;
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

  static String subtitle({
    required int index,
    required CategoryName categoryName,
    required List<OnDemandModel> listOndemandData,
    required List<WorkoutModel> listWorkoutData,
  }) {
    return categoryName == CategoryName.videoClasses
        ? "${listOndemandData[index].duration.substring(listOndemandData[index].duration.indexOf('-') + 1)} min • ${listOndemandData[index].type}` • ${listOndemandData[index].level}"
        : categoryName == CategoryName.workouts
            ? "${listWorkoutData[index].duration!.substring(listWorkoutData[index].duration!.indexOf('-') + 1)} min • ${listWorkoutData[index].types!.map((e) => e)}` • ${listWorkoutData[index].level}"
            : "${listOndemandData[index].duration.substring(listOndemandData[index].duration.indexOf('-') + 1)} min • ${listOndemandData[index].type}` • ${listOndemandData[index].level}";
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





/* SendPort sendPort = args[0] as SendPort;
  try {
    if (args[2] == CategoryName.videoClasses ||
        args[2] == CategoryName.audioClasses) {
      ContentProviderCategoryOnDemandRequest.onDemandCategory().then((value) {
        if (value != null) {
          CategoryListController.categoryType.clear();
          for (var element in value) {
            CategoryListController.categoryType.add(
              IconTextModel(text: element.name, id: element.id),
            );
          }
        }
      });
      EquipmentRequest.listOfEquipment().then((value) {
        if (value != null) {
          CategoryListController.equipmentFilter.clear();
          for (var element in value) {
            CategoryListController.equipmentFilter.add(
              IconTextModel(text: element.name, id: element.id.toString()),
            );
          }
        }
      });
      InstructorRequest.listOfInstructors().then((value) {
        if (value != null) {
          CategoryListController.instructorFilter.clear();
          for (var element in value) {
            CategoryListController.instructorFilter.add(
              IconTextModel(text: element.name, id: element.id.toString()),
            );
          }
        }
      });
    } else if (args[2] == CategoryName.workouts) {
      ContentProviderCategoryOnDemandRequest.contentCategory().then((value) {
        if (value != null) {
          CategoryListController.type.clear();
          for (var element in value) {
            CategoryListController.type.add(
              IconTextModel(text: element.name, id: element.id.toString()),
            );
          }
        }
      });
      BodyPartsRequest.bodyParts().then((value) {
        if (value != null) {
          CategoryListController.bodyPartFilter.clear();
          for (var element in value) {
            CategoryListController.bodyPartFilter.add(
              IconTextModel(text: element.name, id: element.id.toString()),
            );
          }
        }
      });
    }
    Isolate.exit(sendPort, 'completed');
  } on RequestException catch (e) {
    BaseHelper.showSnackBar(args[1], e.message);
    Isolate.exit(sendPort);
  } */