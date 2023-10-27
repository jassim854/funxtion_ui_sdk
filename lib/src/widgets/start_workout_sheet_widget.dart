import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/src/widgets/get_ready_widget.dart';

import '../../ui_tool_kit.dart';

class StartWorkoutSheet extends StatelessWidget {
  const StartWorkoutSheet(
      {super.key,
      required this.workoutModel,
      required this.exerciseData,
      required this.exerciseWorkoutData,
      required this.exerciseWorkoutData2,
      required this.fitnessGoalModel});
  final WorkoutModel workoutModel;
  final List<ExerciseModel> exerciseData;
  final List<ExerciseModel> exerciseWorkoutData;
    final List<ExerciseModel> exerciseWorkoutData2;
  final FitnessGoalModel? fitnessGoalModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.surfaceBackgroundBaseColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 50),
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
                  workoutModel.title,
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
                      subtitle: workoutModel.duration, title: 'Duration'),
                ),
                20.width(),
                Expanded(
                    child: BuildCardWidget(
                        title: 'Type', subtitle: fitnessGoalModel?.name ?? ""))
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 20, right: 20),
            color: AppColor.surfaceBackgroundColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
                  child: Text("What you'll need",
                      style: AppTypography.label14SM
                          .copyWith(color: AppColor.textPrimaryColor)),
                ),
                const CustomDivider(),
                SizedBox(
                  width: double.infinity,
                  child: ListView.separated(
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
                                'Kettlebell',
                                style: AppTypography.label16MD.copyWith(
                                    color: AppColor.textEmphasisColor),
                              ),
                              12.width(),
                              Text(
                                '20 kg',
                                style: AppTypography.paragraph14MD
                                    .copyWith(color: AppColor.textPrimaryColor),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const CustomDivider();
                      },
                      itemCount: 2),
                )
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            height: context.dynamicHeight * 0.065,
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
            child: CustomElevatedButton(
                radius: 16,
                btnColor: AppColor.buttonPrimaryColor,
                onPressed: () {
                  context.navigateTo(GetReadyViewWidget(
                    fitnessGoalModel: fitnessGoalModel,
                    workoutModel: workoutModel,
                    exerciseData: exerciseData,
                    exerciseWorkoutData: exerciseWorkoutData,
                    exerciseWorkoutData2: exerciseWorkoutData2,
                    
                  ));
                },
                child: Text(
                  "Let's go",
                  style: AppTypography.label18LG
                      .copyWith(color: AppColor.textInvertEmphasis),
                )),
          )
        ],
      ),
    );
  }
}
