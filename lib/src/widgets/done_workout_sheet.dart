import 'package:flutter/material.dart';

import '../../ui_tool_kit.dart';

class DoneWorkoutSheet extends StatelessWidget {
  final String workoutName, type;
  final int totalDuration;
  final FollowTrainingplanModel? followTrainingplanModel;
  final Map<ExerciseDetailModel, ExerciseModel> warmUpData;
  final Map<ExerciseDetailModel, ExerciseModel> trainingData;
  final Map<ExerciseDetailModel, ExerciseModel> coolDownData;

  const DoneWorkoutSheet({
    super.key,
    required this.workoutName,
    required this.type,
    required this.totalDuration,
    required this.followTrainingplanModel,
    required this.warmUpData,
    required this.trainingData,
    required this.coolDownData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.surfaceBackgroundBaseColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 24, bottom: 20, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.grey,
                    ),
                    Text(
                      "You’ve completed",
                      style: AppTypography.label14SM
                          .copyWith(color: AppColor.textSubTitleColor),
                    )
                  ],
                ),
                Text(
                  workoutName,
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
                      checkNum: false,
                      subtitle: totalDuration.mordernDurationTextWidget,
                      title: 'Total Duration'),
                ),
                20.width(),
                Expanded(child: BuildCardWidget(title: 'Type', subtitle: type))
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
                onPressed: () async {
                  if (followTrainingplanModel != null) {
                    await showModalBottomSheet(
                      useSafeArea: true,
                      isScrollControlled: true,
                      isDismissible: false,
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return Container(
                          color: AppColor.surfaceBackgroundBaseColor,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30, left: 24, bottom: 20, right: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    followTrainingplanModel!.workoutCount
                                                .toInt() ==
                                            followTrainingplanModel!
                                                .totalWorkoutLength
                                                .toInt()
                                        ? Row(
                                            children: [
                                              const Icon(
                                                Icons.check_circle,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                "You’ve completed",
                                                style: AppTypography.label14SM
                                                    .copyWith(
                                                        color: AppColor
                                                            .textSubTitleColor),
                                              )
                                            ],
                                          )
                                        : Text(
                                            'Progress update',
                                            style: AppTypography.label14SM
                                                .copyWith(
                                                    color: AppColor
                                                        .textSubTitleColor),
                                          ),
                                    Text(
                                      followTrainingplanModel!
                                          .trainingPlanTitle,
                                      style: AppTypography.title28_2XL.copyWith(
                                          color: AppColor.textEmphasisColor),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 24),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColor.surfaceBackgroundColor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Workouts completed",
                                      style: AppTypography.label14SM.copyWith(
                                          color: AppColor.textSubTitleColor),
                                    ),
                                    8.height(),
                                    Text(
                                      "${followTrainingplanModel!.workoutCount} / ${followTrainingplanModel!.totalWorkoutLength}",
                                      style: AppTypography.title18LG.copyWith(
                                          color: AppColor.textEmphasisColor),
                                    ),
                                    4.height(),
                                    FollowedBorderWidget(
                                        color2: AppColor
                                            .surfaceBrandSecondaryColor
                                            .withOpacity(0.3),
                                        color: AppColor.surfaceBrandDarkColor,
                                        followTrainingData:
                                            followTrainingplanModel!)
                                  ],
                                ),
                              ),
                              if (followTrainingplanModel!.workoutCount ==
                                  followTrainingplanModel!.totalWorkoutLength)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 24),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColor.surfaceBackgroundColor),
                                  child: const Text(
                                      'You have completed the training plan and it will be removed from your followed training plans. If you wish to follow it again you can click “Start again” below.'),
                                ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (followTrainingplanModel!.workoutCount ==
                                        followTrainingplanModel!
                                            .totalWorkoutLength) ...[
                                      Expanded(
                                        child: CustomElevatedButton(
                                            btnColor:
                                                AppColor.buttonTertiaryColor,
                                            onPressed: () async {
                                              FollowTrainingplanModel newData = FollowTrainingplanModel(
                                                  trainingplanId:
                                                      followTrainingplanModel!
                                                          .trainingplanId,
                                                  workoutData:
                                                      followTrainingplanModel!
                                                          .workoutData,
                                                  workoutCount: 0,
                                                  totalWorkoutLength:
                                                      followTrainingplanModel!
                                                          .totalWorkoutLength,
                                                  outOfSequence:
                                                      followTrainingplanModel!
                                                          .outOfSequence,
                                                  trainingPlanImg:
                                                      followTrainingplanModel!
                                                          .trainingPlanImg,
                                                  trainingPlanTitle:
                                                      followTrainingplanModel!
                                                          .trainingPlanTitle,
                                                  daysPerWeek:
                                                      followTrainingplanModel!
                                                          .daysPerWeek,
                                                  goalsId:
                                                      followTrainingplanModel!
                                                          .goalsId,
                                                  levelName:
                                                      followTrainingplanModel!
                                                          .levelName,
                                                  location:
                                                      followTrainingplanModel!
                                                          .location);
                                              for (var i = 0;
                                                  i <
                                                      Boxes.getTrainingPlanBox()
                                                          .length;
                                                  i++) {
                                                if (Boxes.getTrainingPlanBox()
                                                        .values
                                                        .toList()[i]
                                                        .trainingplanId ==
                                                    followTrainingplanModel!
                                                        .trainingplanId) {
                                                  await Boxes
                                                          .getTrainingPlanBox()
                                                      .putAt(i, newData);
                                                }
                                              }
                                              if (context.mounted) {
                                                    Navigator.popUntil(
                                                context,
                                                (route) => route.isFirst,
                                              );
                                              context.navigateTo(
                                                  TrainingPlanDetailView(
                                                id: followTrainingplanModel!
                                                    .trainingplanId,
                                              ));
                                              }
                                          
                                            },
                                            childPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20),
                                            child: Text(
                                              'Start again',
                                              style: AppTypography.label18LG
                                                  .copyWith(
                                                      color: AppColor
                                                          .buttonSecondaryColor),
                                            )),
                                      ),
                                      20.width(),
                                    ],
                                    Expanded(
                                      child: CustomElevatedButton(
                                          childPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 20),
                                          onPressed: () async {
                                            if (followTrainingplanModel!
                                                    .workoutCount ==
                                                followTrainingplanModel!
                                                    .totalWorkoutLength) {
                                              for (var i = 0;
                                                  i <
                                                      Boxes.getTrainingPlanBox()
                                                          .length;
                                                  i++) {
                                                if (Boxes.getTrainingPlanBox()
                                                        .values
                                                        .toList()[i]
                                                        .trainingplanId ==
                                                    followTrainingplanModel!
                                                        .trainingplanId) {
                                                  await Boxes
                                                          .getTrainingPlanBox()
                                                      .deleteAt(i);
                                                }
                                              }
                                              if (context.mounted) {
                                                             Navigator.popUntil(
                                                context,
                                                (route) => route.isFirst,
                                              );

                                              context.navigateTo(
                                                  const TrainingPlanListView(
                                                      initialIndex: 0));
                                              }
                                 
                                            } else {
                                              Navigator.popUntil(
                                                context,
                                                (route) => route.isFirst,
                                              );

                                              context.navigateTo(
                                                  TrainingPlanDetailView(
                                                id: followTrainingplanModel!
                                                    .trainingplanId,
                                              ));
                                            }
                                          },
                                          child: Text(
                                            'Done',
                                            style: AppTypography.label18LG
                                                .copyWith(
                                                    color: AppColor
                                                        .textInvertEmphasis),
                                          )),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    context.navigateToRemovedUntil(
                        const VideoAudioWorkoutListView(
                            categoryName: CategoryName.workouts));
                  }
                },
                child: Text(
                  "Done",
                  style: AppTypography.label18LG
                      .copyWith(color: AppColor.textInvertEmphasis),
                )),
          )
        ],
      ),
    );
  }
}
