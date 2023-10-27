import 'dart:async';

import 'package:flutter/material.dart';

import 'package:funxtion/funxtion_sdk.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../widgets/header_imagesHeader_widget.dart';

class WorkoutDetailView extends StatefulWidget {
  final String id;
  const WorkoutDetailView({
    super.key,
    required this.id,
  });

  @override
  State<WorkoutDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<WorkoutDetailView> {
  bool isLoadingNotifier = false;
  bool isNodData = false;
  late ScrollController scrollController;
  WorkoutModel? workoutData;
  FitnessGoalModel? fitnessGoalData;
  BodyPartModel? bodyPartData;
  List<ExerciseModel> exerciseData = [];
  List<ExerciseModel> exerciseWorkoutData = [];
  List<ExerciseModel> exerciseWorkoutData2 = [];
  ValueNotifier<bool> centerTitle = ValueNotifier(false);
  ValueNotifier<bool> warmUpLoader = ValueNotifier(true);
  ValueNotifier<bool> trainingLoader = ValueNotifier(true);
  ValueNotifier<bool> trainingLoader2 = ValueNotifier(true);
  ValueNotifier<bool> goalLoader = ValueNotifier(true);
  ValueNotifier<bool> bodyPartLoader = ValueNotifier(true);

  ValueNotifier<bool> warmUpExpand = ValueNotifier(true);

  ValueNotifier<bool> warmUpExpand1 = ValueNotifier(true);
  ValueNotifier<bool> trainingExpand = ValueNotifier(false);
  ValueNotifier<bool> trainingExpand2 = ValueNotifier(false);
  ValueNotifier<bool> btnLoader = ValueNotifier(false);
  late final Timer _timer;
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

    WorkoutDetailController.getworkoutData(context, id: widget.id)
        .then((value) async {
      if (value != null && context.mounted) {
        isLoadingNotifier = false;
        workoutData = value;

        setState(() {});

        if (workoutData?.goals.isNotEmpty ?? false) {
          WorkoutDetailController.getGoal(
                  context, workoutData?.goals.first.toString() ?? '')
              .then((value) {
            if (value != null) {
              fitnessGoalData = value;
              goalLoader.value = false;
            } else {
              goalLoader.value = false;
            }
          });
        }
        if (workoutData?.bodyParts.isNotEmpty ?? false) {
          if (workoutData?.goals.isEmpty ?? false) goalLoader.value = false;
          bodyPartLoader.value = true;
          WorkoutDetailController.getBodyPart(
                  context, workoutData?.bodyParts.first.toString() ?? "")
              .then((value) {
            if (value != null) {
              bodyPartData = value;
              bodyPartLoader.value = false;
            } else {
              bodyPartLoader.value = false;
            }
          });
        }
        if (workoutData!.phases![0].items.isNotEmpty) {
          WorkoutDetailController.getWarmUpData(context,
              warmUpLoader: warmUpLoader,
              workoutData: workoutData,
              exerciseData: exerciseData);
        }
        if (workoutData!.phases![1].items.isNotEmpty) {
          if (workoutData!.phases![0].items.isEmpty) {
            warmUpLoader.value = false;
          }
          if (workoutData!.phases![1].items.first.ctRounds!.isNotEmpty) {
            if (workoutData!.phases![1].items.first.rftExercises!.isEmpty) {
              trainingLoader2.value = false;
            }

            WorkoutDetailController.getTrainingData(
              context,
              trainingLoader: trainingLoader,
              workoutData: workoutData,
              exerciseWorkoutData: exerciseWorkoutData,
            );
          }
          if (workoutData!.phases![1].items.first.rftExercises!.isNotEmpty) {
            if (workoutData!.phases![1].items.first.ctRounds!.isEmpty) {
              trainingLoader.value = false;
            }
            WorkoutDetailController.getTrainingData2(
              context,
              trainingLoader: trainingLoader2,
              workoutData: workoutData,
              exerciseWorkoutData: exerciseWorkoutData2,
            );
          }
        }

        return;
      } else {
        isLoadingNotifier = false;
        isNodData = true;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoadingNotifier == true
            ? const LoaderStackWidget()
            : isNodData == true
                ? const Center(child: CustomErrorWidget())
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
                                    appBarTitle: "${workoutData?.title}",
                                    backGroundImg:
                                        workoutData?.mapImage?.url.toString() ??
                                            "",
                                    flexibleTitle: "${workoutData?.title}",
                                    flexibleTitle2:
                                        "${workoutData?.duration.getTextAfterSymbol()} min • ${workoutData?.types.toString()}",
                                    value: value,
                                  ),
                                  if (workoutData?.description?.isNotEmpty ??
                                      true)
                                    DescriptionBoxWidget(
                                      text:
                                          workoutData?.description.toString() ??
                                              "",
                                    ),
                                  cardBoxWidget(context),
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Workout Overview',
                                        style: AppTypography.title24XL.copyWith(
                                            color: AppColor.textEmphasisColor),
                                      ),
                                    ),
                                  ),
                                  warmUpSliverWidget(),
                                  SliverPadding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 20),
                                    sliver: circuitTimeSliverWidget(),
                                  ),
                                  SliverPadding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 20),
                                    sliver: repsTimeSliverWidget(),
                                  ),
                                ],
                              );
                            }),
                      ),
                      bottomWidget()
                    ],
                  ));
  }

  Container bottomWidget() {
    return Container(
      color: AppColor.surfaceBackgroundColor,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24, top: 24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${workoutData?.title}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.title14XS
                      .copyWith(color: AppColor.textEmphasisColor),
                ),
                4.height(),
                Text("${workoutData?.duration.getTextAfterSymbol()} min",
                    style: AppTypography.paragraph12SM
                        .copyWith(color: AppColor.textPrimaryColor))
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: btnLoader,
                builder: (context, value, child) {
                  return StartButtonWidget(
                    onPressed: value == false
                        ? () async {
                            if (warmUpLoader.value ||
                                trainingLoader.value ||
                                trainingLoader2.value) {
                              _timer = Timer.periodic(
                                  const Duration(milliseconds: 800), (_) async {
                                if (warmUpLoader.value ||
                                    trainingLoader.value ||
                                    trainingLoader2.value) {
                                  btnLoader.value = true;
                                } else {
                                  btnLoader.value = false;
                                  _timer.cancel();
                                  await sheet(context);
                                }
                              });
                            } else {
                              await sheet(context);
                            }
                          }
                        : null,
                    btnChild: value == true
                        ? BaseHelper.loadingWidget()
                        : Text(
                            'Start Workout',
                            style: AppTypography.label18LG
                                .copyWith(color: const Color(0xff5A7DCE)),
                          ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Future<dynamic> sheet(BuildContext context) async {
    return await showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) => StartWorkoutSheet(
              fitnessGoalModel: fitnessGoalData,
              exerciseData: exerciseData,
              exerciseWorkoutData: exerciseWorkoutData,
              workoutModel: workoutData as WorkoutModel,
              exerciseWorkoutData2: exerciseWorkoutData2,
            ));
  }

  MultiSliver circuitTimeSliverWidget() {
    return MultiSliver(pushPinnedChildren: true, children: [
      SliverPinnedHeader(
          child: BuildHeader2(
        expandBodyValueListenable: ValueNotifier(true),
        subtitle:
            "${workoutData?.phases?[1].items.first.ctRounds?.length == 0 ? 0 : workoutData?.phases?[1].items.first.ctRounds?.length} rounds",
        loaderListenable: trainingLoader,
        title: "Circuit Time",
        expandValueListenable: trainingExpand,
        onTap: () {
          trainingExpand.value = !trainingExpand.value;
        },
        exerciseWorkoutData: exerciseWorkoutData,
      )),
      SliverToBoxAdapter(
          child: BuildBodySingleExercise(
              bodySubtitle:
                  "${workoutData?.phases?[1].items.first.ctRounds?.length == 0 ? "" : workoutData?.phases?[1].items.first.ctRounds?.first.exercises.map((e) => e.notes).toString()}",
              workoutModel: workoutData,
              dataList: exerciseWorkoutData,
              valueListenable: trainingExpand,
              valueListenable1: trainingLoader))
    ]);
  }

  MultiSliver repsTimeSliverWidget() {
    return MultiSliver(pushPinnedChildren: true, children: [
      SliverPinnedHeader(
          child: BuildHeader2(
        expandBodyValueListenable: ValueNotifier(true),
        subtitle:
            "${workoutData?.phases?[1].items.first.rftExercises?.length == 0 ? "0" : workoutData?.phases?[1].items.first.rftExercises?.first.goalTargets.length} rounds",
        loaderListenable: trainingLoader2,
        title: "Reps Time",
        expandValueListenable: trainingExpand2,
        onTap: () {
          trainingExpand2.value = !trainingExpand2.value;
        },
        exerciseWorkoutData: exerciseWorkoutData2,
      )),
      SliverToBoxAdapter(
          child: BuildBodySingleExercise(
              bodySubtitle:
                  "${workoutData?.phases?[1].items.first.rftExercises?.length != 0 ? {
                      workoutData
                          ?.phases?[1].items.first.rftExercises?.first.notes
                    } : ""}",
              workoutModel: workoutData,
              dataList: exerciseWorkoutData2,
              valueListenable: trainingExpand2,
              valueListenable1: trainingLoader2))
    ]);
  }

  MultiSliver warmUpSliverWidget() {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPinnedHeader(
          child: BuildHeader(
            loaderListenAble: warmUpLoader,
            dataLIst: exerciseData,
            title: 'Warmup',
            valueListenable: warmUpExpand,
            onTap: () {
              if (warmUpExpand.value == true) {
                warmUpExpand.value = false;
                warmUpExpand1.value = false;
              } else {
                warmUpExpand.value = true;
              }
            },
          ),
        ),
        BuildHeader2(
          expandBodyValueListenable: warmUpExpand,
          subtitle:
              "${workoutData?.phases?.first.items.length == 0 ? 0 : workoutData?.phases?.first.items.first.seExercises?.first.sets.length} rounds",
          loaderListenable: warmUpLoader,
          expandValueListenable: warmUpExpand1,
          exerciseWorkoutData: exerciseData,
          title: 'Single Exercise',
          onTap: () {
            warmUpExpand1.value = !warmUpExpand1.value;
          },
        ),
        SliverToBoxAdapter(
            child: BuildBodySingleExercise(
          workoutModel: workoutData,
          dataList: exerciseData,
          valueListenable: warmUpExpand1,
          valueListenable1: warmUpLoader,
          bodySubtitle:
              "${workoutData?.phases?[0].items.length == 0 ? '' : workoutData?.phases?[0].items.first.seExercises?.map((e) => e.sets.first.goalTargets.first.value)} seconds",
        ))
      ],
    );
  }

  SliverToBoxAdapter cardBoxWidget(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0.2,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
        color: AppColor.surfaceBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 16),
          child: Column(
            children: [
              CustomRowTextChartIcon(
                level: workoutData?.level.toString() ?? "",
                text1: 'Level',
                text2: workoutData?.level.toString() ?? "",
                isChartIcon: true,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: CustomDivider(),
              ),
              const CustomRowTextChartIcon(
                  text1: 'Equipment', text2: "No Data"),
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
                          text2: fitnessGoalData?.name ?? "",
                        );
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: CustomDivider(),
              ),
              ValueListenableBuilder(
                valueListenable: bodyPartLoader,
                builder: (context, value, child) {
                  return value == true
                      ? Center(
                          child: BaseHelper.loadingWidget(),
                        )
                      : CustomRowTextChartIcon(
                          text1: 'Bodyparts',
                          text2: bodyPartData?.name ?? "",
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
