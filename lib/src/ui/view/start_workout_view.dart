import 'dart:async';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_tool_kit/src/ui/view/training_plan_detail_view.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';

class StartWorkoutView extends StatefulWidget {
  final WorkoutModel workoutModel;
  final Map<ExerciseDetailModel, ExerciseModel> warmUpData;
  final Map<ExerciseDetailModel, ExerciseModel> trainingData;
  final Map<ExerciseDetailModel, ExerciseModel> coolDownData;
  final FitnessGoalModel? fitnessGoalModel;
  final ValueNotifier<int> durationNotifier;
  final Timer? mainTimer;
  final List<EquipmentModel> equipmentData;
  const StartWorkoutView(
      {super.key,
      required this.workoutModel,
      required this.warmUpData,
      required this.trainingData,
      required this.coolDownData,
      this.fitnessGoalModel,
      required this.durationNotifier,
      required this.equipmentData,
      required this.mainTimer});

  @override
  State<StartWorkoutView> createState() => _StartWorkoutViewState();
}

class _StartWorkoutViewState extends State<StartWorkoutView> {
  late PageController pageController;
  ValueNotifier<double> sliderWarmUp = ValueNotifier(0);
  ValueNotifier<double> sliderTraining = ValueNotifier(0);
  ValueNotifier<double> sliderCoolDown = ValueNotifier(0);

  ExerciseModel? data;

  BorderRadiusGeometry? _border = BorderRadius.circular(20);
  EdgeInsetsGeometry? padding = const EdgeInsets.all(8);

  int pageIndex = 0;
  ValueNotifier<int> secondsCountDown = ValueNotifier(5);

  Timer? _timer;

  Map<String, String> resistanceTargetsValue = {};
  int totalTime = 0;
  // Future<ExerciseModel?> getAExercise(String id) async {
  //   ExerciseModel exerciseModel =
  //       await ExerciseRequest.exerciseById(id: id) as ExerciseModel;
  //   return exerciseModel;
  // }

