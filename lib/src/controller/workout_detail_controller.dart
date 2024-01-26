

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';


import '../../ui_tool_kit.dart';

class WorkoutDetailController {
  static bool shouldBreakLoop = false;
  static Future<WorkoutModel?> getworkoutData(context,
      {required String id}) async {
    try {
      final fetcheddata = await WorkoutRequest.workoutById(id: id);
      if (fetcheddata != null) {
        WorkoutModel data = WorkoutModel.fromJson(fetcheddata);
        return data;
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    return null;
  }

  static Future<ExerciseModel?> getExercise(context, String id) async {
    try {
      final fetcheddata = await ExerciseRequest.exerciseById(id: id);
      if (fetcheddata != null) {
        ExerciseModel data = ExerciseModel.fromJson(fetcheddata);
        return data;
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    return null;
  }

  static Future<FitnessGoalModel?> getGoal(context, String id) async {
    try {
      final fetcheddata = await FitnessGoalRequest.fitnessGoalById(id: id);
      if (fetcheddata != null) {
        FitnessGoalModel data = FitnessGoalModel.fromJson(fetcheddata);
        return data;
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
    return null;
  }

  static Future<BodyPartModel?> getBodyPart(context, String id) async {
    try {
      final fetcheddata = await BodyPartsRequest.bodyPartById(id: id);
      if (fetcheddata != null) {
        BodyPartModel data = BodyPartModel.fromJson(fetcheddata);
        return data;
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
    return null;
  }

  static getWarmUpData(context,
      {required ValueNotifier<bool> warmUpLoader,
      required WorkoutModel? workoutData,
      required Map<ExerciseDetailModel, ExerciseModel> warmupData,
      required List<EquipmentModel> equipmentData}) async {
    warmUpLoader.value = true;

    warmupData.clear();
    await phasesFn(0, workoutData, context, warmupData, equipmentData);

    // for (var element in warmupData.entries) {
    //   if (element.key.exerciseCategoryName == ItemType.circuitTime) {
    //     circuitTimeWarmUpData.addEntries({element});
    //     print(circuitTimeWarmUpData);
    //   }
    //   if (element.key.exerciseCategoryName == ItemType.rft) {
    //     rftExerciseWarmUpData.addEntries({element});
    //     print(rftExerciseWarmUpData);
    //   }
    //   if (element.key.exerciseCategoryName == ItemType.singleExercise) {
    //     seExerciseWarmUpData.addEntries({element});

    //     print(seExerciseWarmUpData);
    //   }
    //   if (element.key.exerciseCategoryName == ItemType.superSet) {
    //     ssExerciseWarmUpData.addEntries({element});
    //     print(ssExerciseWarmUpData);
    //   }
    // }

    warmUpLoader.value = false;
  }

  static getEquipmentDataFn(
      String id, List<EquipmentModel> equipmentData) async {
    try {
      await EquipmentRequest.equipmentById(id: id).then((value) {
        if (value != null) {
          EquipmentModel data = EquipmentModel.fromJson(value);
          if (equipmentData.every((element) => element.name != data.name)) {
            equipmentData.add(data);
          }
        }
      });
    } on RequestException catch (e) {

    }
  }

  static getTrainingData(context,
      {required ValueNotifier<bool> trainingLoader,
      required WorkoutModel? workoutData,
      required Map<ExerciseDetailModel, ExerciseModel> trainingData,
      required List<EquipmentModel> equipmentData}) async {
    trainingLoader.value = true;

    trainingData.clear();
    await phasesFn(1, workoutData, context, trainingData, equipmentData);
  
    trainingLoader.value = false;
  }

  static Future<void> phasesFn(
      int phaseIndex,
      WorkoutModel? workoutData,
      context,
      Map<ExerciseDetailModel, ExerciseModel> exerciseList,
      List<EquipmentModel> equipmentData) async {
    for (var j = 0; j < workoutData!.phases![phaseIndex].items!.length; j++) {
      if (workoutData.phases![phaseIndex].items![j].type ==
          ItemType.circuitTime) {
        for (var i = 0;
            i < workoutData.phases![phaseIndex].items![j].ctRounds!.length;
            i++) {
          for (var k = 0;
              k <
                  workoutData.phases![phaseIndex].items![j].ctRounds![i]
                      .exercises!.length;
              k++) {
            try {
              await ExerciseRequest.exerciseById(
                      id: workoutData.phases![phaseIndex].items![j].ctRounds![i]
                          .exercises![k].exerciseId
                          .toString())
                  .then((value) async {
                if (value != null && shouldBreakLoop == false) {
                  ExerciseModel data = ExerciseModel.fromJson(value);

                  getEquipmentDataFn(
                      data.equipment.first.toString(), equipmentData);

                  exerciseList.addAll({
                    ExerciseDetailModel(
                      setsCount: i,
                      exerciseCategoryName: ItemType.circuitTime,
                      exerciseNo: k,
                      mainRestRound: workoutData
                          .phases![phaseIndex].items![j].ctRounds![i].restRound,
                      mainRest: workoutData
                          .phases![phaseIndex].items![j].ctRounds![i].rest,
                      mainWork: workoutData
                          .phases![phaseIndex].items![j].ctRounds![i].work,
                      exerciseNotes: workoutData.phases![phaseIndex].items![j]
                              .ctRounds![i].exercises![k].notes ??
                          "",
                      goalTargets: List.from(workoutData
                              .phases![phaseIndex]
                              .items![j]
                              .ctRounds![i]
                              .exercises?[k]
                              .goalTargets ??
                          []),
                      resistanceTargets: List.from(workoutData
                              .phases![phaseIndex]
                              .items![j]
                              .ctRounds![i]
                              .exercises?[k]
                              .resistanceTargets ??
                          []),
                    ): data
                  });
                }
              });
            } on RequestException catch (e) {
              BaseHelper.showSnackBar(context, e.message);
            }
            if (shouldBreakLoop) {
              break;
            }
          }
          if (shouldBreakLoop) {
            break;
          }
        }
        if (shouldBreakLoop) {
          break;
        }
      }
      if (shouldBreakLoop) {
        break;
      }
      if (workoutData.phases![phaseIndex].items![j].type ==
          ItemType.circuitRep) {
        for (var i = 0;
            i < workoutData.phases![phaseIndex].items![j].crRounds!.length;
            i++) {
          for (var k = 0;
              k <
                  workoutData.phases![phaseIndex].items![j].crRounds![i]
                      .exercises!.length;
              k++) {
            try {
              await ExerciseRequest.exerciseById(
                      id: workoutData.phases![phaseIndex].items![j].crRounds![i]
                          .exercises![k].exerciseId
                          .toString())
                  .then((value) async {
                if (value != null) {
                  ExerciseModel data = ExerciseModel.fromJson(value);

                  getEquipmentDataFn(
                      data.equipment.first.toString(), equipmentData);

                  exerciseList.addAll({
                    ExerciseDetailModel(
                      setsCount: i,
                      exerciseCategoryName: ItemType.circuitRep,
                      exerciseNo: k,
                      mainRestRound: workoutData
                          .phases![phaseIndex].items![j].crRounds![i].restRound,
                      mainRest: workoutData
                          .phases![phaseIndex].items![j].crRounds![i].rest,
                      mainWork: workoutData
                          .phases![phaseIndex].items![j].crRounds![i].work,
                      exerciseNotes: workoutData.phases![phaseIndex].items![j]
                              .crRounds![i].exercises![k].notes ??
                          "",
                      goalTargets: List.from(workoutData
                              .phases![phaseIndex]
                              .items![j]
                              .crRounds![i]
                              .exercises?[k]
                              .goalTargets ??
                          []),
                      resistanceTargets: List.from(workoutData
                              .phases![phaseIndex]
                              .items![j]
                              .crRounds![i]
                              .exercises?[k]
                              .resistanceTargets ??
                          []),
                    ): data
                  });
                }
              });
            } on RequestException catch (e) {
              BaseHelper.showSnackBar(context, e.message);
            }
          }
        }
      }
      if (workoutData.phases![phaseIndex].items![j].type == ItemType.amrap) {
        for (var i = 0;
            i <
                workoutData
                    .phases![phaseIndex].items![j].amrapExercises!.length;
            i++) {
          for (var k = 0;
              k <
                  workoutData.phases![phaseIndex].items![j].crRounds![i]
                      .exercises!.length;
              k++) {
            try {
              await ExerciseRequest.exerciseById(
                      id: workoutData.phases![phaseIndex].items![j].crRounds![i]
                          .exercises![k].exerciseId
                          .toString())
                  .then((value) async {
                if (value != null && shouldBreakLoop == false) {
                  ExerciseModel data = ExerciseModel.fromJson(value);

                  getEquipmentDataFn(
                      data.equipment.first.toString(), equipmentData);

                  exerciseList.addAll({
                    ExerciseDetailModel(
                      setsCount: i,
                      exerciseCategoryName: ItemType.circuitRep,
                      exerciseNo: k,
                      mainRestRound: workoutData
                          .phases![phaseIndex].items![j].crRounds![i].restRound,
                      mainRest: workoutData
                          .phases![phaseIndex].items![j].crRounds![i].rest,
                      mainWork: workoutData
                          .phases![phaseIndex].items![j].crRounds![i].work,
                      exerciseNotes: workoutData.phases![phaseIndex].items![j]
                              .crRounds![i].exercises![k].notes ??
                          "",
                      goalTargets: List.from(workoutData
                              .phases![phaseIndex]
                              .items![j]
                              .crRounds![i]
                              .exercises?[k]
                              .goalTargets ??
                          []),
                      resistanceTargets: List.from(workoutData
                              .phases![phaseIndex]
                              .items![j]
                              .crRounds![i]
                              .exercises?[k]
                              .resistanceTargets ??
                          []),
                    ): data
                  });
                }
              });
            } on RequestException catch (e) {
              BaseHelper.showSnackBar(context, e.message);
            }
            if (shouldBreakLoop) {
              break;
            }
          }
          if (shouldBreakLoop) {
            break;
          }
        }
        if (shouldBreakLoop) {
          break;
        }
      }
      if (shouldBreakLoop) {
        break;
      }
      if (workoutData.phases![phaseIndex].items![j].type == ItemType.rft) {
        for (var i = 0;
            i < workoutData.phases![phaseIndex].items![j].rftExercises!.length;
            i++) {
          try {
            await ExerciseRequest.exerciseById(
                    id: workoutData.phases![phaseIndex].items![j]
                        .rftExercises![i].exerciseId
                        .toString())
                .then((value) async {
              if (value != null && shouldBreakLoop == false) {
                ExerciseModel data = ExerciseModel.fromJson(value);

                getEquipmentDataFn(
                    data.equipment.first.toString(), equipmentData);

                exerciseList.addAll({
                  ExerciseDetailModel(
                      setsCount:
                          workoutData.phases![phaseIndex].items![j].rftRounds,
                      exerciseCategoryName: ItemType.rft,
                      exerciseNo: i,
                      mainNotes:
                          workoutData.phases![phaseIndex].items![j].notes,
                      exerciseNotes: workoutData
                          .phases![phaseIndex].items![j].rftExercises![i].notes
                          ?.trim(),
                      goalTargets: List.from(workoutData.phases![phaseIndex]
                              .items![j].rftExercises![i].goalTargets ??
                          []),
                      resistanceTargets: List.from(workoutData
                              .phases![phaseIndex]
                              .items![j]
                              .rftExercises![i]
                              .resistanceTargets ??
                          []),
                     

                      rftRounds: workoutData
                          .phases![phaseIndex].items![j].rftRounds): data
                });
              }
            });
          } on RequestException catch (e) {
            BaseHelper.showSnackBar(context, e.message);
          }
          if (shouldBreakLoop) {
            break;
          }
        }
        if (shouldBreakLoop) {
          break;
        }
      }
      if (shouldBreakLoop) {
        break;
      }
      if (workoutData.phases![phaseIndex].items![j].type ==
          ItemType.singleExercise) {
        for (var i = 0;
            i < workoutData.phases![phaseIndex].items![j].seExercises!.length;
            i++) {
          try {
            await ExerciseRequest.exerciseById(
                    id: workoutData.phases![phaseIndex].items![j]
                        .seExercises![i].exerciseId
                        .toString())
                .then((value) async {
              if (value != null && shouldBreakLoop == false) {
                ExerciseModel data = ExerciseModel.fromJson(value);

                getEquipmentDataFn(
                    data.equipment.first.toString(), equipmentData);
                // exerciseList.addAll({
                //   "exercise $i seExercisesSets ${workoutData.phases![phaseIndex].items![j].seExercises![i].sets!.length}, notes ${workoutData.phases![phaseIndex].items![j].seExercises![i].notes}, goalTargetMetric ${workoutData.phases![phaseIndex].items![j].seExercises![i].sets?.first.goalTargets?.first.metric}, goalTargetMin ${workoutData.phases![phaseIndex].items![j].seExercises![i].sets?.first.goalTargets?.first.min}, goalTargetMax ${workoutData.phases![phaseIndex].items![j].seExercises![i].sets?.first.goalTargets?.first.max}, goalTargetValue ${workoutData.phases![phaseIndex].items![j].seExercises![i].sets?.first.goalTargets?.first.value}":
                //       data
                // });

                exerciseList.addAll({
                  ExerciseDetailModel(
                      exerciseCategoryName: ItemType.singleExercise,
                      exerciseNo: i,
                      goalTargets: List.from(workoutData
                              .phases![phaseIndex]
                              .items![j]
                              .seExercises![i]
                              .sets
                              ?.first
                              .goalTargets ??
                          []),
                      resistanceTargets: List.from(workoutData
                              .phases![phaseIndex]
                              .items![j]
                              .seExercises![i]
                              .sets
                              ?.first
                              .resistanceTargets ??
                          []),
           
                      exerciseNotes: workoutData.phases![phaseIndex].items![j]
                              .seExercises![i].notes ??
                          "",
                      mainNotes:
                          workoutData.phases![phaseIndex].items![j].notes,
                      setsCount: workoutData.phases![phaseIndex].items![j]
                          .seExercises![i].sets!.length,
                      inSetRest: workoutData.phases![phaseIndex].items![j].seExercises![i].sets?.first.rest): data,
                });
                // dataLIst.add(a);
              }
            });
          } on RequestException catch (e) {
            BaseHelper.showSnackBar(context, e.message);
          }
          if (shouldBreakLoop) {
            break;
          }
        }
        if (shouldBreakLoop) {
          break;
        }
      }
      if (shouldBreakLoop) {
        break;
      }
      if (workoutData.phases![phaseIndex].items![j].type == ItemType.superSet) {
        for (var i = 0;
            i < workoutData.phases![phaseIndex].items![j].ssExercises!.length;
            i++) {
          try {
            await ExerciseRequest.exerciseById(
                    id: workoutData.phases![phaseIndex].items![j]
                        .ssExercises![i].exerciseId
                        .toString())
                .then((value) async {
              if (value != null && shouldBreakLoop == false) {
                ExerciseModel data = ExerciseModel.fromJson(value);
                getEquipmentDataFn(
                    data.equipment.first.toString(), equipmentData);
                // exerciseList.addAll({'exercise $i ssExercises   ': data});
                exerciseList.addAll({
                  ExerciseDetailModel(
                    exerciseCategoryName: ItemType.superSet,
                    exerciseNo: i,
                    setsCount: 0,
                    goalTargets: List.from(workoutData.phases![phaseIndex]
                            .items![j].ssExercises![i].goalTargets ??
                        []),
                    resistanceTargets: List.from(workoutData.phases![phaseIndex]
                            .items![j].ssExercises![i].resistanceTargets ??
                        []),
               
                    exerciseNotes: workoutData
                        .phases![phaseIndex].items![j].ssExercises![i].notes,
                    mainNotes: workoutData.phases![phaseIndex].items![j].notes,
                    mainSets: workoutData.phases![phaseIndex].items![j].ssSets,
                    mainRest: workoutData.phases![phaseIndex].items![j].ssRest,
                  ): data
                });
              }
            });
          } on RequestException catch (e) {
            BaseHelper.showSnackBar(context, e.message);
          }
          if (shouldBreakLoop) {
            break;
          }
        }
        if (shouldBreakLoop) {
          break;
        }
      }
      if (shouldBreakLoop) {
        break;
      }
    }
  }

  static getCoolDownData(context,
      {required ValueNotifier<bool> coolDownLoader,
      required WorkoutModel? workoutData,
      required Map<ExerciseDetailModel, ExerciseModel> coolDownData,
      required List<EquipmentModel> equipmentData}) async {
    coolDownLoader.value = true;

    coolDownData.clear();
    await phasesFn(2, workoutData, context, coolDownData, equipmentData);

    
    coolDownLoader.value = false;
  }

  static Map<ExerciseDetailModel, ExerciseModel> addCurrentList(
      int index, Map<ExerciseDetailModel, ExerciseModel> currentListData) {
    Map<ExerciseDetailModel, ExerciseModel> data = {};

    for (var element in currentListData.entries) {
      if (element.key.exerciseCategoryName ==
          currentListData.entries.toList()[index].key.exerciseCategoryName) {
        data.addEntries({element});
      }
    }

    return data;
  }
}
