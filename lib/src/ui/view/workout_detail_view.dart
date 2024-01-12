import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:hive/hive.dart';
import 'package:ui_tool_kit/src/helper/boxes.dart';
import 'package:ui_tool_kit/src/model/follow_trainingplan_model.dart';

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
  // ValueNotifier<bool> typeLoader = ValueNotifier(true);
  List<ContentProvidersCategoryOnDemandModel> categoryTypeData = [];
  List<EquipmentModel> equipmentData = [];
  Timer? _timer;
  @override
  void initState() {
    _box = Boxes.getData();
    WorkoutDetailController.shouldBreakLoop = false;
    checkData();
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

    // if (CategoryListController.categoryTypeData.isEmpty) {
    //   CategoryListController.getCategoryTypeDataFn(
    //     context,
    //     typeLoader,
    //   );
    // }
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
              equipmentData: equipmentData);
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
          await WorkoutDetailController.getTrainingData(context,
              trainingLoader: trainingLoader,
              workoutData: workoutData,
              trainingData: trainingData,
              equipmentData: equipmentData
              // circuitTimeTrainingData: circuitTimeTrainingData,
              // rftExerciseTrainingData: rftExerciseTrainingData,
              // seExerciseTrainingData: seExerciseTrainingData,
              // ssExerciseTrainingData: ssExerciseTrainingData,
              );
        }
        if (workoutData?.phases?[2].items?.isNotEmpty == true &&
            WorkoutDetailController.shouldBreakLoop == false) {
          await WorkoutDetailController.getCoolDownData(context,
              coolDownLoader: coolDownLoader,
              workoutData: workoutData,
              coolDownData: coolDownData,
              equipmentData: equipmentData
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
                                                "${workoutData?.duration} min"),
                                        value == true
                                            ? WidgetSpan(
                                                child:
                                                    BaseHelper.loadingWidget())
                                            : TextSpan(
                                                text:
                                                    " • ${categoryTypeData.map((e) => e.name).join(',')}"),
                                        // TextSpan(
                                        //     text:
                                        //         " • ${widget.listTrainingPLanData[index].level}"),
                                      ])),
                                  // flexibleTitle2:
                                  //     "${workoutData?.duration?.getTextAfterSymbol()} min • ${workoutData!.types!.isNotEmpty ? data.map((e) => e.name).join(',') : ''}",
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
                                      'Workout Overview',
                                      style: AppTypography.title18LG.copyWith(
                                          color: AppColor.textEmphasisColor),
                                    ),
                                  ),
                                ),
                                if (workoutData
                                        ?.phases?.first.items?.isNotEmpty !=
                                    false) ...[
                                  phasesBodyWidget(
                                      title: "Warmup",
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
                                      title: "Training",
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
                                      title: "CoolDown",
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
                        Text("${workoutData?.duration} min",
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
                            "Workout ${widget.followTrainingplanModel?.workoutCount}/${widget.followTrainingplanModel?.totalWorkoutLength} ",
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
                                    title: 'Start workout out of sequence?',
                                    body:
                                        'Any incomplete workouts listed before this one will be marked as complete.',
                                    btnText1: 'Cancel',
                                    btnText2: 'Start Workout',
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
                              'Start Workout',
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
        builder: (context) => WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
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
                            secondWidget: SizedBox(
                              height: 20,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
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
                                        Text("+${equipmentData.length - 2}",
                                            style: AppTypography.label14SM
                                                .copyWith(
                                              color: AppColor.textPrimaryColor,
                                            )),
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
                                                      title: workoutData?.title
                                                              .toString() ??
                                                          "",
                                                      equipmentData:
                                                          equipmentData),
                                            );
                                          },
                                          child: Transform.translate(
                                            offset: const Offset(0, -4),
                                            child: const Icon(Icons.more_horiz),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                  if (index == 1) {
                                    return Text(",${equipmentData[index].name}",
                                        style: AppTypography.label14SM.copyWith(
                                          color: AppColor.textPrimaryColor,
                                        ));
                                  }
                                  if (index == 0) {
                                    return Text(equipmentData[index].name,
                                        style: AppTypography.label14SM.copyWith(
                                          color: AppColor.textPrimaryColor,
                                        ));
                                  }
                                  return Container();
                                },
                              ),
                            ));
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

// class OnDemandCategoryTypeWIdget extends StatefulWidget {
//   final List<int> onDemadData;
//   const OnDemandCategoryTypeWIdget({super.key, required this.onDemadData});

//   @override
//   State<OnDemandCategoryTypeWIdget> createState() =>
//       _OnDemandCategoryTypeWIdgetState();
// }

// class _OnDemandCategoryTypeWIdgetState
//     extends State<OnDemandCategoryTypeWIdget> {
//   bool isLoading = false;
//   @override
//   void initState() {
//     fetchDataFn();
//     // TODO: implement initState
//     super.initState();
//   }

//   fetchDataFn() {
//     isLoading = true;
//     setState(() {});
//     for (var i = 0; i < widget.onDemadData.length; i++) {
//       try {
//         ContentProviderCategoryOnDemandRequest.contentCategory(
//             queryParameters: {
//               "filter[where][id][in]": widget.onDemadData[i],
//             }).then((value) {
//           print(value);
//         });
//       } on RequestException catch (e) {
//         BaseHelper.showSnackBar(context, e.error);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Text('');
//   }
// }
