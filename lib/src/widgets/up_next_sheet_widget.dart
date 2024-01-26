import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_tool_kit/src/model/follow_trainingplan_model.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class UpNextSheetWidget extends StatelessWidget {
  UpNextSheetWidget(
      {super.key,
      required this.workoutModel,
      required this.warmUpData,
      required this.trainingData,
      required this.coolDownData,
      required this.fitnessGoalModel,
      this.mainTimer,
      this.isFromNext,
      required this.equipmentData,
      required this.durationNotifier,
      required this.title,
      required this.currentListData,
      required this.sliderWarmUp,
      required this.sliderTraining,
      required this.sliderCoolDown,
      required this.coolDownBody,
      required this.trainingBody,
      required this.warmupBody,
      required this.followTrainingplanModel, });
  final WorkoutModel workoutModel;

  final Map<ExerciseDetailModel, ExerciseModel> warmUpData;
  final Map<ExerciseDetailModel, ExerciseModel> trainingData;
  final Map<ExerciseDetailModel, ExerciseModel> coolDownData;
  final FitnessGoalModel? fitnessGoalModel;
  final List<EquipmentModel> equipmentData;
  final ValueNotifier<int> durationNotifier;
  final ValueNotifier<double> sliderWarmUp;
  final ValueNotifier<double> sliderTraining;
  final ValueNotifier<double> sliderCoolDown;
  final int coolDownBody;
  final int trainingBody;
  final int warmupBody;
  final bool? isFromNext;
  Timer? mainTimer;
  final String title;
  final Map<ExerciseDetailModel, ExerciseModel> currentListData;
  ValueNotifier<bool> expand = ValueNotifier(true);
  final FollowTrainingplanModel? followTrainingplanModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surfaceBackgroundBaseColor,
      appBar: StartWorkoutHeaderWidget(
        mainTimer: mainTimer,
        warmUpData: warmUpData,
        coolDownData: coolDownData,
        trainingData: trainingData,
        workoutModel: workoutModel,
        durationNotifier: durationNotifier,
        sliderWarmUp: sliderWarmUp,
        sliderTraining: sliderTraining,
        sliderCoolDown: sliderCoolDown,
        actionWidget: InkWell(
            onTap: () async {
              await showModalBottomSheet(
                backgroundColor: AppColor.surfaceBackgroundBaseColor,
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (context) => OverviewBottomSheet(
                  warmUpData: warmUpData,
                  coolDownData: coolDownData,
                  trainingData: trainingData,
                  workoutModel: workoutModel,
                  coolDownBody: coolDownBody,
                  trainingBody: trainingBody,
                  warmupBody: warmupBody,
                ),
              );
            },
            child: SvgPicture.asset(AppAssets.exploreIcon)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 40),
              child: Text('Up next',
                  style: AppTypography.label14SM
                      .copyWith(color: AppColor.textSubTitleColor)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                title.toString(),
                style: AppTypography.title28_2XL,
              ),
            ),
            if (equipmentData.length != 1 &&
                equipmentData.first.name.contains('No gear'))
              Card(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 0),
                color: AppColor.surfaceBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 12, bottom: 12),
                      child: Text("Equipment",
                          style: AppTypography.label14SM
                              .copyWith(color: AppColor.textPrimaryColor)),
                    ),
                    const CustomDivider(),
                    ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 10),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            child: Row(
                              children: [
                                Text(
                                  equipmentData[index].name,
                                  style: AppTypography.label16MD.copyWith(
                                      color: AppColor.textEmphasisColor),
                                ),
                                12.width(),
                                Text(
                                  '',
                                  style: AppTypography.paragraph14MD.copyWith(
                                      color: AppColor.textPrimaryColor),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const CustomDivider();
                        },
                        itemCount: equipmentData.length)
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  BuildBodyWidget(
                    currentListData: currentListData,
                    expandHeaderValueListenable: expand,
                    loaderValueListenable: ValueNotifier(false),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 30),
        child: Row(
          children: [
            Expanded(
                child: SizedBox(
              height: 50,
              child: CustomElevatedButton(
                  btnColor: AppColor.surfaceBackgroundSecondaryColor,
                  onPressed: () {
                    if (isFromNext == true) {
                      context.popPage(result: false);
                    }
                  },
                  child: Text('Prev',
                      style: AppTypography.label16MD
                          .copyWith(color: AppColor.textSubTitleColor))),
            )),
            16.width(),
            Expanded(
                child: SizedBox(
              height: 50,
              child: CustomElevatedButton(
                  onPressed: () {
                    isFromNext == true
                        ? context.popPage(result: true)
                        : context.navigateTo(StartWorkoutView(
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
                  },
                  child: Text("Let's go",
                      style: AppTypography.label16MD
                          .copyWith(color: AppColor.textInvertEmphasis))),
            ))
          ],
        ),
      ),
    );
  }
}
