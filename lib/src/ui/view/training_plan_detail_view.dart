import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:ui_tool_kit/src/helper/boxes.dart';
import 'package:ui_tool_kit/src/model/follow_trainingplan_model.dart';
import 'package:ui_tool_kit/src/ui/view/workout_detail_view.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class TrainingPlanDetailView extends StatefulWidget {
  final String workoutLength;
  final String id;

  const TrainingPlanDetailView(
      {super.key, required this.id, required this.workoutLength});

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
  Map<int, String> typeData = {};
  ValueNotifier<bool> typeLoader = ValueNotifier(false);
  List<Map<String, String>> workoutLocalData = [];
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
    CategoryListController.getCategoryTypeDataFn(context, typeLoader);
    TrainingPlanDetailController.getTrainingPlanData(context, id: widget.id)
        .then((data) async {
      if (data != null && context.mounted) {
        isLoadingNotifier = false;
        trainingPlanData = data;

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

  addDataCategories() {
    List<ContentProvidersCategoryOnDemandModel> data = [];
    if (data.isEmpty) {
      for (var i = 0; i < listSheduleWorkoutData.length; i++) {
        data = [];
        for (var typeElement in listSheduleWorkoutData[i]!.types!) {
          for (var j = 0;
              j < CategoryListController.categoryTypeData.length;
              j++) {
            if (CategoryListController.categoryTypeData[j].id == typeElement) {
              data.add(CategoryListController.categoryTypeData[j]);
            }
          }
        }

        typeData.addAll({i: data.map((e) => e.name).join(',')});
      }
    }
  }

  addWorkoutData() {
    for (var i = 0; i < listSheduleWorkoutData.length; i++) {
      workoutLocalData.add({
        "workoutTitle": listSheduleWorkoutData[i]!.title.toString(),
        "workoutSubtitle":
            "${listSheduleWorkoutData[0]!.duration} • ${typeData[i]} • ${listSheduleWorkoutData[0]!.level}",
        "workoutId": listSheduleWorkoutData[i]!.id.toString(),
        "workoutImg": listSheduleWorkoutData[i]!.mapImage!.url
      });
    }
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
        }
      }
    } else {
      followTrainingData = null;
    }
  }

  // updateData() {
  //   followTrainingData!.nextWorkoutImage =
  //       listSheduleWorkoutData[followTrainingData!.workoutCount]!
  //           .mapImage!
  //           .url
  //           .toString();
  //   followTrainingData!.nextWorkoutId =
  //       listSheduleWorkoutData[followTrainingData!.workoutCount]!.id.toString();
  //   followTrainingData!.nextWorkoutTitle =
  //       listSheduleWorkoutData[followTrainingData!.workoutCount]!
  //           .title
  //           .toString();
  //   followTrainingData!.nextWorkoutSubtitle =
  //       "${listSheduleWorkoutData[followTrainingData!.workoutCount]!.duration.toString()} • ${listSheduleWorkoutData[followTrainingData!.workoutCount]!.level.toString()}";
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<FollowTrainingplanModel>>(
        valueListenable: Boxes.getData().listenable(),
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
                                        flexibleSubtitleWidget: Text(
                                          "${widget.workoutLength} workouts • ${fitnessGoalData?.name} • ${trainingPlanData?.level.toString() ?? ""}",
                                          style: AppTypography.label16MD
                                              .copyWith(
                                                  color: AppColor
                                                      .textInvertPrimaryColor),
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
                isLoadingNotifier == false&&isNodData==false ? bottomWidget(box) : null,
          );
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
              child: box.values.any((element) =>
                      element.trainingplanId == trainingPlanData?.id)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Next up",
                          style: AppTypography.paragraph12SM
                              .copyWith(color: AppColor.textPrimaryColor),
                        ),
                        4.height(),
                        Text(
                            "${followTrainingData?.workoutData[followTrainingData!.workoutCount]['workoutTitle'].toString()}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.title14XS
                                .copyWith(color: AppColor.textEmphasisColor))
                      ],
                    )
                  : Column(
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
                        Text("${widget.workoutLength} workouts",
                            style: AppTypography.paragraph12SM
                                .copyWith(color: AppColor.textPrimaryColor))
                      ],
                    )),
          Expanded(
              child: ValueListenableBuilder<bool>(
                  valueListenable: shedulePlanLoader,
                  builder: (_, value, child) {
                    return box.values.any((element) =>
                            element.trainingplanId == trainingPlanData?.id)
                        ? SheduletButtonWidget(
                            text: 'Next Workout',
                            onPressed: value == true
                                ? null
                                : () {
                                    int nextIndex =
                                        followTrainingData!.workoutCount + 1;
                                    // box.clear();
                                    // followTrainingData?.outOfSequence = false;
                                    // followTrainingData!.workoutCount =
                                    //     followTrainingData!.workoutCount
                                    //             .toInt() +
                                    //         1;
                                    // updateData();
                                    context.navigateTo(WorkoutDetailView(
                                        id: followTrainingData?.workoutData[
                                                    followTrainingData!
                                                        .workoutCount]
                                                ['workoutId'] ??
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
                                          trainingPlanTitle: followTrainingData!
                                              .trainingPlanTitle,
                                          daysPerWeek:
                                              followTrainingData!.daysPerWeek,
                                          goalsId: followTrainingData!.goalsId,
                                          levelName:
                                              followTrainingData!.levelName,
                                          location:
                                              followTrainingData!.location,
                                        )));
                                  },
                            child: value == true
                                ? BaseHelper.loadingWidget()
                                : null)
                        : SheduletButtonWidget(
                            text: "Start Following",
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
                            child: value == true
                                ? BaseHelper.loadingWidget()
                                : null);
                  }))
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
                                                            element.workoutCount
                                                                .toInt())),
                                            if (index !=
                                                listSheduleWorkoutData.length -
                                                    1)
                                              const LineWidget(
                                                height: 75,
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
                                    if (typeData.isEmpty) {
                                      addDataCategories();
                                    }
                                    if (workoutLocalData.isEmpty) {
                                      addWorkoutData();
                                    }
                                    WorkoutModel? data =
                                        listSheduleWorkoutData[index];

                                    return Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: CustomTileTrainingPlanWidget(
                                          imageUrl: data?.mapImage?.url ?? "",
                                          title: data?.title ?? "",
                                          subtitle:
                                              " ${data?.duration} ${typeData[index]} • ${data?.level}",
                                          onTap: () {
                                            if (followTrainingData != null) {
                                              if (followTrainingData!
                                                      .workoutCount ==
                                                  index) {
                                                // followTrainingData
                                                //     ?.outOfSequence = false;
                                                // followTrainingData!
                                                //         .workoutCount =
                                                //     followTrainingData!
                                                //             .workoutCount +
                                                //         1;

                                                context.navigateTo(
                                                    WorkoutDetailView(
                                                        id: listSheduleWorkoutData[
                                                                    index]
                                                                ?.id
                                                                .toString() ??
                                                            '',
                                                        followTrainingplanModel:
                                                            FollowTrainingplanModel(
                                                          workoutData:
                                                              workoutLocalData,
                                                          trainingplanId:
                                                              followTrainingData!
                                                                  .trainingplanId,
                                                          workoutCount:
                                                              followTrainingData!
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
                                                          daysPerWeek:
                                                              followTrainingData!
                                                                  .daysPerWeek,
                                                          goalsId:
                                                              followTrainingData!
                                                                  .goalsId,
                                                          levelName:
                                                              followTrainingData!
                                                                  .levelName,
                                                          location:
                                                              followTrainingData!
                                                                  .location,
                                                        )));
                                              } else if (followTrainingData!
                                                      .workoutCount
                                                      .toInt() >=
                                                  index) {
                                                // followTrainingData
                                                //     ?.outOfSequence = false;

                                                context.navigateTo(
                                                    WorkoutDetailView(
                                                        id: listSheduleWorkoutData[
                                                                    index]
                                                                ?.id
                                                                .toString() ??
                                                            '',
                                                        followTrainingplanModel:
                                                            FollowTrainingplanModel(
                                                          trainingplanId:
                                                              followTrainingData!
                                                                  .trainingplanId,
                                                          workoutData:
                                                              workoutLocalData,
                                                          workoutCount:
                                                              index + 1,
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
                                                          daysPerWeek:
                                                              followTrainingData!
                                                                  .daysPerWeek,
                                                          goalsId:
                                                              followTrainingData!
                                                                  .goalsId,
                                                          levelName:
                                                              followTrainingData!
                                                                  .levelName,
                                                          location:
                                                              followTrainingData!
                                                                  .location,
                                                        )));
                                              } else {
                                                // followTrainingData
                                                //     ?.workoutCount = index + 1;
                                                // followTrainingData
                                                //     ?.outOfSequence = true;
                                                // updateData();

                                                context.navigateTo(
                                                    WorkoutDetailView(
                                                        id: listSheduleWorkoutData[
                                                                    index]
                                                                ?.id
                                                                .toString() ??
                                                            '',
                                                        followTrainingplanModel:
                                                            FollowTrainingplanModel(
                                                          workoutData:
                                                              workoutLocalData,
                                                          trainingplanId:
                                                              followTrainingData!
                                                                  .trainingplanId,
                                                          workoutCount:
                                                              index + 1,
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
                                                          daysPerWeek:
                                                              followTrainingData!
                                                                  .daysPerWeek,
                                                          goalsId:
                                                              followTrainingData!
                                                                  .goalsId,
                                                          levelName:
                                                              followTrainingData!
                                                                  .levelName,
                                                          location:
                                                              followTrainingData!
                                                                  .location,
                                                        )));
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

class FollowedBorderWidget extends StatelessWidget {
  const FollowedBorderWidget({
    super.key,
    required this.followTrainingData,
  });

  final FollowTrainingplanModel? followTrainingData;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        runSpacing: 4,
        spacing: 4,
        children: List.generate(
          followTrainingData?.totalWorkoutLength.toInt() ?? 0,
          (index) => Container(
            height: 6,
            width: 22,
            // foregroundDecoration: BoxDecoration(
            //   color:
            // ),
            decoration: BoxDecoration(
                color: index + 1 <= followTrainingData!.workoutCount.toInt()
                    ? AppColor.textInvertEmphasis
                    : AppColor.surfaceBrandSecondaryColor,
                borderRadius: BorderRadius.circular(16)),
          ),
        ));
  }
}


