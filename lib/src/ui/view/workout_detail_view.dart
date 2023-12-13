import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/src/model/follow_trainingplan_model.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';
import 'package:sliver_tools/sliver_tools.dart';

class WorkoutDetailView extends StatefulWidget {
  final String id;
  final String? trainingPlanName;
  final FollowTrainingplanModel? followTrainingplanModel;
  const WorkoutDetailView(
      {super.key,
      required this.id,
      this.followTrainingplanModel,
      this.trainingPlanName});

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
  Map<ExerciseDetailModel, ExerciseModel> warmUpData = {};
  Map<ExerciseDetailModel, ExerciseModel> trainingData = {};
  Map<ExerciseDetailModel, ExerciseModel> coolDownData = {};

  ValueNotifier<bool> centerTitle = ValueNotifier(false);
  ValueNotifier<bool> warmUpLoader = ValueNotifier(true);
  ValueNotifier<bool> trainingLoader = ValueNotifier(true);
  ValueNotifier<bool> coolDownLoader = ValueNotifier(true);
  ValueNotifier<bool> goalLoader = ValueNotifier(true);
  ValueNotifier<bool> bodyPartLoader = ValueNotifier(true);

  ValueNotifier<bool> warmUpExpand = ValueNotifier(true);

  ValueNotifier<bool> warmUpExpand1 = ValueNotifier(true);
  ValueNotifier<bool> trainingExpand = ValueNotifier(false);
  ValueNotifier<bool> coolDownExpand = ValueNotifier(false);
  ValueNotifier<bool> btnLoader = ValueNotifier(false);
  Timer? _timer;
  @override
  void initState() {
    WorkoutDetailController.shouldBreakLoop = false;

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

  checkDataWarmUpTraining() {
    if (workoutData?.phases?[0].items?.isEmpty ?? false) {
      warmUpLoader.value = false;
      trainingExpand.value = true;
    }
    if (workoutData?.phases?[1].items?.isEmpty ?? false) {
      trainingLoader.value = false;
      coolDownExpand.value = true;
    }
  }

  fetchData() async {
    isLoadingNotifier = true;
    isNodData = false;
    WorkoutDetailController.equipmentData.value.clear();

    WorkoutDetailController.getworkoutData(context, id: widget.id)
        .then((value) async {
      if (value != null &&
          context.mounted &&
          WorkoutDetailController.shouldBreakLoop == false) {
        isLoadingNotifier = false;
        workoutData = value;
        checkDataWarmUpTraining();
        setState(() {});
        if (workoutData?.phases?[0].items?.isNotEmpty == true &&
            WorkoutDetailController.shouldBreakLoop == false) {
          await WorkoutDetailController.getWarmUpData(
            context,
            warmUpLoader: warmUpLoader,
            warmupData: warmUpData,
            workoutData: workoutData,
          );
        }
        if (workoutData?.goals?.isNotEmpty == true &&
            WorkoutDetailController.shouldBreakLoop == false) {
          WorkoutDetailController.getGoal(
                  context, workoutData?.goals?.first.toString() ?? '')
              .then((value) {
            if (value != null &&
                WorkoutDetailController.shouldBreakLoop == false) {
              fitnessGoalData = value;
              goalLoader.value = false;
            } else {
              goalLoader.value = false;
            }
          });
        }
        if (workoutData?.bodyParts?.isNotEmpty == true &&
            WorkoutDetailController.shouldBreakLoop == false) {
          if (workoutData?.goals?.isEmpty == true &&
              WorkoutDetailController.shouldBreakLoop == false)
            goalLoader.value = false;
          bodyPartLoader.value = true;
          try {
            WorkoutDetailController.getBodyPart(
                    context, workoutData?.bodyParts?.first.toString() ?? "")
                .then((value) {
              if (value != null &&
                  WorkoutDetailController.shouldBreakLoop == false) {
                bodyPartData = value;
                bodyPartLoader.value = false;
              } else {
                bodyPartLoader.value = false;
              }
            });
          } on RequestException catch (e) {
            BaseHelper.showSnackBar(context, e.message);
          }
        }

        if (workoutData?.phases?[1].items?.isNotEmpty == true &&
            WorkoutDetailController.shouldBreakLoop == false) {
          await WorkoutDetailController.getTrainingData(
            context,
            trainingLoader: trainingLoader,
            workoutData: workoutData,
            trainingData: trainingData,
            // circuitTimeTrainingData: circuitTimeTrainingData,
            // rftExerciseTrainingData: rftExerciseTrainingData,
            // seExerciseTrainingData: seExerciseTrainingData,
            // ssExerciseTrainingData: ssExerciseTrainingData,
          );
        }
        if (workoutData?.phases?[2].items?.isNotEmpty == true &&
            WorkoutDetailController.shouldBreakLoop == false) {
          await WorkoutDetailController.getCoolDownData(
            context,
            coolDownLoader: coolDownLoader,
            workoutData: workoutData,
            coolDownData: coolDownData,
            // circuitTimeCoolDownData: circuitTimeCoolDownData,
            // rftExerciseCoolDownData: rftExerciseCoolDownData,
            // seExerciseCoolDownData: seExerciseCoolDownData,
            // ssExerciseCoolDOwnData: ssExerciseCoolDOwnData,
          );
        }
        if (workoutData?.phases?[2].items?.isEmpty ?? false) {
          coolDownLoader.value = false;
        }
        log(" warmup data $warmUpData");
        log(" training data $trainingData");
        log(" cool down data  $coolDownData");
        if (WorkoutDetailController.shouldBreakLoop == false) {
          setState(() {});
        }
      } else {
        isLoadingNotifier = false;
        isNodData = true;
        if (WorkoutDetailController.shouldBreakLoop == false) {
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    WorkoutDetailController.shouldBreakLoop = true;
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }

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
                                      "${workoutData?.duration?.getTextAfterSymbol()} min • ${workoutData?.types.toString()}",
                                  value: value,
                                ),
                                if (workoutData?.description?.isNotEmpty ??
                                    true)
                                  DescriptionBoxWidget(
                                    text: workoutData?.description.toString() ??
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
                                if (workoutData
                                        ?.phases?.first.items?.isNotEmpty !=
                                    false)
                                  phasesBodyWidget(
                                      title: "Warmup",
                                      expandNotifier: warmUpExpand,
                                      loaderNotifier: warmUpLoader,
                                      dataList: warmUpData),
                                if (workoutData?.phases?[1].items?.isNotEmpty !=
                                    false)
                                  SliverPadding(
                                    padding: const EdgeInsets.only(
                                      top: 12,
                                    ),
                                    sliver: phasesBodyWidget(
                                        title: "Training",
                                        expandNotifier: trainingExpand,
                                        loaderNotifier: trainingLoader,
                                        dataList: trainingData),
                                  ),
                                if (workoutData?.phases?[2].items?.isNotEmpty !=
                                    false)
                                  SliverPadding(
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 20),
                                    sliver: phasesBodyWidget(
                                        title: "CoolDown",
                                        expandNotifier: coolDownExpand,
                                        loaderNotifier: coolDownLoader,
                                        dataList: coolDownData),
                                  ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
      bottomNavigationBar: isLoadingNotifier == false ? bottomWidget() : null,
    );
  }

  Container bottomWidget() {
    return Container(
      color: AppColor.surfaceBackgroundColor,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24, top: 24),
      child: Row(
        children: [
          Expanded(
              child: widget.followTrainingplanModel == null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
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
                        Text(
                            "${workoutData?.duration?.getTextAfterSymbol()} min",
                            style: AppTypography.paragraph12SM
                                .copyWith(color: AppColor.textPrimaryColor))
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.trainingPlanName}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.title14XS
                              .copyWith(color: AppColor.textEmphasisColor),
                        ),
                        4.height(),
                        Text(
                            "Workout ${widget.followTrainingplanModel?.workoutCount}/${widget.followTrainingplanModel?.totalWorkoutLength} ",
                            style: AppTypography.paragraph12SM
                                .copyWith(color: AppColor.textPrimaryColor))
                      ],
                    )),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: btnLoader,
                builder: (context, value, child) {
                  return StartButtonWidget(
                    onPressed: value == false
                        ? () async {
                            if (warmUpLoader.value ||
                                trainingLoader.value ||
                                coolDownLoader.value) {
                              _timer = Timer.periodic(
                                  const Duration(milliseconds: 800), (_) async {
                                if (warmUpLoader.value ||
                                    trainingLoader.value ||
                                    coolDownLoader.value) {
                                  btnLoader.value = true;
                                } else {
                                  _timer?.cancel();
                                  btnLoader.value = false;
                                  if (widget.followTrainingplanModel
                                          ?.outOfSequence ==
                                      true) {
                                    log("out of Sequence");
                                  } else {
                                    await startWorkoutSheet(context);
                                  }
                                }
                              });
                            } else {
                              if (widget
                                      .followTrainingplanModel?.outOfSequence ==
                                  true) {
                                log("out of Sequence");
                              } else {
                                await startWorkoutSheet(context);
                              }
                            }
                          }
                        : null,
                    btnChild: value == true
                        ? BaseHelper.loadingWidget()
                        : Text(
                            'Start Workout',
                            style: AppTypography.label18LG.copyWith(
                                color: widget.followTrainingplanModel
                                            ?.outOfSequence ==
                                        true
                                    ? AppColor.buttonSecondaryColor
                                    : AppColor.textInvertEmphasis),
                          ),
                    btnColor:
                        widget.followTrainingplanModel?.outOfSequence == true
                            ? null
                            : AppColor.buttonPrimaryColor,
                  );
                }),
          ),
        ],
      ),
    );
  }

  Future<dynamic> startWorkoutSheet(BuildContext context) async {
    return await showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: StartWorkoutSheet(
                equipmentData: WorkoutDetailController.equipmentData.value,
                fitnessGoalModel: fitnessGoalData,
                warmUpData: warmUpData,
                trainingData: trainingData,
                workoutModel: workoutData as WorkoutModel,
                coolDownData: coolDownData,
              ),
            ));
  }

  MultiSliver phasesBodyWidget(
      {required String title,
      required ValueNotifier<bool> expandNotifier,
      required ValueNotifier<bool> loaderNotifier,
      required Map<ExerciseDetailModel, ExerciseModel> dataList}) {
    return MultiSliver(pushPinnedChildren: true, children: [
      SliverPinnedHeader(
        child: BuildHeader(
          loaderListenAble: loaderNotifier,
          dataLIst: dataList,
          title: title,
          expandHeaderValueListenable: expandNotifier,
          onTap: () {
            expandNotifier.value = !expandNotifier.value;
          },
        ),
      ),
      SliverToBoxAdapter(
        child: BuildBodyWidget(
          currentListData: dataList,
          expandHeaderValueListenable: expandNotifier,
          loaderValueListenable: loaderNotifier,
        ),
      ),
    ]);
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
              ValueListenableBuilder<bool>(
                  valueListenable: coolDownLoader,
                  builder: (context, value, child) {
                    return value == true
                        ? Center(child: BaseHelper.loadingWidget())
                        : CustomRowTextChartIcon(
                            text1: 'Equipment',
                            secondWidget: ValueListenableBuilder<
                                    List<EquipmentModel>>(
                                valueListenable:
                                    WorkoutDetailController.equipmentData,
                                builder: (_, value, child) {
                                  return SizedBox(
                                    height: 20,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: value.length,
                                      itemBuilder: (context, index) {
                                        if (index ==
                                                WorkoutDetailController
                                                        .equipmentData
                                                        .value
                                                        .length -
                                                    2 &&
                                            index > 1) {
                                          return Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("+${value.length - 2}"),
                                              2.width(),
                                              InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    backgroundColor: AppColor
                                                        .surfaceBackgroundBaseColor,
                                                    useSafeArea: true,
                                                    isScrollControlled: true,
                                                    context: context,
                                                    builder: (context) =>
                                                        EquipmentExtendedSheet(
                                                            workoutModel:
                                                                workoutData
                                                                    as WorkoutModel,
                                                            equipmentData:
                                                                WorkoutDetailController
                                                                    .equipmentData
                                                                    .value),
                                                  );
                                                },
                                                child: Transform.translate(
                                                  offset: Offset(0, -4),
                                                  child: Icon(Icons.more_horiz),
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                        if (index > 0 && index < 2) {
                                          return Text(",${value[index].name}");
                                        }
                                        if (index == 0) {
                                          return Text(value[index].name);
                                        }
                                        return Container();
                                      },
                                    ),
                                  );
                                }));
                  }),
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
