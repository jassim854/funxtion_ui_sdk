import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ui_tool_kit/src/model/follow_trainingplan_model.dart';

import 'package:ui_tool_kit/src/ui/view/start_workout_view.dart';

import '../../ui_tool_kit.dart';

class GetReadySheetWidget extends StatelessWidget {
  GetReadySheetWidget({
    super.key,
    required this.workoutModel,
    required this.warmUpData,
    required this.trainingData,
    required this.coolDownData,
    required this.fitnessGoalModel,
    required this.equipmentData,
    required this.followTrainingplanModel,
  });
  final WorkoutModel workoutModel;

  final Map<ExerciseDetailModel, ExerciseModel> warmUpData;
  final Map<ExerciseDetailModel, ExerciseModel> trainingData;
  final Map<ExerciseDetailModel, ExerciseModel> coolDownData;
  final FitnessGoalModel? fitnessGoalModel;
  final List<EquipmentModel> equipmentData;
  final ValueNotifier<int> durationNotifier = ValueNotifier(0);

  Timer? mainTimer;
  String? getReadytitle;
  Map<ExerciseDetailModel, ExerciseModel> currentListData = {};
  final FollowTrainingplanModel? followTrainingplanModel;
  initFn() {
    if (warmUpData.isEmpty && trainingData.isNotEmpty) {
      getReadytitle = 'Training';

      currentListData = trainingData;
    } else if (trainingData.isEmpty && coolDownData.isNotEmpty) {
      getReadytitle = 'Cool Down';

      currentListData = coolDownData;
    } else {
      getReadytitle = 'Warmup';

      currentListData = warmUpData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.surfaceBackgroundBaseColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 19, bottom: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          context.popPage();
                        },
                        child: const Icon(
                          Icons.close,
                          size: 30,
                        )),
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Workout",
                          style: AppTypography.label18LG
                              .copyWith(color: AppColor.textEmphasisColor),
                        )),
                    const Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 20, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get ready for',
                      style: AppTypography.label14SM
                          .copyWith(color: AppColor.textSubTitleColor),
                    ),
                    Text(
                      workoutModel.title.toString(),
                      style: AppTypography.title28_2XL
                          .copyWith(color: AppColor.textEmphasisColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 31),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BuildCardWidget(
                          subtitle: workoutModel.duration.toString(),
                          title: 'Duration'),
                    ),
                    20.width(),
                    Expanded(
                        child: BuildCardWidget(
                            title: 'Type',
                            subtitle: fitnessGoalModel?.name ?? ""))
                  ],
                ),
              ),
              if (equipmentData.length != 1 &&
                  equipmentData.first.name.contains('No gear'))
                Card(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                  color: AppColor.surfaceBackgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 12, bottom: 12, right: 16),
                        child: Text("What you'll need",
                            style: AppTypography.label14SM
                                .copyWith(color: AppColor.textPrimaryColor)),
                      ),
                      CustomDivider(
                          // thickness: 22.5,
                          dividerColor: AppColor.borderOutlineColor),
                      SizedBox(
                        width: double.infinity,
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                            ),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      equipmentData[index].name,
                                      style: AppTypography.label16MD.copyWith(
                                          color: AppColor.textEmphasisColor),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const CustomDivider();
                            },
                            itemCount: equipmentData.length),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: context.dynamicHeight * 0.065,
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 30,
        ),
        child: CustomElevatedButton(
            radius: 16,
            btnColor: AppColor.buttonPrimaryColor,
            onPressed: () {
              if (warmUpData.isEmpty &&
                  trainingData.isNotEmpty &&
                  coolDownData.isEmpty) {
                context.navigateTo(StartWorkoutView(
                  equipmentData: equipmentData,
                  mainTimer: mainTimer,
                  durationNotifier: durationNotifier,
                  workoutModel: workoutModel,
                  warmUpData: warmUpData,
                  trainingData: trainingData,
                  coolDownData: coolDownData,
                  fitnessGoalModel: fitnessGoalModel,
                  followTrainingplanModel: followTrainingplanModel,
                ));
              } else if (warmUpData.isNotEmpty &&
                  trainingData.isEmpty &&
                  coolDownData.isEmpty) {
                context.navigateTo(StartWorkoutView(
                  equipmentData: equipmentData,
                  durationNotifier: durationNotifier,
                  workoutModel: workoutModel,
                  warmUpData: warmUpData,
                  trainingData: trainingData,
                  coolDownData: coolDownData,
                  fitnessGoalModel: fitnessGoalModel,
                  mainTimer: mainTimer,
                  followTrainingplanModel: followTrainingplanModel,
                ));
              } else {
                initFn();
                showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  backgroundColor: AppColor.surfaceBackgroundColor,
                  context: context,
                  builder: (context) {
                    return UpNextSheetWidget(
                      durationNotifier: durationNotifier,
                      equipmentData: equipmentData,
                      fitnessGoalModel: fitnessGoalModel,
                      workoutModel: workoutModel,
                      warmUpData: warmUpData,
                      trainingData: trainingData,
                      coolDownData: coolDownData,
                      mainTimer: mainTimer,
                      title: getReadytitle.toString(),
                      currentListData: currentListData,
                      sliderWarmUp: ValueNotifier(0),
                      sliderTraining: ValueNotifier(0),
                      sliderCoolDown: ValueNotifier(0),
                      coolDownBody: -1,
                      trainingBody: -1,
                      warmupBody: -1,
                      followTrainingplanModel: followTrainingplanModel,
                    );
                  },
                );
              }
            },
            child: Text(
              "Let's go",
              style: AppTypography.label18LG
                  .copyWith(color: AppColor.textInvertEmphasis),
            )),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
