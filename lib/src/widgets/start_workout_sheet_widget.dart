import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/src/widgets/get_ready_widget.dart';

import '../../ui_tool_kit.dart';

class StartWorkoutSheet extends StatelessWidget {
  const StartWorkoutSheet(
      {super.key,
      required this.workoutModel,
      required this.warmUpData,
      required this.trainingData,
      required this.coolDownData,
      required this.fitnessGoalModel,
      required this.equipmentData});
  final WorkoutModel workoutModel;
  final Map<ExerciseDetailModel, ExerciseModel> warmUpData;
  final Map<ExerciseDetailModel, ExerciseModel> trainingData;
  final Map<ExerciseDetailModel, ExerciseModel> coolDownData;
  final FitnessGoalModel? fitnessGoalModel;
  final List<EquipmentModel> equipmentData;
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
                    left: 16, right: 16, top: 25, bottom: 50),
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
                    Container()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 20),
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
              Card(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                color: AppColor.surfaceBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 12, bottom: 12),
                      child: Text("What you'll need",
                          style: AppTypography.label14SM
                              .copyWith(color: AppColor.textPrimaryColor)),
                    ),
                    const CustomDivider(),
                    SizedBox(
                      width: double.infinity,
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 10),
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
          bottom: 15,
        ),
        child: CustomElevatedButton(
            radius: 16,
            btnColor: AppColor.buttonPrimaryColor,
            onPressed: () {
              context.navigateTo(GetReadyViewWidget(
                equipmentData: equipmentData,
                fitnessGoalModel: fitnessGoalModel,
                workoutModel: workoutModel,
                warmUpData: warmUpData,
                trainingData: trainingData,
                coolDownData: coolDownData,
              ));
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
