import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:hive/hive.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';
import 'package:sliver_tools/sliver_tools.dart';

class WorkoutDetailView extends StatefulWidget {
  final String id;

  final FollowTrainingplanModel? followTrainingplanModel;
  const WorkoutDetailView({
    super.key,
    required this.id,
    this.followTrainingplanModel,
  });

  @override
  State<WorkoutDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<WorkoutDetailView> {
  Box<FollowTrainingplanModel>? _box;
  bool isLoadingNotifier = false;
  bool isNodData = false;
  late ScrollController scrollController;
  WorkoutModel? workoutData;
  Map<int, String> fitnessGoalData = {};
  BodyPartModel? bodyPartData;
  List<int> equipmentIds = [];
  Map<ExerciseDetailModel, ExerciseModel> warmUpData = {};
  Map<ExerciseDetailModel, ExerciseModel> trainingData = {};
  Map<ExerciseDetailModel, ExerciseModel> coolDownData = {};

  ValueNotifier<bool> centerTitle = ValueNotifier(false);
  ValueNotifier<bool> warmUpLoader = ValueNotifier(true);
  ValueNotifier<bool> trainingLoader = ValueNotifier(true);
  ValueNotifier<bool> coolDownLoader = ValueNotifier(true);

  ValueNotifier<bool> bodyPartLoader = ValueNotifier(true);

  ValueNotifier<bool> warmUpExpand = ValueNotifier(true);

  ValueNotifier<bool> warmUpExpand1 = ValueNotifier(true);
  ValueNotifier<bool> trainingExpand = ValueNotifier(false);
  ValueNotifier<bool> coolDownExpand = ValueNotifier(false);
  ValueNotifier<bool> btnLoader = ValueNotifier(false);

  // ValueNotifier<bool> typeLoader = ValueNotifier(true);
  List<ContentProvidersCategoryOnDemandModel> categoryTypeData = [];
  List<EquipmentModel> equipmentData = [];
  Timer? _timer;
  @override
  void initState() {
    fetchData();
    _box = Boxes.getTrainingPlanBox();

    WorkoutDetailController.shouldBreakLoop = false;
    checkData();
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset > 155) {
          centerTitle.value = true;
        } else if (scrollController.offset < 160) {
          centerTitle.value = false;
        }
      });

    super.initState();
  }

  checkData() {
    if (warmUpLoader.value || trainingLoader.value || coolDownLoader.value) {
      _timer = Timer.periodic(const Duration(milliseconds: 800), (_) async {
        if (warmUpLoader.value ||
            trainingLoader.value ||
            coolDownLoader.value) {
          btnLoader.value = true;
        } else {
          btnLoader.value = false;
          _timer?.cancel();
        }
      });
    }
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

    WorkoutDetailController.getworkoutData(context, id: widget.id)
        .then((value) async {
      if (value != null &&
          context.mounted &&
          WorkoutDetailController.shouldBreakLoop == false) {
        isLoadingNotifier = false;
        workoutData = value;

        checkDataWarmUpTraining();
        setState(() {});

        addCategoryData();
        if (workoutData?.phases?[0].items?.isNotEmpty == true &&
            WorkoutDetailController.shouldBreakLoop == false) {
          await WorkoutDetailController.getWarmUpData(context,
              warmUpLoader: warmUpLoader,
              warmupData: warmUpData,
              workoutData: workoutData,
              equipmentData: equipmentIds);
        }
        if (workoutData?.goals?.isNotEmpty == true &&
            WorkoutDetailController.shouldBreakLoop == false) {
          if (context.mounted) {
            CommonController.getFilterFitnessGoalData(context,
                shouldBreakLoop: WorkoutDetailController.shouldBreakLoop,
                filterFitnessGoalData: fitnessGoalData,
                workoutData: workoutData);
          }
        }
        if (workoutData?.bodyParts?.isNotEmpty == true &&
            WorkoutDetailController.shouldBreakLoop == false) {
          bodyPartLoader.value = true;

          try {
            if (context.mounted) {
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
            }
          } on RequestException catch (e) {
            if (context.mounted) {
              BaseHelper.showSnackBar(context, e.message);
            }
          }
        }

        if (workoutData?.phases?[1].items?.isNotEmpty == true &&
            WorkoutDetailController.shouldBreakLoop == false) {
          if (context.mounted) {
            await WorkoutDetailController.getTrainingData(context,
                trainingLoader: trainingLoader,
                workoutData: workoutData,
                trainingData: trainingData,
                equipmentIds: equipmentIds);
          }
        }
        if (workoutData?.phases?[2].items?.isNotEmpty == true &&
            WorkoutDetailController.shouldBreakLoop == false) {
          if (context.mounted) {
            await WorkoutDetailController.getCoolDownData(context,
                coolDownLoader: coolDownLoader,
                workoutData: workoutData,
                coolDownData: coolDownData,
                equipmentIds: equipmentIds);
          }
        }
        CommonController.getEquipmentFilterData(
            equipmentIds: equipmentIds, filterEquipmentData: equipmentData);
        if (workoutData?.phases?[2].items?.isEmpty ?? false) {
          coolDownLoader.value = false;
        }

        if (WorkoutDetailController.shouldBreakLoop == false &&
            context.mounted) {
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

    super.dispose();
  }

  updateData() async {
    for (var i = 0; i < _box!.values.length; i++) {
      if (_box!.values.toList()[i].trainingplanId ==
          widget.followTrainingplanModel?.trainingplanId) {
        if (widget.followTrainingplanModel!.workoutCount >
            _box!.values.toList()[i].workoutCount) {
          if (_box!.values.toList()[i].outOfSequence == true) {
            _box!.values.toList()[i].outOfSequence = false;
            // element.save();
          }
          _box!.putAt(i, widget.followTrainingplanModel!);

          log(widget.followTrainingplanModel!.workoutCount.toString());
          log(_box!.values.toList()[i].workoutCount.toString());
        }
      }
    }
  }

  addCategoryData() {
    // typeLoader.value = true;
    for (var typeElement in workoutData!.types!) {
      for (var j = 0; j < CommonController.categoryTypeData.length; j++) {
        if (CommonController.categoryTypeData[j].id == typeElement) {
          categoryTypeData.add(CommonController.categoryTypeData[j]);
        }
      }
    }
    // typeLoader.value = false;
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
                                  flexibleSubtitleWidget: RichText(
                                      text: TextSpan(
                                          style: AppTypography.label16MD
                                              .copyWith(
                                                  color: AppColor
                                                      .textInvertPrimaryColor),
                                          children: [
                                        TextSpan(
                                            text:
                                                "${workoutData?.duration} ${context.loc.minText}"),
                                        value == true
                                            ? WidgetSpan(
                                                child:
                                                    BaseHelper.loadingWidget())
                                            : TextSpan(
                                                text:
                                                    " • ${categoryTypeData.map((e) => e.name).join(',')}"),
                                      ])),
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
                                    padding: const EdgeInsets.only(
                                        left: 25, bottom: 8),
                                    child: Text(
                                      context.loc.workoutOverviewText,
                                      style: AppTypography.title18LG.copyWith(
                                          color: AppColor.textEmphasisColor),
                                    ),
                                  ),
                                ),
                                if (workoutData
                                        ?.phases?.first.items?.isNotEmpty !=
                                    false) ...[
                                  phasesBodyWidget(
                                      title: context.loc.phaseTitle('warmUp'),
                                      expandNotifier: warmUpExpand,
                                      loaderNotifier: warmUpLoader,
                                      dataList: warmUpData),
                                ],
                                if (workoutData?.phases?[1].items?.isNotEmpty !=
                                    false) ...[
                                  if (workoutData
                                          ?.phases?.first.items?.isNotEmpty !=
                                      false)
                                    const SliverToBoxAdapter(
                                      child: SizedBox(
                                        height: 8,
                                      ),
                                    ),
                                  phasesBodyWidget(
                                      title: context.loc.phaseTitle("training"),
                                      expandNotifier: trainingExpand,
                                      loaderNotifier: trainingLoader,
                                      dataList: trainingData),
                                ],
                                if (workoutData?.phases?[2].items?.isNotEmpty !=
                                    false) ...[
                                  if (workoutData
                                              ?.phases?[1].items?.isNotEmpty !=
                                          false ||
                                      workoutData?.phases?.first.items
                                              ?.isNotEmpty !=
                                          false)
                                    const SliverToBoxAdapter(
                                      child: SizedBox(
                                        height: 8,
                                      ),
                                    ),
                                  phasesBodyWidget(
                                      title: context.loc.phaseTitle("coolDown"),
                                      expandNotifier: coolDownExpand,
                                      loaderNotifier: coolDownLoader,
                                      dataList: coolDownData),
                                ],
                                const SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: 8,
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                ),
      bottomNavigationBar: isLoadingNotifier == false && isNodData == false
          ? bottomWidget()
          : null,
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
                        Text("${workoutData?.duration} ${context.loc.minText}",
                            style: AppTypography.paragraph12SM
                                .copyWith(color: AppColor.textPrimaryColor))
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.followTrainingplanModel?.trainingPlanTitle}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.title14XS
                              .copyWith(color: AppColor.textEmphasisColor),
                        ),
                        4.height(),
                        Text(
                            "${context.loc.workoutText} ${widget.followTrainingplanModel?.workoutCount}/${widget.followTrainingplanModel?.totalWorkoutLength} ",
                            style: AppTypography.paragraph12SM
                                .copyWith(color: AppColor.textPrimaryColor))
                      ],
                    )),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: btnLoader,
                builder: (_, value, child) {
                  return StartButtonWidget(
                    onPressed: value == false
                        ? () async {
                            if (widget.followTrainingplanModel?.outOfSequence ==
                                true) {
                              await showAdaptiveDialog(
                                context: context,
                                builder: (context) {
                                  return ShowAlertDialogWidget(
                                    title: context.loc.alertBoxTitle,
                                    body: context.loc.alertBoxBody,
                                    btnText1: context.loc.alertBoxButton1,
                                    btnText2: context.loc.alertBoxButton2,
                                    color: AppColor.linkPrimaryColor,
                                  );
                                },
                              ).then((value) async {
                                if (value == true) {
                                  updateData();
                                  await startWorkoutSheet(context);
                                }
                              });
                            } else {
                              updateData();
                              await startWorkoutSheet(context);
                            }
                          }
                        : null,
                    btnChild: value == true
                        ? BaseHelper.loadingWidget()
                        : FittedBox(
                            child: Text(
                              context.loc.alertBoxButton2,
                              style: AppTypography.label16MD.copyWith(
                                  color: widget.followTrainingplanModel
                                              ?.outOfSequence ==
                                          true
                                      ? AppColor.buttonSecondaryColor
                                      : AppColor.textInvertEmphasis),
                            ),
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
        builder: (context) => PopScope(
              canPop: false,
              child: GetReadySheetWidget(
                equipmentData: equipmentData,
                fitnessGoalModel: fitnessGoalData,
                warmUpData: warmUpData,
                trainingData: trainingData,
                workoutModel: workoutData as WorkoutModel,
                coolDownData: coolDownData,
                followTrainingplanModel: widget.followTrainingplanModel,
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
            log("${title}");
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
        margin: const EdgeInsets.only(left: 25, right: 20, bottom: 40, top: 20),
        color: AppColor.surfaceBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 16),
          child: Column(
            children: [
              if (workoutData?.level.toString() != null)
                CustomRowTextChartIcon(
                  level: workoutData?.level.toString(),
                  text1: context.loc.levelText,
                  text2: workoutData?.level.toString(),
                  isChartIcon: true,
                ),
              ValueListenableBuilder<bool>(
                  valueListenable: coolDownLoader,
                  builder: (context, value, child) {
                    return value == true
                        ? Center(child: BaseHelper.loadingWidget())
                        : equipmentData.isEmpty
                            ? Container()
                            : Column(
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 16, bottom: 16),
                                    child: CustomDivider(),
                                  ),
                                  CustomRowTextChartIcon(
                                      text1: context.loc.equipmentText,
                                      secondWidget: SizedBox(
                                        height: 20,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: equipmentData.length,
                                          itemBuilder: (context, index) {
                                            if (index == 2) {
                                              return Row(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "+${equipmentData.length - 2}",
                                                      style: AppTypography
                                                          .label14SM
                                                          .copyWith(
                                                        color: AppColor
                                                            .textPrimaryColor,
                                                      )),
                                                  2.width(),
                                                  InkWell(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        backgroundColor: AppColor
                                                            .surfaceBackgroundBaseColor,
                                                        useSafeArea: true,
                                                        isScrollControlled:
                                                            true,
                                                        context: context,
                                                        builder: (context) =>
                                                            EquipmentExtendedSheet(
                                                                title: workoutData
                                                                        ?.title
                                                                        .toString() ??
                                                                    "",
                                                                equipmentData:
                                                                    equipmentData),
                                                      );
                                                    },
                                                    child: Transform.translate(
                                                      offset:
                                                          const Offset(0, -4),
                                                      child: const Icon(
                                                          Icons.more_horiz),
                                                    ),
                                                  )
                                                ],
                                              );
                                            }
                                            if (index == 1) {
                                              return Text(
                                                  ",${equipmentData[index].name}",
                                                  style: AppTypography.label14SM
                                                      .copyWith(
                                                    color: AppColor
                                                        .textPrimaryColor,
                                                  ));
                                            }
                                            if (index == 0) {
                                              return Text(
                                                  equipmentData[index].name,
                                                  style: AppTypography.label14SM
                                                      .copyWith(
                                                    color: AppColor
                                                        .textPrimaryColor,
                                                  ));
                                            }
                                            return Container();
                                          },
                                        ),
                                      )),
                                ],
                              );
                  }),
              if (fitnessGoalData.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: CustomDivider(),
                ),
                CustomRowTextChartIcon(
                  text1: context.loc.goalText,
                  text2: fitnessGoalData.entries.first.value,
                ),
              ],
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: CustomDivider(),
              ),
              ValueListenableBuilder(
                valueListenable: bodyPartLoader,
                builder: (_, value, child) {
                  return value == true
                      ? Center(
                          child: BaseHelper.loadingWidget(),
                        )
                      : bodyPartData == null
                          ? Container()
                          : CustomRowTextChartIcon(
                              text1: context.loc.bodyPartText,
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