  void timerFn(int index) {
    if (context.mounted) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (secondsCountDown.value > 0) {
          secondsCountDown.value -= 1;

          print(secondsCountDown);
        } else if (secondsCountDown.value == 0) {
          if (nextElementText == "Training") {
            getReadyFn(context, "Training", widget.trainingData);
          } else if (nextElementText == "Cool Down") {
            getReadyFn(context, "Cool Down", widget.coolDownData);
          } else {
            await pageController.animateToPage(index + 1,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeIn);
            getCurrentExerciseViewFn(index + 1);

            setState(() {});
            isPlaying.value = true;
          }
          _timer?.cancel();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    getCurrentExerciseViewFn(pageController.initialPage);
  }

  // Future<ExerciseModel?> futureFn(int index) async {
  //   try {
  //     if (index < widget.exerciseData.length) {
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         sliderWarmUp.value = index + 1.toDouble();

  //         sliderExercise.value = 0;
  //       });

  //       return await getAExercise(widget.workoutModel.phases?.first.items.first
  //               .seExercises?[index].exerciseId ??
  //           "");
  //     } else if (index >= widget.exerciseData.length &&
  //         index - widget.exerciseData.length <
  //             widget.exerciseWorkoutData.length) {
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         sliderExercise.value =
  //             index + 1 - widget.exerciseData.length.toDouble();
  //       });
  //       if (widget.workoutModel.phases![1].items.first.ctRounds!.isNotEmpty) {
  //         return await getAExercise(widget
  //             .workoutModel
  //             .phases![1]
  //             .items
  //             .first
  //             .ctRounds!
  //             .first
  //             .exercises[index - widget.exerciseData.length]
  //             .exerciseId);
  //       } else {
  //         return await getAExercise(widget.workoutModel.phases![1].items.first
  //             .rftExercises![index - widget.exerciseData.length].exerciseId);
  //       }
  //     }
  //   } on RequestException catch (e) {
  //     BaseHelper.showSnackBar(context, e.message);
  //   }

  //   return null;
  // }890
  getCurrentExerciseViewFn(int index) {
    if (widget.warmUpData.isNotEmpty && index < widget.warmUpData.length) {
      sliderWarmUp.value = index + 1.toDouble();
      sliderTraining.value = 0;
      sliderCoolDown.value = 0;

      detailOfWorkoutFn(
          currentPageIndex: index,
          index: index,
          currentBlock: widget.warmUpData);
      if (index == widget.warmUpData.length - 1 &&
          widget.trainingData.isNotEmpty) {
        nextElementText = 'Training';
      } else if (index == widget.warmUpData.length - 1 &&
          widget.coolDownData.isNotEmpty &&
          widget.trainingData.isEmpty) {
        nextElementText = 'Cool Down';
      } else if (index == widget.warmUpData.length - 1) {
        nextElementText = '';
      }
    } else if (widget.trainingData.isNotEmpty &&
        index - widget.warmUpData.length < widget.trainingData.length) {
      sliderWarmUp.value = widget.warmUpData.length.toDouble();
      sliderTraining.value = index - widget.warmUpData.length + 1.toDouble();
      sliderCoolDown.value = 0;

      detailOfWorkoutFn(
          currentPageIndex: index,
          index: index - widget.warmUpData.length,
          currentBlock: widget.trainingData);
      if (index - widget.warmUpData.length == widget.trainingData.length - 1 &&
          widget.coolDownData.isNotEmpty) {
        nextElementText = 'Cool Down';
      } else if (index - widget.warmUpData.length ==
          widget.trainingData.length - 1) {
        nextElementText = '';
      }
    } else if (widget.coolDownData.isNotEmpty &&
        index - widget.trainingData.length - widget.warmUpData.length <
            widget.coolDownData.length) {
      sliderWarmUp.value = widget.warmUpData.length.toDouble();
      sliderTraining.value = widget.trainingData.length.toDouble();

      sliderCoolDown.value = index -
          widget.warmUpData.length -
          widget.trainingData.length +
          1.toDouble();
      detailOfWorkoutFn(
          currentPageIndex: index,
          index: index - widget.warmUpData.length - widget.trainingData.length,
          currentBlock: widget.coolDownData);
      if (index - widget.warmUpData.length - widget.trainingData.length ==
          widget.coolDownData.length - 1) {
        nextElementText = '';
      }
    }
  }

  detailOfWorkoutFn(
      {required int index,
      required currentPageIndex,
      required Map<ExerciseDetailModel, ExerciseModel> currentBlock}) {
    data = currentBlock.entries.toList()[index].value;

    currentExerciseInBlock = index + 1;
    totalExerciseInBlock = currentBlock.length;
    title = currentBlock.currentHeaderTitle(index);
    infoHeader = currentBlock.infoHeader(index);
    trainerNotes = currentBlock.entries.toList()[index].key.exerciseNotes ?? "";
    if (currentBlock.entries.toList()[index].key.exerciseCategoryName ==
        ItemType.singleExercise) {
      totalRounds = currentBlock.entries.toList()[index].key.setsCount!.toInt();
    } else if (currentBlock.entries.toList()[index].key.exerciseCategoryName ==
        ItemType.circuitTime) {
      totalRounds =
          currentBlock.entries.toList()[index].key.setsCount!.toInt() + 1;
    } else if (currentBlock.entries.toList()[index].key.exerciseCategoryName ==
        ItemType.rft) {
      totalRounds = currentBlock.entries.toList()[index].key.rftRounds!.toInt();
    }

    if (index < currentBlock.length - 1) {
      nextElementText = currentBlock.values.toList()[index + 1].name;
    }
    if (currentBlock.entries.toList()[index].key.goalTargets?.isNotEmpty ??
        false) {
      for (var element
          in currentBlock.entries.toList()[index].key.goalTargets!) {
        if (element.metric == Metric.duration) {
          repsOrTimeText = "TIME";
          totalTime = element.value!.toInt();
          timeLinearProgressNotifier.value = 0;
          timeNotifier.value = element.value!.toInt();
          if (workoutCountDownTimer?.isActive ?? false) {
            workoutCountDownTimer?.cancel();
            if (_timer?.isActive ?? false) {
              _timer?.cancel();
            }
          }
          workoutCountDownTimerFn(index);
        } else {
          isPlaying.value = true;
          if (workoutCountDownTimer?.isActive ?? false) {
            workoutCountDownTimer?.cancel();
            if (_timer?.isActive ?? false) {
              _timer?.cancel();
            }
          }
          repsOrTimeText = "REPS";
          totalTime = 0;
          timeLinearProgressNotifier.value = 0;
          timeNotifier.value = 0;
          reps = element.value?.toInt() ?? 0;
        }
      }
    } else if (currentBlock.entries.toList()[index].key.exerciseCategoryName ==
        ItemType.circuitTime) {
      isPlaying.value = true;

      if (workoutCountDownTimer?.isActive ?? false) {
        workoutCountDownTimer?.cancel();
        if (_timer?.isActive ?? false) {
          _timer?.cancel();
        }
      }

      repsOrTimeText = "TIME";
      totalTime = currentBlock.entries.toList()[index].key.mainWork!.toInt();
      timeLinearProgressNotifier.value = 0;
      timeNotifier.value =
          currentBlock.entries.toList()[index].key.mainWork!.toInt();
      if (workoutCountDownTimer?.isActive ?? false) {
        workoutCountDownTimer?.cancel();
        if (_timer?.isActive ?? false) {
          _timer?.cancel();
        }
      }
      workoutCountDownTimerFn(currentPageIndex);
      reps = 0;
    } else {
      isPlaying.value = true;
      if (workoutCountDownTimer?.isActive ?? false) {
        workoutCountDownTimer?.cancel();
        if (_timer?.isActive ?? false) {
          _timer?.cancel();
        }
      }
      currentBlock.entries.toList()[index].key.mainSets;
      repsOrTimeText = "REPS";
      totalTime = 0;
      timeLinearProgressNotifier.value = 0;
      timeNotifier.value = 0;
      reps = 0;
    }
    if (currentBlock.entries
            .toList()[index]
            .key
            .resistanceTargets
            ?.isNotEmpty ??
        false) {
      // resistanceTargetsValue =
      //     currentBlock.entries.toList()[index].key.resistanceTargets;
      resistanceTargetsValue =
          currentBlock.entries.toList()[index].key.getResistanceTarget();
    } else {
      resistanceTargetsValue = {};
    }
  }

  workoutCountDownTimerFn(int index) {
    workoutCountDownTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (isPlaying.value && timeNotifier.value > 0) {
        timeNotifier.value -= 1;
        timeLinearProgressNotifier.value += 1;
      } else if (isPlaying.value && timeNotifier.value == 0) {
        secondsCountDown.value = 5;
        isPlaying.value = false;
        timerFn(index);
        workoutCountDownTimer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    if (workoutCountDownTimer?.isActive == true) {
      workoutCountDownTimer?.cancel();
    }
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }

    // TODO: implement dispose
    super.dispose();
  }

  //   getRound(int phaseIndex, int exerciseIndex) {
  //   // totalRounds = widget.workoutModel.phases?[phaseIndex].items!.first
  //   //         .seExercises?[exerciseIndex].sets!.length
  //   //         .toInt() ??
  //   //     0;

  //   title =
  //       widget.workoutModel.phases?[phaseIndex].items!.first.type.toString() ??
  //           '';
  //   if (exerciseIndex < widget.warmUpData.length - 1) {
  //     nextElementText =
  //         widget.warmUpData.values.toList()[exerciseIndex + 1].name;
  //   } else {
  //     if (widget.trainingData.isNotEmpty) {
  //       nextElementText = widget
  //               .workoutModel.phases?[phaseIndex + 1].items!.first.type
  //               .toString() ??
  //           '';
  //     } else {
  //       nextElementText = widget
  //               .workoutModel.phases?[phaseIndex + 1].items!.first.type
  //               .toString() ??
  //           '';
  //     }
  //   }
  //   // totalExerciseInRound=widget.workoutModel.phases?[phaseIndex].items.first
  //   //     .seExercises?[exerciseIndex]..length
  //   //     .toInt() ??
  //   // 0;
  // }

  String nextElementText = '';
  String repsOrTimeText = '';
  String trainerNotes = '';
  int totalExerciseInBlock = 1;
  int currentExerciseInBlock = 1;
  String title = '';
  String infoHeader = '';
  double _height = 40;
  double _width = 40;
  ValueNotifier<int> timeNotifier = ValueNotifier(0);
  int reps = 0;
  ValueNotifier<int> timeLinearProgressNotifier = ValueNotifier(0);
  Timer? workoutCountDownTimer;
  ValueNotifier<bool> isPlaying = ValueNotifier(true);
  int totalRounds = 1;
  int currentROund = 1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // isPlaying.value = false;
        bool sholdPop = await showAdaptiveDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const ShowAlertDialogWidget(
                title: "Quit workout?",
                body: "You will not be able to resume the workout.",
                btnText1: "Cancel",
                btnText2: "Quit");
          },
        );
        if (sholdPop == true) {
          if (widget.warmUpData.isEmpty &&
              widget.trainingData.isNotEmpty &&
              widget.coolDownData.isEmpty) {
            context.multiPopPage(popPageCount: 2);
          } else if (widget.warmUpData.isNotEmpty &&
              widget.trainingData.isEmpty &&
              widget.coolDownData.isEmpty) {
            context.multiPopPage(popPageCount: 2);
          } else {
            context.multiPopPage(popPageCount: 3);
          }
        }
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColor.surfaceBackgroundColor,
        appBar: StartWorkoutHeaderWidget(
          mainTimer: widget.mainTimer,
          warmUpData: widget.warmUpData,
          coolDownData: widget.coolDownData,
          trainingData: widget.trainingData,
          workoutModel: widget.workoutModel,
          sliderCoolDown: sliderCoolDown,
          sliderTraining: sliderTraining,
          sliderWarmUp: sliderWarmUp,
          actionWidget: InkWell(
              onTap: () async {
                isPlaying.value = false;
                await showModalBottomSheet(
                  backgroundColor: AppColor.surfaceBackgroundBaseColor,
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => PopScope(
                    onPopInvoked: (didPop) {
                      isPlaying.value = true;
                    },
                    child: OverviewBottomSheet(
                      warmUpData: widget.warmUpData,
                      coolDownData: widget.coolDownData,
                      trainingData: widget.trainingData,
                      workoutModel: widget.workoutModel,
                      warmupBody: pageIndex,
                      trainingBody: pageIndex - widget.warmUpData.length,
                      coolDownBody: pageIndex -
                          widget.trainingData.length -
                          widget.warmUpData.length,
                      goHereTapCoolDown: (index) async {
                        context.maybePopPage();
                        await pageController.animateToPage(
                            index +
                                widget.warmUpData.length +
                                widget.trainingData.length,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeIn);

                        getCurrentExerciseViewFn(pageController.page!.toInt());
                        setState(() {});
                      },
                      goHereTapTraining: (index) async {
                        if (workoutCountDownTimer?.isActive ?? false) {
                          workoutCountDownTimer?.cancel();
                        }
                        context.maybePopPage();
                        await pageController.animateToPage(
                            index + widget.warmUpData.length,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeIn);

                        getCurrentExerciseViewFn(pageController.page!.toInt());
                        setState(() {});
                      },
                      goHereTapWarmUp: (index) async {
                        context.maybePopPage();
                        await pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeIn);

                        getCurrentExerciseViewFn(pageController.page!.toInt());
                        setState(() {});
                      },
                      warmupHeader: widget.warmUpData.isNotEmpty,
                      coolDownHeader: false,
                      trainingHeaer: widget.warmUpData.isEmpty ? true : false,
                      warmUpWorkoutComplete: false,
                      trainingWorkoutComplete: false,
                      coolDownWorkoutComplete: false,
                    ),
                  ),
                );
              },
              child: SvgPicture.asset(AppAssets.exploreIcon)),
          durationNotifier: widget.durationNotifier,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              itemCount: widget.warmUpData.length +
                  widget.trainingData.length +
                  widget.coolDownData.length,
              itemBuilder: (context, index) {
                pageIndex = index;
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    8.height(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title,
                            style: AppTypography.title14XS.copyWith(
                              color: AppColor.textPrimaryColor,
                            )),
                        4.width(),
                        InkWell(
                            onTap: () async {
                              await showModalBottomSheet(
                                backgroundColor:
                                    AppColor.surfaceBackgroundColor,
                                useSafeArea: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => HeaderExerciseInfoSheet(
                                  title: title,
                                  infoHeader: infoHeader,
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              AppAssets.infoIcon,
                              color: AppColor.textPrimaryColor,
                            ))
                      ],
                    ),
                    Expanded(
                      // flex: 4,
                      child: ValueListenableBuilder<bool>(
                          valueListenable: isPlaying,
                          builder: (context, value, child) {
                            return Container(
                                foregroundDecoration: value == false
                                    ? const BoxDecoration(
                                        color: Colors.grey,
                                        backgroundBlendMode:
                                            BlendMode.saturation,
                                      )
                                    : null,
                                margin: const EdgeInsets.only(
                                    left: 45, right: 45, top: 8, bottom: 16),
                                child: cacheNetworkWidget(
                                    imageUrl: value == true
                                        ? data?.mapGif?.url ?? ''
                                        : data?.mapImage?.url ?? ''));
                          }),
                    ),
                    Padding(
                      padding: resistanceTargetsValue.isEmpty &&
                              trainerNotes.trim() == ""
                          ? const EdgeInsets.only(bottom: 140)
                          : resistanceTargetsValue.isEmpty &&
                                  trainerNotes.trim() != ""
                              ? const EdgeInsets.only(bottom: 87)
                              : EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data?.name ?? "",
                            style: AppTypography.title24XL
                                .copyWith(color: AppColor.textEmphasisColor),
                          ),
                          8.width(),
                          InkWell(
                              onTap: () async {
                                await showModalBottomSheet(
                                  backgroundColor:
                                      AppColor.surfaceBackgroundColor,
                                  useSafeArea: true,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) =>
                                      DetailWorkoutBottomSheet(
                                          exerciseModel: data as ExerciseModel),
                                );
                              },
                              child: SvgPicture.asset(
                                AppAssets.infoIcon,
                                color: AppColor.textEmphasisColor,
                              ))
                        ],
                      ),
                    ),

                    if (resistanceTargetsValue.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8,
                            bottom: trainerNotes.trim() != "" ? 0 : 100),
                        child: Wrap(
                          children: resistanceTargetsValue.entries
                              .map((e) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: AppColor.surfaceBackgroundColor,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: AppColor.borderSecondaryColor,
                                          width: 2)),
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: e.value,
                                        style: AppTypography.title24XL.copyWith(
                                            color: AppColor.textEmphasisColor)),
                                    TextSpan(
                                        text: " ${e.key}",
                                        style: AppTypography.label14SM.copyWith(
                                            color: AppColor.textSubTitleColor))
                                  ]))))
                              .toList(),
                        ),
                      ),

                    if (trainerNotes.trim() != "")
                      Container(
                          margin: EdgeInsets.only(
                              top: resistanceTargetsValue.isNotEmpty ? 18 : 0,
                              bottom: 24),
                          alignment: Alignment.centerRight,
                          child: AnimatedSize(
                            alignment: Alignment.centerRight,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                            child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                padding: padding,
                                height: _height,
                                width: _width,
                                decoration: BoxDecoration(
                                  color: AppColor.buttonTertiaryColor,
                                  borderRadius: _border,
                                ),
                                child: _width == 40
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            _width = context.dynamicWidth;
                                            padding = const EdgeInsets.all(16);
                                            _border = BorderRadius.circular(16);
                                            _height = 80;
                                          });
                                        },
                                        child: SvgPicture.asset(
                                            AppAssets.personNotesIcon))
                                    : Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Trainer notes',
                                                style: AppTypography.title14XS
                                                    .copyWith(
                                                        color: AppColor
                                                            .textPrimaryColor),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _height = 40;
                                                      _width = 40;
                                                      _border =
                                                          BorderRadius.circular(
                                                              20);
                                                      padding =
                                                          const EdgeInsets.all(
                                                              6);
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    color: AppColor
                                                        .textPrimaryColor,
                                                  ))
                                            ],
                                          ),
                                          Text(
                                            trainerNotes,
                                            style: AppTypography.paragraph14MD
                                                .copyWith(
                                                    color: AppColor
                                                        .textPrimaryColor),
                                          )
                                        ],
                                      )),
                          )),
                    // const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 12),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 1.5,
                                      color: AppColor.borderSecondaryColor)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        // left: 8, right: 8
                                        ),
                                    width: 70,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          currentROund.toString(),
                                          style: AppTypography.title24XL
                                              .copyWith(
                                                  color: AppColor
                                                      .textEmphasisColor),
                                        ),
                                        1.width(),
                                        Text(
                                          '/',
                                          style: AppTypography.title18LG
                                              .copyWith(
                                                  color: AppColor
                                                      .textSubTitleColor),
                                        ),
                                        1.width(),
                                        Text(
                                          totalRounds.toString(),
                                          style: AppTypography.title24XL
                                              .copyWith(
                                                  color: AppColor
                                                      .textEmphasisColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 100,
                                    child: VerticalDivider(
                                      color: AppColor.borderSecondaryColor,
                                      thickness: 1.5,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: ValueListenableBuilder<bool>(
                                          valueListenable: isPlaying,
                                          builder: (_, isPlayvalue, child) {
                                            return ValueListenableBuilder<int>(
                                                valueListenable: timeNotifier,
                                                builder: (_, value, child) {
                                                  return value != 0
                                                      ? mordernDurationMSTextWidget(
                                                          clockTimer: Duration(
                                                              seconds: value),
                                                          color: isPlayvalue
                                                              ? AppColor
                                                                  .textEmphasisColor
                                                              : AppColor
                                                                  .textPrimaryColor)
                                                      : Text(
                                                          reps.toString(),
                                                          style: AppTypography
                                                              .title60_6XL
                                                              .copyWith(
                                                                  color: AppColor
                                                                      .textEmphasisColor),
                                                        );
                                                });
                                          })),
                                  SizedBox(
                                    height: 100,
                                    child: VerticalDivider(
                                      color: AppColor.borderSecondaryColor,
                                      thickness: 1.5,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        // left: 12, right: 16
                                        ),
                                    width: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(currentExerciseInBlock.toString(),
                                            style: AppTypography.title24XL
                                                .copyWith(
                                                    color: AppColor
                                                        .textEmphasisColor)),
                                        1.width(),
                                        Text('/',
                                            style: AppTypography.title18LG
                                                .copyWith(
                                                    color: AppColor
                                                        .textSubTitleColor)),
                                        1.width(),
                                        Text(totalExerciseInBlock.toString(),
                                            style: AppTypography.title24XL
                                                .copyWith(
                                              color: AppColor.textEmphasisColor,
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          Positioned(
                            top: -8,
                            left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                  color: AppColor.surfaceBackgroundColor,
                                  border: Border.all(
                                    color: AppColor.borderSecondaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                'ROUND',
                                style: AppTypography.label10XXSM
                                    .copyWith(color: AppColor.textPrimaryColor),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -8,
                            left: 12,
                            right: 12,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                    color: AppColor.surfaceBackgroundColor,
                                    border: Border.all(
                                      color: AppColor.borderSecondaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  repsOrTimeText,
                                  style: AppTypography.label10XXSM.copyWith(
                                      color: AppColor.textPrimaryColor),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -8,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                  color: AppColor.surfaceBackgroundColor,
                                  border: Border.all(
                                    color: AppColor.borderSecondaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                'EXERCISE',
                                style: AppTypography.label10XXSM
                                    .copyWith(color: AppColor.textPrimaryColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (repsOrTimeText.toLowerCase().contains("time"))
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        child: ValueListenableBuilder<int>(
                            valueListenable: timeLinearProgressNotifier,
                            builder: (_, value1, child) {
                              return TweenAnimationBuilder(
                                duration: const Duration(seconds: 1),
                                tween: Tween(begin: 0.0, end: value1),
                                builder: (_, value, child) =>
                                    CustomSLiderWidget(
                                  backgroundColor:
                                      AppColor.surfaceBackgroundSecondaryColor,
                                  valueColor: AppColor.linkSecondaryColor,
                                  sliderValue: value.toDouble(),
                                  division: totalTime,
                                ),
                              );
                            }),
                      ),
                    bottomWidget(context),
                  ],
                );
              },
            ),
            ValueListenableBuilder<bool>(
                valueListenable: isPlaying,
                builder: (context, value, child) {
                  return value == false && _timer?.isActive == true
                      ? ValueListenableBuilder(
                          valueListenable: secondsCountDown,
                          builder: (context, value, child) {
                            return value > 0
                                ? Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 4.0, sigmaY: 4.0),
                                        child: ModalBarrier(
                                            dismissible: false,
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                      ),
                                      Column(
                                        children: [
                                          20.height(),
                                          Text(
                                            'Get Ready!',
                                            style: AppTypography.title40_4XL
                                                .copyWith(
                                                    color: AppColor
                                                        .textInvertEmphasis),
                                          ),
                                          SizedBox(
                                            height: context.dynamicHeight * 0.1,
                                          ),
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              SizedBox(
                                                height: 150,
                                                width: 150,
                                                child: TweenAnimationBuilder(
                                                  duration: const Duration(
                                                      seconds: 5),
                                                  tween:
                                                      Tween(begin: 0.0, end: 1),
                                                  builder: (_, value, child) =>
                                                      CircularProgressIndicator(
                                                          backgroundColor: AppColor
                                                              .surfaceBackgroundSecondaryColor,
                                                          valueColor:
                                                              AlwaysStoppedAnimation(
                                                            AppColor
                                                                .surfaceBrandDarkColor,
                                                          ),
                                                          strokeWidth: 8,
                                                          value:
                                                              value.toDouble()),
                                                ),
                                              ),
                                              Text(
                                                value.toString(),
                                                style: AppTypography.title40_4XL
                                                    .copyWith(
                                                        color: AppColor
                                                            .surfaceBackgroundSecondaryColor),
                                              )
                                            ],
                                          ),
                                          40.height(),
                                          Text(
                                            "Get ready for",
                                            style: AppTypography.title14XS
                                                .copyWith(
                                                    color: AppColor
                                                        .textInvertSubtitle),
                                          ),
                                          10.height(),
                                          Text(
                                            nextElementText,
                                            style: AppTypography.title24XL
                                                .copyWith(
                                                    color: AppColor
                                                        .textInvertEmphasis),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Container();
                          })
                      : Container();
                }),
          ],
        ),
      ),
    );
  }

  bottomWidget(
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 20,
          top: repsOrTimeText.toLowerCase().contains("time") ? 10 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CustomElevatedButton(
                      radius: 16,
                      btnColor: AppColor.buttonTertiaryColor,
                      onPressed: () async {
                        await pageController.animateToPage(
                            pageController.page!.toInt() - 1,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeOut);
                        getCurrentExerciseViewFn(pageController.page!.toInt());
                        setState(() {});
                      },
                      childPadding: EdgeInsets.symmetric(
                          horizontal: context.dynamicWidth * 0.03,
                          vertical: 16),
                      child: Text('Prev',
                          style: AppTypography.label16MD
                              .copyWith(color: AppColor.buttonSecondaryColor))),
                ),
              ),
              if (repsOrTimeText.toLowerCase().contains("time")) ...[
                8.width(),
                Expanded(
                  flex: 2,
                  child: ValueListenableBuilder<bool>(
                      valueListenable: isPlaying,
                      builder: (_, value, child) {
                        return CustomElevatedButton(
                          childPadding: const EdgeInsets.only(
                              // right: context.dynamicWidth * 0.034,
                              // left: context.dynamicWidth * 0.03,
                              top: 12,
                              bottom: 12),
                          btnColor: value == true
                              ? AppColor.buttonTertiaryColor
                              : null,
                          onPressed: () {
                            isPlaying.value = !isPlaying.value;
                          },
                          child: value == true
                              ? Icon(
                                  Icons.pause,
                                  color: AppColor.buttonSecondaryColor,
                                  size: 32,
                                )
                              : Icon(
                                  Icons.play_arrow_rounded,
                                  color: AppColor.buttonLabelColor,
                                  size: 32,
                                ),
                        );
                      }),
                ),
                8.width(),
              ],
              // 16.width(),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: CustomElevatedButton(
                      radius: 16,
                      childPadding: EdgeInsets.symmetric(
                          horizontal: context.dynamicWidth * 0.03,
                          vertical: 16),
                      onPressed: () async {
                        if (nextElementText != '') {
                          if (nextElementText == "Training") {
                            await getReadyFn(
                                context, "Training", widget.trainingData);
                          } else if (nextElementText == "Cool Down") {
                            await getReadyFn(
                                context, "Cool Dwon", widget.coolDownData);
                          } else {
                            await pageController.animateToPage(
                                pageController.page!.toInt() + 1,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeIn);

                            getCurrentExerciseViewFn(
                                pageController.page!.toInt());
                            setState(() {});
                          }
                        } else {
                          isPlaying.value = false;
                          await showModalBottomSheet(
                            useSafeArea: true,
                            isScrollControlled: true,
                            isDismissible: false,
                            enableDrag: false,
                            context: context,
                            builder: (context) => WillPopScope(
                              onWillPop: () {
                                isPlaying.value = true;
                                return Future.value(true);
                              },
                              child: DoneWorkoutSheet(
                                type:
                                    widget.fitnessGoalModel?.name.toString() ??
                                        "",
                                workoutName:
                                    widget.workoutModel.title.toString(),
                                totalDuration: widget.durationNotifier.value,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        nextElementText == "" ? 'Done' : "Next",
                        style: AppTypography.label16MD
                            .copyWith(color: AppColor.textInvertEmphasis),
                      )),
                ),
              )
            ],
          ),
          if (nextElementText != '')
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Up next: $nextElementText',
                style: AppTypography.label12XSM
                    .copyWith(color: AppColor.textPrimaryColor),
              ),
            )
        ],
      ),
    );
  }

  Future<void> getReadyFn(BuildContext context, String title,
      Map<ExerciseDetailModel, ExerciseModel> currentListData) async {
    isPlaying.value = false;
    await showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return PopScope(
          onPopInvoked: (didPop) {
            if (isPlaying.value == false) {
              isPlaying.value = true;
            }
          },
          child: UpNextSheetWidget(
            isFromNext: true,
            workoutModel: widget.workoutModel,
            warmUpData: widget.warmUpData,
            trainingData: widget.trainingData,
            coolDownData: widget.coolDownData,
            equipmentData: widget.equipmentData,
            durationNotifier: widget.durationNotifier,
            fitnessGoalModel: widget.fitnessGoalModel,
            title: title,
            currentListData: currentListData,
            sliderWarmUp: sliderWarmUp,
            sliderTraining: sliderTraining,
            sliderCoolDown: sliderCoolDown,
            mainTimer: widget.mainTimer,
          ),
        );
      },
    ).then((value) async {
      if (value == false) {
        await pageController.animateToPage(0,
            duration: const Duration(milliseconds: 100), curve: Curves.easeIn);

        getCurrentExerciseViewFn(0);
        setState(() {});
      } else if (value == true) {
        await pageController.animateToPage(pageController.page!.toInt() + 1,
            duration: const Duration(milliseconds: 100), curve: Curves.easeIn);

        getCurrentExerciseViewFn(pageController.page!.toInt());
        setState(() {});
      }
    });
  }

  // mordernDurationHMSTextWidget({required Duration clockTimer}) {
  //   return Text(
  //     "${clockTimer.inHours.remainder(60).toString()}:${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}",
  //     style: AppTypography.label14SM.copyWith(color: AppColor.textPrimaryColor),
  //   );
  // }

  Text mordernDurationMSTextWidget(
      {required Duration clockTimer, Color? color}) {
    return Text(
      "${clockTimer.inMinutes.toString().padLeft(2, '0')}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}",
      style: AppTypography.title60_6XL
          .copyWith(color: color ?? AppColor.textEmphasisColor),
    );
  }
}
