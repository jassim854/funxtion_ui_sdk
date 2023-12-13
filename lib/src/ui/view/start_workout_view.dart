import 'dart:async';
import 'dart:developer';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';

class StartWorkoutView extends StatefulWidget {
  final WorkoutModel workoutModel;
  final Map<ExerciseDetailModel, ExerciseModel> warmUpData;
  final Map<ExerciseDetailModel, ExerciseModel> trainingData;
  final Map<ExerciseDetailModel, ExerciseModel> coolDownData;

  const StartWorkoutView({
    super.key,
    required this.workoutModel,
    required this.warmUpData,
    required this.trainingData,
    required this.coolDownData,
  });

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

  ValueNotifier<int> durationNotifier = ValueNotifier(0);
  Timer? _timer;
  Timer? _mainTimer;
  Map<String, String> resistanceTargetsValue = {};
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
          await pageController.animateToPage(index + 1,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn);
          getCurrentExerciseViewFn(index + 1);

          setState(() {});
          isPlaying.value = true;
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

    _mainTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isPlaying.value) {
        durationNotifier.value += 1;
      }
    });
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

      detailOfWorkoutFn(index: index, currentBlock: widget.warmUpData);
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
          repsOrTimeText = "Time";
          timeLinearProgressNotifier.value = 0;
          repsOrTimeNotifier.value = element.value!.toInt();
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
          repsOrTimeText = "Reps";
          timeLinearProgressNotifier.value = 0;
          repsOrTimeNotifier.value = 0;
        }
      }
    } else {
      isPlaying.value = true;
      if (workoutCountDownTimer?.isActive ?? false) {
        workoutCountDownTimer?.cancel();
        if (_timer?.isActive ?? false) {
          _timer?.cancel();
        }
      }
      currentBlock.entries.toList()[index].key.mainSets;
      repsOrTimeText = "Reps";
      timeLinearProgressNotifier.value = 0;
      repsOrTimeNotifier.value =
          currentBlock.entries.toList()[index].key.mainSets?.toInt() ?? 0;
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
    }
  }

  workoutCountDownTimerFn(int index) {
    workoutCountDownTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (isPlaying.value && repsOrTimeNotifier.value > 0) {
        repsOrTimeNotifier.value -= 1;
        timeLinearProgressNotifier.value += 1;
      } else if (isPlaying.value && repsOrTimeNotifier.value == 0) {
        secondsCountDown.value = 5;
        isPlaying.value = false;
        timerFn(index);
        workoutCountDownTimer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    if (_mainTimer?.isActive == true) {
      _mainTimer?.cancel();
    }
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
  ValueNotifier<int> repsOrTimeNotifier = ValueNotifier(0);
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
        bool sholdPop = await showDialog(
          // barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Quit workout?"),
              content: Text("You will not be able to resume the workout."),
              actions: [
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    context.popPage(result: false);
                  },
                ),
                TextButton(
                  child: Text(
                    "Quit",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    context.popPage(result: true);
                  },
                ),
              ],
            );
          },
        );
        return Future.value(sholdPop);
      },
      child: Scaffold(
        backgroundColor: AppColor.surfaceBackgroundColor,
        appBar: StartWorkoutHeaderWidget(
          warmUpData: widget.warmUpData,
          coolDownData: widget.coolDownData,
          trainingData: widget.trainingData,
          sliderExercise2: sliderCoolDown,
          workoutModel: widget.workoutModel,
          durationNotifier: durationNotifier,
          sliderCoolDown: sliderCoolDown,
          sliderExercise: sliderTraining,
          sliderWarmUp: sliderWarmUp,
          actionWidget: InkWell(
              onTap: () async {
                isPlaying.value = false;
                await showModalBottomSheet(
                  backgroundColor: AppColor.surfaceBackgroundBaseColor,
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => WillPopScope(
                    onWillPop: () {
                      isPlaying.value = true;
                      return Future.value(true);
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
                    ),
                  ),
                );
              },
              child: const Icon(Icons.interests_outlined)),
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
                    Flexible(
                      flex: repsOrTimeText == "Time" && trainerNotes == ""
                          ? 3
                          : repsOrTimeText == "Time"
                              ? 2
                              : trainerNotes == ""
                                  ? 3
                                  : 4,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data?.name ?? "",
                          style: AppTypography.title24XL,
                        ),
                        8.width(),
                        InkWell(
                            onTap: () async {
                              await showModalBottomSheet(
                                useSafeArea: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => DetailWorkoutBottomSheet(
                                    exerciseModel: data as ExerciseModel),
                              );
                            },
                            child: SvgPicture.asset(
                              AppAssets.infoIcon,
                              color: AppColor.textPrimaryColor,
                            ))
                      ],
                    ),
                    if (resistanceTargetsValue.isNotEmpty)
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  color: AppColor.surfaceBackgroundColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: AppColor.borderSecondaryColor,
                                      width: 2)),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children:
                                      resistanceTargetsValue.entries.map((e) {
                                    return RichText(
                                        text: TextSpan(children: [
                                      if (e.key.contains("Range") ||
                                          resistanceTargetsValue
                                                      .entries.length >
                                                  1 &&
                                              resistanceTargetsValue.entries
                                                      .toList()[0]
                                                      .key !=
                                                  e.key)
                                        TextSpan(
                                            text: '  •  ',
                                            style: AppTypography.title24XL
                                                .copyWith(
                                                    color: AppColor
                                                        .surfaceBrandDarkColor)),
                                      TextSpan(
                                          text: e.value,
                                          style: AppTypography.title24XL
                                              .copyWith(
                                                  color: AppColor
                                                      .surfaceBrandDarkColor)),
                                      TextSpan(
                                          text: " ${e.key}",
                                          style: AppTypography.label14SM
                                              .copyWith(
                                                  color: AppColor
                                                      .textSubTitleColor))
                                    ]));
                                  }).toList()))),
                    if (trainerNotes.trim() != "")
                      Flexible(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: AnimatedSize(
                              alignment: Alignment.centerRight,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 32),
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
                                              padding =
                                                  const EdgeInsets.all(16);
                                              _border =
                                                  BorderRadius.circular(16);
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        _border = BorderRadius
                                                            .circular(20);
                                                        padding =
                                                            const EdgeInsets
                                                                .all(6);
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
                      ),
                    18.height(),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
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
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: context.dynamicWidth * 0.05,
                                        right: context.dynamicWidth * 0.05,
                                      ),
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: currentROund.toString(),
                                            style: AppTypography.title24XL
                                                .copyWith(
                                                    color: AppColor
                                                        .textEmphasisColor)),
                                        TextSpan(
                                            text: '/',
                                            style: AppTypography.title14XS
                                                .copyWith(
                                                    color: AppColor
                                                        .textSubTitleColor)),
                                        TextSpan(
                                            text: totalRounds.toString(),
                                            style: AppTypography.title24XL
                                                .copyWith(
                                                    color: AppColor
                                                        .textEmphasisColor))
                                      ])),
                                    ),
                                    Flexible(
                                      child: VerticalDivider(
                                        color: AppColor.borderSecondaryColor,
                                        thickness: 1.5,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                          left: context.dynamicWidth * 0.01,
                                          right: context.dynamicWidth * 0.01,
                                        ),
                                        child: ValueListenableBuilder<int>(
                                            valueListenable: repsOrTimeNotifier,
                                            builder: (_, value, child) {
                                              return value != 0
                                                  ? mordernDurationMSTextWidget(
                                                      clockTimer: Duration(
                                                          seconds: value))
                                                  : Text(
                                                      value.toString(),
                                                      style: AppTypography
                                                          .title60_6XL
                                                          .copyWith(
                                                              color: AppColor
                                                                  .textEmphasisColor),
                                                    );
                                            })),
                                    Flexible(
                                      child: VerticalDivider(
                                        color: AppColor.borderSecondaryColor,
                                        thickness: 1.5,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: context.dynamicWidth * 0.05,
                                        right: context.dynamicWidth * 0.05,
                                      ),
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: currentExerciseInBlock
                                                .toString(),
                                            style: AppTypography.title24XL
                                                .copyWith(
                                                    color: AppColor
                                                        .textEmphasisColor)),
                                        TextSpan(
                                            text: '/',
                                            style: AppTypography.title14XS
                                                .copyWith(
                                                    color: AppColor
                                                        .textSubTitleColor)),
                                        TextSpan(
                                            text: totalExerciseInBlock
                                                .toString(),
                                            style: AppTypography.title24XL
                                                .copyWith(
                                                    color: AppColor
                                                        .textEmphasisColor))
                                      ])),
                                    ),
                                  ],
                                )),
                            Positioned(
                              top: -8,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                    color: AppColor.surfaceBackgroundColor,
                                    border: Border.all(
                                      color: AppColor.borderSecondaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  'ROUND',
                                  style: AppTypography.label10XXSM.copyWith(
                                      color: AppColor.textPrimaryColor),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -8,
                              left: 0,
                              right: 0,
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
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
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                    color: AppColor.surfaceBackgroundColor,
                                    border: Border.all(
                                      color: AppColor.borderSecondaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  'EXERCISE',
                                  style: AppTypography.label10XXSM.copyWith(
                                      color: AppColor.textPrimaryColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    35.height(),
                    if (repsOrTimeText == "Time")
                      Flexible(
                        flex: 1,
                        child: ValueListenableBuilder<int>(
                            valueListenable: timeLinearProgressNotifier,
                            builder: (_, value1, child) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TweenAnimationBuilder(
                                  duration: const Duration(seconds: 1),
                                  tween: Tween(begin: 0.0, end: value1),
                                  builder: (_, value, child) =>
                                      LinearProgressIndicator(
                                          minHeight: 10,
                                          color: AppColor
                                              .surfaceBackgroundSecondaryColor,
                                          backgroundColor: AppColor
                                              .surfaceBackgroundSecondaryColor,
                                          valueColor: AlwaysStoppedAnimation(
                                            AppColor.linkSecondaryColor,
                                          ),
                                          value: value.toDouble() / 30),
                                ),
                              );
                            }),
                      ),
                    const Spacer()
                  ],
                );
              },
            ),
            bottomWidget(context),
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

  Align bottomWidget(
    BuildContext context,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 50,
                  child: CustomElevatedButton(
                      btnColor: AppColor.buttonTertiaryColor,
                      onPressed: () async {
                        await pageController.animateToPage(
                            pageController.page!.toInt() - 1,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeOut);
                        getCurrentExerciseViewFn(pageController.page!.toInt());
                        setState(() {});
                      },
                      child: Text('Prev',
                          style: AppTypography.label18LG
                              .copyWith(color: AppColor.buttonSecondaryColor))),
                )),
                if (repsOrTimeText == "Time") ...[
                  16.width(),
                  Expanded(
                      child: ValueListenableBuilder<bool>(
                          valueListenable: isPlaying,
                          builder: (context, value, child) {
                            return SizedBox(
                              height: 50,
                              child: CustomElevatedButton(
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
                                          size: 40,
                                        )
                                      : Icon(
                                          Icons.play_arrow_rounded,
                                          color: AppColor.buttonLabelColor,
                                          size: 40,
                                        )),
                            );
                          })),
                ],
                16.width(),
                Expanded(
                    child: SizedBox(
                  height: 50,
                  child: CustomElevatedButton(
                      onPressed: () async {
                        if (nextElementText != '') {
                          await pageController.animateToPage(
                              pageController.page!.toInt() + 1,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.easeIn);

                          getCurrentExerciseViewFn(
                              pageController.page!.toInt());
                          setState(() {});
                        } else {
                          isPlaying.value = false;
                          await showModalBottomSheet(
                            useSafeArea: true,
                            isScrollControlled: false,
                            isDismissible: false,
                            enableDrag: false,
                            context: context,
                            builder: (context) => WillPopScope(
                              onWillPop: () {
                                isPlaying.value = true;
                                return Future.value(true);
                              },
                              child: DoneWorkoutSheet(
                                type: '',
                                workoutName:
                                    widget.workoutModel.title.toString(),
                                totalDuration: durationNotifier.value,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(nextElementText == "" ? 'Done' : "Next")),
                ))
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
      ),
    );
  }

  mordernDurationHMSTextWidget({required Duration clockTimer}) {
    return Text(
      "${clockTimer.inHours.remainder(60).toString()}:${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}",
      style: AppTypography.label14SM.copyWith(color: AppColor.textPrimaryColor),
    );
  }

  Text mordernDurationMSTextWidget({required Duration clockTimer}) {
    return Text(
      "${clockTimer.inMinutes.toString().padLeft(2, '0')}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}",
      style:
          AppTypography.title60_6XL.copyWith(color: AppColor.textEmphasisColor),
    );
  }
}
