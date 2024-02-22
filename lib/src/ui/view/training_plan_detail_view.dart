import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

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
  Map<int, String> fitnessGoalData = {};
  FitnessActivityTypeModel? fitnessActivityTypeData;
  ExerciseModel? exerciseData;
  ExerciseModel? exerciseWorkoutData;

  ValueNotifier<int> weekIndex = ValueNotifier(0);
  ValueNotifier<bool> centerTitle = ValueNotifier(false);
  FitnessActivityTypeModel? workoutType;
  List<WorkoutModel> listSheduleWorkoutData = [];
  ValueNotifier<bool> shedulePlanLoader = ValueNotifier(false);
  ValueNotifier<bool> fitnessTypeLoader = ValueNotifier(true);

  FollowTrainingplanModel? followTrainingData;
  // Map<int, String> typeData = {};
  ValueNotifier<bool> typeLoader = ValueNotifier(false);
  Map<int, String> categoryFilterTypeData = {};
  List<LocalWorkout> workoutLocalData = [];

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset > 90) {
          centerTitle.value = true;
        } else if (scrollController.offset < 105) {
          centerTitle.value = false;
        }
      });

    fetchData();

    super.initState();
  }

  fetchData() async {
    isLoadingNotifier = true;
    isNodData = false;

    TrainingPlanDetailController.getTrainingPlanData(context, id: widget.id)
        .then((data) async {
      if (data != null && context.mounted) {
        isLoadingNotifier = false;
        trainingPlanData = data;

        CommonController.getFilterFitnessGoalData(context,
            shouldBreakLoop: false,
            trainingData: data,
            filterFitnessGoalData: fitnessGoalData);
        setState(() {});
        if (trainingPlanData!.weeks!.isNotEmpty) {
          // ignore: use_build_context_synchronously
          TrainingPlanDetailController.shedulePlanFn(context,
              listSheduleWorkoutData: listSheduleWorkoutData,
              shedulePlanLoader: shedulePlanLoader,
              trainingPlanData: trainingPlanData,
              weekIndex: weekIndex);
        }
      } else if (context.mounted) {
        setState(() {
          isLoadingNotifier = false;
          isNodData = true;
        });
      }
    });
  }

  addWorkoutData() {
    for (var i = 0; i < listSheduleWorkoutData.length; i++) {
      workoutLocalData.add(LocalWorkout(
          workoutTitle: listSheduleWorkoutData[i].title.toString(),
          workoutSubtitle:
              "${listSheduleWorkoutData[i].duration} • ${categoryFilterTypeData[i]} • ${listSheduleWorkoutData[i].level.toString()}",
          workoutId: listSheduleWorkoutData[i].id.toString(),
          workoutImg: listSheduleWorkoutData[i].mapImage!.url));
    }
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  checkIsFollowed(Box<FollowTrainingplanModel> box) {
    if (box.isNotEmpty) {
      for (var element in box.values.toList()) {
        if (element.trainingplanId == trainingPlanData?.id) {
          followTrainingData = element;
        }
      }
    } else {
      followTrainingData = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<FollowTrainingplanModel>>(
        valueListenable: Boxes.getTrainingPlanBox().listenable(),
        builder: (_, box, child) {
          checkIsFollowed(box);

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
                                        flexibleSubtitleWidget: Row(
                                          children: [
                                            ValueListenableBuilder(
                                                valueListenable:
                                                    shedulePlanLoader,
                                                builder: (_, value, child) {
                                                  return value == true
                                                      ? SizedBox(
                                                          height: 12,
                                                          width: 12,
                                                          child: BaseHelper
                                                              .loadingWidget(),
                                                        )
                                                      : Text(
                                                          '${listSheduleWorkoutData.length} ${context.loc.workoutPluraText(listSheduleWorkoutData.length)}',
                                                          style: AppTypography
                                                              .label16MD
                                                              .copyWith(
                                                                  color: AppColor
                                                                      .textInvertPrimaryColor),
                                                        );
                                                }),
                                            Text(
                                              " • ${fitnessGoalData.entries.first.value}",
                                              style: AppTypography.label16MD
                                                  .copyWith(
                                                      color: AppColor
                                                          .textInvertPrimaryColor),
                                            ),
                                            Text(
                                              " • ${trainingPlanData?.level.toString()}",
                                              style: AppTypography.label16MD
                                                  .copyWith(
                                                      color: AppColor
                                                          .textInvertPrimaryColor),
                                            )
                                          ],
                                        ),
                                        backGroundImg: trainingPlanData
                                                ?.mapImage?.url
                                                .toString() ??
                                            "",
                                        isFollowingPlan:
                                            followTrainingData == null
                                                ? false
                                                : true,
                                        bottomWidget: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${followTrainingData?.workoutCount}/${followTrainingData?.totalWorkoutLength}"),
                                            4.height(),
                                            if (followTrainingData
                                                    ?.workoutCount !=
                                                followTrainingData
                                                    ?.totalWorkoutLength)
                                              FollowedBorderWidget(
                                                  followTrainingData:
                                                      followTrainingData),
                                          ],
                                        ),
                                      ),
                                      DescriptionBoxWidget(
                                          text: trainingPlanData?.description
                                                  .toString() ??
                                              ""),
                                      cardBoxWidget(),
                                      SliverToBoxAdapter(
                                          child: ValueListenableBuilder(
                                        valueListenable: shedulePlanLoader,
                                        builder: (_, value, child) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              schedulHeadingWidget(),
                                              sheduleCardBoxWidget(
                                                  context, box, value),
                                            ],
                                          );
                                          // : Container();
                                        },
                                      )),
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
                                                    context: context,
                                                    builder: (_) {
                                                      return ShowAlertDialogWidget(
                                                        body: context
                                                            .loc.alertBoxBody3,
                                                        btnText1: context.loc
                                                            .alertBoxButton1,
                                                        btnText2: context.loc
                                                            .alertBox3Button2,
                                                        title: context
                                                            .loc.alertBoxTitle3,
                                                      );
                                                    },
                                                  ).then((value) {
                                                    if (value == true) {
                                                      followTrainingData
                                                          ?.delete();
                                                      followTrainingData = null;
                                                    }
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        context.loc
                                                            .unFollowTrainingPlanText,
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
                isLoadingNotifier == false && isNodData == false
                    ? bottomWidget(box)
                    : null,
          );
        });
  }

  schedulHeadingWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12, top: 35, left: 20),
      child: Text(
        context.loc.scheduleText,
        style:
            AppTypography.title18LG.copyWith(color: AppColor.textEmphasisColor),
      ),
    );
  }

  Container bottomWidget(Box<FollowTrainingplanModel> box) {
    return Container(
      color: AppColor.surfaceBackgroundColor,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24, top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: box.values.any((element) =>
                      element.trainingplanId == trainingPlanData?.id)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (followTrainingData?.workoutCount !=
                            followTrainingData?.totalWorkoutLength) ...[
                          Text(
                            context.loc.nextUp,
                            style: AppTypography.paragraph12SM
                                .copyWith(color: AppColor.textPrimaryColor),
                          ),
                          2.height(),
                          Text(
                              "${followTrainingData?.workoutData[followTrainingData!.workoutCount].workoutTitle.toString()}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.title14XS
                                  .copyWith(color: AppColor.textEmphasisColor))
                        ]
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        2.height(),
                        ValueListenableBuilder(
                            valueListenable: shedulePlanLoader,
                            builder: (_, value, child) {
                              return value == true
                                  ? SizedBox(
                                      height: 12,
                                      width: 12,
                                      child: BaseHelper.loadingWidget(),
                                    )
                                  : Text(
                                      '${listSheduleWorkoutData.length} ${listSheduleWorkoutData.length > 1 ? "workouts" : "workout"}',
                                      style: AppTypography.paragraph12SM
                                          .copyWith(
                                              color:
                                                  AppColor.textPrimaryColor));
                            }),
                      ],
                    )),
          Expanded(
              child: ValueListenableBuilder<bool>(
                  valueListenable: shedulePlanLoader,
                  builder: (_, value, child) {
                    return box.values.any((element) =>
                            element.trainingplanId == trainingPlanData?.id)
                        ? SheduletButtonWidget(
                            text: followTrainingData?.workoutCount ==
                                    followTrainingData?.totalWorkoutLength
                                ? context.loc.doneText
                                : context.loc.buttonText('nextWorkout'),
                            onPressed: value == true
                                ? null
                                : () {
                                    if (followTrainingData?.workoutCount ==
                                        followTrainingData
                                            ?.totalWorkoutLength) {
                                      for (var i = 0;
                                          i < Boxes.getTrainingPlanBox().length;
                                          i++) {
                                        if (Boxes.getTrainingPlanBox()
                                                .values
                                                .toList()[i]
                                                .trainingplanId ==
                                            followTrainingData!
                                                .trainingplanId) {
                                          Boxes.getTrainingPlanBox()
                                              .deleteAt(i);
                                          context.popPage();
                                        }
                                      }
                                    } else {
                                      int nextIndex =
                                          followTrainingData!.workoutCount + 1;

                                      context.navigateTo(WorkoutDetailView(
                                          id: followTrainingData
                                                  ?.workoutData[
                                                      followTrainingData!
                                                          .workoutCount]
                                                  .workoutId ??
                                              '',
                                          followTrainingplanModel:
                                              FollowTrainingplanModel(
                                            trainingplanId: followTrainingData!
                                                .trainingplanId,
                                            workoutData: workoutLocalData,
                                            workoutCount: nextIndex,
                                            totalWorkoutLength:
                                                followTrainingData!
                                                    .totalWorkoutLength,
                                            outOfSequence: false,
                                            trainingPlanImg: followTrainingData!
                                                .trainingPlanImg,
                                            trainingPlanTitle:
                                                followTrainingData!
                                                    .trainingPlanTitle,
                                            daysPerWeek:
                                                followTrainingData!.daysPerWeek,
                                            goalsId:
                                                followTrainingData!.goalsId,
                                            levelName:
                                                followTrainingData!.levelName,
                                            location:
                                                followTrainingData!.location,
                                          )));
                                    }
                                  },
                            child: value == true
                                ? BaseHelper.loadingWidget()
                                : null)
                        : SheduletButtonWidget(
                            text: context.loc.buttonText("startFollow"),
                            onPressed: value == true
                                ? null
                                : () {
                                    final data = FollowTrainingplanModel(
                                        daysPerWeek:
                                            TrainingPlanDetailController
                                                .daysPerWeek
                                                .toString(),
                                        goalsId: trainingPlanData!.goals
                                            .map((e) => e)
                                            .join(','),
                                        levelName:
                                            trainingPlanData!.level.toString(),
                                        location: trainingPlanData!.locations
                                            .map((e) => e)
                                            .join(','),
                                        outOfSequence: false,
                                        trainingPlanImg:
                                            trainingPlanData?.mapImage?.url ??
                                                "",
                                        trainingPlanTitle:
                                            trainingPlanData?.title ?? '',
                                        trainingplanId: trainingPlanData!.id,
                                        workoutData: workoutLocalData,
                                        totalWorkoutLength:
                                            listSheduleWorkoutData.length,
                                        workoutCount: 0);
                                    box.add(data);
                                  },
                            child: value == true
                                ? BaseHelper.loadingWidget()
                                : null);
                  }))
        ],
      ),
    );
  }

  sheduleCardBoxWidget(BuildContext context, Box<FollowTrainingplanModel> box,
      bool shedulePlanLoader) {
    return Card(
        elevation: 0.2,
        color: AppColor.surfaceBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: shedulePlanLoader == true
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
                              padding: const EdgeInsets.only(top: 46),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: listSheduleWorkoutData.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    StepWidget(
                                        isCompleted: box.values.any((element) =>
                                                    element.trainingplanId ==
                                                        trainingPlanData?.id &&
                                                    index <=
                                                        element.workoutCount -
                                                            1.toInt()) ==
                                                true
                                            ? true
                                            : false,
                                        isActive: box.values.any((element) =>
                                                    element.trainingplanId ==
                                                        trainingPlanData?.id &&
                                                    index ==
                                                        element.workoutCount
                                                            .toInt()) ==
                                                true
                                            ? true
                                            : false),
                                    if (index !=
                                        listSheduleWorkoutData.length - 1)
                                      LineWidget(
                                        height: 78,
                                        color: box.values.any((element) =>
                                                element.trainingplanId ==
                                                    trainingPlanData?.id &&
                                                index <=
                                                    element.workoutCount -
                                                        1.toInt())
                                            ? AppColor.surfaceBrandDarkColor
                                            : null,
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
                            if (categoryFilterTypeData.isEmpty) {
                              CommonController.filterCategoryTypeData(
                                  listSheduleWorkoutData,
                                  categoryFilterTypeData);
                            }
                            if (workoutLocalData.isEmpty) {
                              addWorkoutData();
                            }
                            WorkoutModel? data = listSheduleWorkoutData[index];

                            return Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: CustomListtileWidget(
                                  imageHeaderIcon: AppAssets.workoutHeaderIcon,
                                  imageUrl: data.mapImage?.url ?? "",
                                  title: data.title ?? "",
                                  subtitle:
                                      " ${data.duration} • ${categoryFilterTypeData[index]} • ${data.level.toString()}",
                                  onTap: () {
                                    if (followTrainingData != null) {
                                      if (followTrainingData!.workoutCount ==
                                          index) {
                                        // followTrainingData
                                        //     ?.outOfSequence = false;
                                        // followTrainingData!
                                        //         .workoutCount =
                                        //     followTrainingData!
                                        //             .workoutCount +
                                        //         1;

                                        context.navigateTo(WorkoutDetailView(
                                            id: listSheduleWorkoutData[index]
                                                .id
                                                .toString(),
                                            followTrainingplanModel:
                                                FollowTrainingplanModel(
                                              workoutData: workoutLocalData,
                                              trainingplanId:
                                                  followTrainingData!
                                                      .trainingplanId,
                                              workoutCount: followTrainingData!
                                                      .workoutCount +
                                                  1,
                                              totalWorkoutLength:
                                                  followTrainingData!
                                                      .totalWorkoutLength,
                                              outOfSequence: false,
                                              trainingPlanImg:
                                                  followTrainingData!
                                                      .trainingPlanImg,
                                              trainingPlanTitle:
                                                  followTrainingData!
                                                      .trainingPlanTitle,
                                              daysPerWeek: followTrainingData!
                                                  .daysPerWeek,
                                              goalsId:
                                                  followTrainingData!.goalsId,
                                              levelName:
                                                  followTrainingData!.levelName,
                                              location:
                                                  followTrainingData!.location,
                                            )));
                                      } else if (followTrainingData!
                                              .workoutCount
                                              .toInt() >=
                                          index) {
                                        // followTrainingData
                                        //     ?.outOfSequence = false;

                                        context.navigateTo(WorkoutDetailView(
                                            id: listSheduleWorkoutData[index]
                                                .id
                                                .toString(),
                                            followTrainingplanModel:
                                                FollowTrainingplanModel(
                                              trainingplanId:
                                                  followTrainingData!
                                                      .trainingplanId,
                                              workoutData: workoutLocalData,
                                              workoutCount: index + 1,
                                              totalWorkoutLength:
                                                  followTrainingData!
                                                      .totalWorkoutLength,
                                              outOfSequence: false,
                                              trainingPlanImg:
                                                  followTrainingData!
                                                      .trainingPlanImg,
                                              trainingPlanTitle:
                                                  followTrainingData!
                                                      .trainingPlanTitle,
                                              daysPerWeek: followTrainingData!
                                                  .daysPerWeek,
                                              goalsId:
                                                  followTrainingData!.goalsId,
                                              levelName:
                                                  followTrainingData!.levelName,
                                              location:
                                                  followTrainingData!.location,
                                            )));
                                      } else {
                                        // followTrainingData
                                        //     ?.workoutCount = index + 1;
                                        // followTrainingData
                                        //     ?.outOfSequence = true;
                                        // updateData();

                                        context.navigateTo(WorkoutDetailView(
                                            id: listSheduleWorkoutData[index]
                                                .id
                                                .toString(),
                                            followTrainingplanModel:
                                                FollowTrainingplanModel(
                                              workoutData: workoutLocalData,
                                              trainingplanId:
                                                  followTrainingData!
                                                      .trainingplanId,
                                              workoutCount: index + 1,
                                              totalWorkoutLength:
                                                  followTrainingData!
                                                      .totalWorkoutLength,
                                              outOfSequence: true,
                                              trainingPlanImg:
                                                  followTrainingData!
                                                      .trainingPlanImg,
                                              trainingPlanTitle:
                                                  followTrainingData!
                                                      .trainingPlanTitle,
                                              daysPerWeek: followTrainingData!
                                                  .daysPerWeek,
                                              goalsId:
                                                  followTrainingData!.goalsId,
                                              levelName:
                                                  followTrainingData!.levelName,
                                              location:
                                                  followTrainingData!.location,
                                            )));
                                      }
                                    } else {
                                      context.navigateTo(WorkoutDetailView(
                                        id: listSheduleWorkoutData[index]
                                            .id
                                            .toString(),
                                      ));
                                    }
                                  }),
                            );
                          }),
                    ),
                  ],
                ),
        ));
  }

  SliverToBoxAdapter cardBoxWidget() {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        color: AppColor.surfaceBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 16),
          child: Column(
            children: [
              if (fitnessGoalData.isNotEmpty)
                CustomRowTextChartIcon(
                    text1: context.loc.goalText,
                    text2: fitnessGoalData.entries.first.value),
              if (trainingPlanData != null) ...[
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: CustomDivider(),
                ),
                CustomRowTextChartIcon(
                  level: trainingPlanData?.level.toString() ?? "",
                  text1: context.loc.levelText,
                  text2: trainingPlanData?.level.toString() ?? "",
                  isChartIcon: true,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class FollowedBorderWidget extends StatelessWidget {
  const FollowedBorderWidget(
      {super.key, required this.followTrainingData, this.color, this.color2});

  final FollowTrainingplanModel? followTrainingData;
  final Color? color, color2;
  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(
      followTrainingData?.totalWorkoutLength ?? 0,
      (index) => Flexible(
        child: Container(
          height: 6,
          margin: const EdgeInsets.only(left: 2, right: 2),
          // foregroundDecoration: BoxDecoration(
          //   color:
          // ),
          decoration: BoxDecoration(
              color: index + 1 <= followTrainingData!.workoutCount.toInt()
                  ? color ?? AppColor.textInvertEmphasis
                  : color2 ?? AppColor.surfaceBrandSecondaryColor,
              borderRadius: BorderRadius.circular(16)),
        ),
      ),
    ));
  }
}
