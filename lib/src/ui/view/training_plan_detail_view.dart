import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ui_tool_kit/src/helper/boxes.dart';
import 'package:ui_tool_kit/src/model/follow_trainingplan_model.dart';
import 'package:ui_tool_kit/src/ui/view/workout_detail_view.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class TrainingPlanDetailView extends StatefulWidget {
  final String id;
  const TrainingPlanDetailView({
    super.key,
    required this.id,
  });

  @override
  State<TrainingPlanDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<TrainingPlanDetailView> {
  bool isLoadingNotifier = false;
  bool isNodData = false;

  late ScrollController scrollController;

  TrainingPlanModel? trainingPlanData;
  FitnessGoalModel? fitnessGoalData;
  FitnessActivityTypeModel? fitnessActivityTypeData;
  ExerciseModel? exerciseData;
  ExerciseModel? exerciseWorkoutData;

  ValueNotifier<int> weekIndex = ValueNotifier(0);
  ValueNotifier<bool> centerTitle = ValueNotifier(false);
  FitnessActivityTypeModel? workoutType;
  List<WorkoutModel?> listSheduleWorkoutData = [];
  ValueNotifier<bool> shedulePlanLoader = ValueNotifier(false);
  ValueNotifier<bool> fitnessTypeLoader = ValueNotifier(true);
  ValueNotifier<bool> goalLoader = ValueNotifier(true);
  FollowTrainingplanModel? followTrainingData;
  // List<WeekName> weekName = [
  //   WeekName('Monday', false),
  //   WeekName('Tuesday', false),
  //   WeekName('Wednesday', false),
  //   WeekName('Thursday', false),
  //   WeekName('Friday', false),
  //   WeekName('Saturday', false),
  //   WeekName('Sunday', false),
  // ];

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        print(scrollController.offset);
        if (scrollController.offset > 155) {
          centerTitle.value = true;
        } else if (scrollController.offset < 160) {
          centerTitle.value = false;
        }
      });

    fetchData();

    // TODO: implement initState
    super.initState();
  }

  fetchData() async {
    isLoadingNotifier = true;
    isNodData = false;

    TrainingPlanDetailController.getTrainingPlanData(context, id: widget.id)
        .then((value) async {
      if (value != null && context.mounted) {
        isLoadingNotifier = false;
        trainingPlanData = value;

        if (trainingPlanData?.types.isNotEmpty ?? false) {
          TrainingPlanDetailController.getFitnessType(
                  context, trainingPlanData?.types.first.toString() ?? "")
              .then((value) {
            if (value != null) {
              fitnessActivityTypeData =
                  FitnessActivityTypeModel.fromJson(value);
              fitnessTypeLoader.value = false;
            } else {
              fitnessTypeLoader.value = false;
            }
          });
        }
        await TrainingPlanDetailController.getGoal(context,
                trainingPlanData: trainingPlanData)
            .then((value) {
          if (value != null) {
            fitnessGoalData = value;
            goalLoader.value = false;
          } else {
            goalLoader.value = false;
          }
        });
        setState(() {});

        TrainingPlanDetailController.shedulePlanFn(context,
            listSheduleWorkoutData: listSheduleWorkoutData,
            shedulePlanLoader: shedulePlanLoader,
            trainingPlanData: trainingPlanData,
            weekIndex: weekIndex);
      } else if (context.mounted) {
        setState(() {
          isLoadingNotifier = false;
          isNodData = true;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  checkIsFollowed(Box<FollowTrainingplanModel> box) {
    if (box.isNotEmpty) {
      for (var element in box.values.toList()) {
        if (element.trainingplanId == trainingPlanData?.id) {
          followTrainingData = element;
        } else {
          followTrainingData = null;
        }
      }
    } else {
      followTrainingData = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<FollowTrainingplanModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (_, box, child) {
          // boxListenable = box;
          // List<FollowTrainingplanModel> followPlanData = box.values.toList();
          checkIsFollowed(box);
          {
            return Scaffold(
              body: isLoadingNotifier == true
                  ? const LoaderStackWidget()
                  : isNodData == true
                      ? const CustomErrorWidget()
                      : Column(
                          children: [
                            Expanded(
                              child: ValueListenableBuilder(
                                  valueListenable: centerTitle,
                                  builder: (_, value, child) {
                                    return CustomScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      controller: scrollController,
                                      slivers: [
                                        SliverAppBarWidget(
                                          value: value,
                                          appBarTitle:
                                              "${trainingPlanData?.title}",
                                          flexibleTitle:
                                              "${trainingPlanData?.title}",
                                          flexibleTitle2:
                                              "${trainingPlanData?.daysTotal} workouts • ${fitnessGoalData?.name} • ${trainingPlanData?.level.toString() ?? ""}",
                                          backGroundImg: trainingPlanData
                                                  ?.mapImage?.url
                                                  .toString() ??
                                              "",
                                          isFollowingPlan: box.values.any(
                                              (element) =>
                                                  element.trainingplanId ==
                                                  trainingPlanData?.id),
                                          widgetChild: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${followTrainingData?.workoutCount}/${followTrainingData?.totalWorkoutLength}"),
                                              4.height(),
                                              Wrap(
                                                  runSpacing: 8,
                                                  spacing: 8,
                                                  children: List.generate(
                                                    followTrainingData
                                                            ?.totalWorkoutLength
                                                            ?.toInt() ??
                                                        0,
                                                    (index) => Container(
                                                      height: 6,
                                                      width: 22,
                                                      // foregroundDecoration: BoxDecoration(
                                                      //   color:
                                                      // ),
                                                      decoration: BoxDecoration(
                                                          color: index + 1 <=
                                                                  followTrainingData!
                                                                      .workoutCount!
                                                                      .toInt()
                                                              ? AppColor
                                                                  .textInvertEmphasis
                                                              : AppColor
                                                                  .surfaceBrandDarkColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16)),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        DescriptionBoxWidget(
                                            text: trainingPlanData?.description
                                                    .toString() ??
                                                ""),
                                        cardBoxWidget(),
                                        schedulHeadingWidget(),
                                        sheduleCardBoxWidget(context, box),
                                        if (followTrainingData != null)
                                          SliverPadding(
                                            padding: const EdgeInsets.all(20),
                                            sliver: SliverToBoxAdapter(
                                              child: Card(
                                                elevation: 0.2,
                                                color: AppColor
                                                    .surfaceBackgroundColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                child: InkWell(
                                                  onTap: () async {
                                                    await showDialog(
                                                      // barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return const ShowAlertDialogWidget(
                                                          body:
                                                              'If you unfollow the training plan all progress will be removed',
                                                          btnText1: 'Cancel',
                                                          btnText2: 'Unfollow',
                                                          title:
                                                              'Unfollow training plan?',
                                                        );
                                                      },
                                                    ).then((value) {
                                                      if (value == true) {
                                                        followTrainingData
                                                            ?.delete();
                                                      }
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Unfollow training plan',
                                                          style: AppTypography
                                                              .label16MD
                                                              .copyWith(
                                                                  color: AppColor
                                                                      .textEmphasisColor),
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .keyboard_arrow_right,
                                                          size: 30,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
              bottomNavigationBar:
                  isLoadingNotifier == false ? bottomWidget(box) : null,
            );
          }
        });
  }

  SliverToBoxAdapter schedulHeadingWidget() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, top: 35, left: 20),
        child: Text(
          'Schedule',
          style: AppTypography.title18LG
              .copyWith(color: AppColor.textEmphasisColor),
        ),
      ),
    );
  }

  Container bottomWidget(Box<FollowTrainingplanModel> box) {
    return Container(
      color: AppColor.surfaceBackgroundColor,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 24,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${trainingPlanData?.title}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.title14XS
                      .copyWith(color: AppColor.textEmphasisColor),
                ),
                4.height(),
                Text(
                    "${trainingPlanData?.weeksTotal} weeks / ${trainingPlanData?.maxDaysPerWeek} workouts",
                    style: AppTypography.paragraph12SM
                        .copyWith(color: AppColor.textPrimaryColor))
              ],
            ),
          ),
          Expanded(
              child: box.values.any((element) =>
                      element.trainingplanId == trainingPlanData?.id)
                  ? SheduletButtonWidget(
                      text: 'Next Workout',
                      onPressed: () {
                        // box.clear();

                        followTrainingData!.workoutCount =
                            followTrainingData!.workoutCount!.toInt() + 1;
                        followTrainingData!.workoutId = listSheduleWorkoutData[
                                followTrainingData!.workoutCount!]!
                            .id;
                        followTrainingData?.save();
                        context.navigateTo(WorkoutDetailView(
                          id: followTrainingData?.workoutId ?? '',
                          followTrainingplanModel: followTrainingData,
                          trainingPlanName: followTrainingData != null
                              ? trainingPlanData?.title
                              : null,
                        ));
                      })
                  : SheduletButtonWidget(
                      text: "Start Following",
                      onPressed: () {
                        final data = FollowTrainingplanModel(
                            trainingplanId: trainingPlanData!.id,
                            workoutId: listSheduleWorkoutData[0]!.id,
                            totalWorkoutLength: listSheduleWorkoutData.length,
                            workoutCount: 0);
                        box.add(data);
                        // box.clear();

                        // showdModalBottomSheet(
                        //   useSafeArea: true,
                        //   isScrollControlled: true,
                        //   context: context,
                        //   builder: (context) => ShedulePlanSheet(
                        //     trainingPlanModel: trainingPlanData,
                        //     weekName: weekName,
                        //   ),
                        // );
                      },
                    ))
        ],
      ),
    );
  }

  SliverToBoxAdapter sheduleCardBoxWidget(
      BuildContext context, Box<FollowTrainingplanModel> box) {
    return SliverToBoxAdapter(
        child: Card(
            elevation: 0.2,
            color: AppColor.surfaceBackgroundColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ValueListenableBuilder(
                valueListenable: shedulePlanLoader,
                builder: (_, value, child) {
                  return value == true
                      ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: BaseHelper.loadingWidget(),
                          ),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            box.values.any((element) =>
                                        element.trainingplanId ==
                                        trainingPlanData?.id) ==
                                    false
                                ? Container()
                                : SizedBox(
                                    width: 25,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(
                                          top: 50, bottom: 50),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: listSheduleWorkoutData.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            StepWidget(
                                                isActive: box.values.any(
                                                    (element) =>
                                                        element.trainingplanId ==
                                                            trainingPlanData
                                                                ?.id &&
                                                        index + 1 <=
                                                            element
                                                                .workoutCount!
                                                                .toInt())),
                                            if (index !=
                                                listSheduleWorkoutData.length -
                                                    1)
                                              const LineWidget(
                                                height: 67,
                                              )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(left: 15),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: listSheduleWorkoutData.length,
                                  itemBuilder: (context, index) {
                                    WorkoutModel? data =
                                        listSheduleWorkoutData[index];

                                    return Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: CustomTileTrainingPlanWidget(
                                          imageUrl: data?.mapImage?.url ?? "",
                                          title: data?.title ?? "",
                                          subtitle:
                                              "${data?.duration} • ${data?.level}",
                                          onTap: () {
                                            if (followTrainingData != null) {
                                              if (followTrainingData!
                                                      .workoutCount ==
                                                  index) {
                                                followTrainingData
                                                    ?.outOfSequence = false;
                                                followTrainingData!
                                                        .workoutCount =
                                                    followTrainingData!
                                                            .workoutCount! +
                                                        1;
                                                followTrainingData?.workoutId =
                                                    listSheduleWorkoutData[
                                                            followTrainingData!
                                                                .workoutCount!]!
                                                        .id;
                                                followTrainingData?.save();
                                                context.navigateTo(
                                                    WorkoutDetailView(
                                                        id: listSheduleWorkoutData[
                                                                    index]
                                                                ?.id
                                                                .toString() ??
                                                            '',
                                                        followTrainingplanModel:
                                                            followTrainingData,
                                                        trainingPlanName:
                                                            trainingPlanData
                                                                ?.title));
                                              } else if (followTrainingData!
                                                      .workoutCount!
                                                      .toInt() >=
                                                  index) {
                                                followTrainingData
                                                    ?.outOfSequence = false;
                                                followTrainingData?.save();
                                                context.navigateTo(
                                                    WorkoutDetailView(
                                                        id: listSheduleWorkoutData[
                                                                    index]
                                                                ?.id
                                                                .toString() ??
                                                            '',
                                                        followTrainingplanModel:
                                                            followTrainingData,
                                                        trainingPlanName:
                                                            trainingPlanData
                                                                ?.title));
                                              } else {
                                                followTrainingData
                                                    ?.workoutCount = index + 1;
                                                followTrainingData
                                                    ?.outOfSequence = true;

                                                followTrainingData?.save();

                                                context.navigateTo(
                                                    WorkoutDetailView(
                                                        id: listSheduleWorkoutData[
                                                                    index]
                                                                ?.id
                                                                .toString() ??
                                                            '',
                                                        followTrainingplanModel:
                                                            followTrainingData,
                                                        trainingPlanName:
                                                            trainingPlanData
                                                                ?.title));
                                              }
                                            } else {
                                              context
                                                  .navigateTo(WorkoutDetailView(
                                                id: listSheduleWorkoutData[
                                                            index]
                                                        ?.id
                                                        .toString() ??
                                                    '',
                                              ));
                                            }
                                          }),
                                    );
                                  }),
                            ),
                          ],
                        );
                },
              ),
            )));
  }

  SliverToBoxAdapter cardBoxWidget() {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0.2,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        color: AppColor.surfaceBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 16),
          child: Column(
            children: [
              CustomRowTextChartIcon(
                level: trainingPlanData?.level.toString() ?? "",
                text1: 'Level',
                text2: trainingPlanData?.level.toString() ?? "",
                isChartIcon: true,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: CustomDivider(),
              ),
              ValueListenableBuilder(
                valueListenable: fitnessTypeLoader,
                builder: (context, value, child) {
                  return value == true
                      ? Center(
                          child: BaseHelper.loadingWidget(),
                        )
                      : CustomRowTextChartIcon(
                          text1: 'Type',
                          text2: fitnessActivityTypeData?.name ?? "No Data",
                        );
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: CustomDivider(),
              ),
              ValueListenableBuilder(
                valueListenable: goalLoader,
                builder: (context, value, child) {
                  return value == true
                      ? Center(
                          child: BaseHelper.loadingWidget(),
                        )
                      : CustomRowTextChartIcon(
                          text1: 'Goal',
                          text2: fitnessGoalData?.name ?? "No Data",
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowAlertDialogWidget extends StatelessWidget {
  final String title, body, btnText1, btnText2;

  const ShowAlertDialogWidget({
    super.key,
    required this.title,
    required this.body,
    required this.btnText1,
    required this.btnText2,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle:
          AppTypography.label18LG.copyWith(color: AppColor.textEmphasisColor),
      title: Center(
        child: Text(title),
      ),
      content: Text(
        body,
        style: AppTypography.paragraph16LG
            .copyWith(color: AppColor.textEmphasisColor),
      ),
      actions: [
        TextButton(
          child: Text(
            btnText1,
            style: AppTypography.paragraph18XL,
          ),
          onPressed: () {
            context.popPage(result: false);
          },
        ),
        TextButton(
          child: Text(btnText2,
              style: AppTypography.paragraph18XL
                  .copyWith(color: AppColor.redColor)),
          onPressed: () {
            context.popPage(result: true);
          },
        ),
      ],
    );
  }
}
