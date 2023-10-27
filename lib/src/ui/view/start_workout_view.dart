import 'dart:async';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/src/widgets/detail_exercise_bottom_sheet_widget.dart';
import 'package:ui_tool_kit/src/widgets/start_workout_header_widget.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class StartWorkoutView extends StatefulWidget {
  final WorkoutModel workoutModel;
  final List<ExerciseModel> exerciseData;
  final List<ExerciseModel> exerciseWorkoutData;
  final List<ExerciseModel> exerciseWorkoutData2;

  const StartWorkoutView({
    super.key,
    required this.workoutModel,
    required this.exerciseData,
    required this.exerciseWorkoutData,
    required this.exerciseWorkoutData2,
  });

  @override
  State<StartWorkoutView> createState() => _StartWorkoutViewState();
}

class _StartWorkoutViewState extends State<StartWorkoutView> {
  late PageController pageController;
  ValueNotifier<double> sliderWarmUp = ValueNotifier(0);
  ValueNotifier<double> sliderExercise = ValueNotifier(0);
  ValueNotifier<double> sliderExercise2 = ValueNotifier(0);
  ValueNotifier<double> sliderCoolDown = ValueNotifier(0);
  ExerciseModel? data;

  BorderRadiusGeometry? _border = BorderRadius.circular(20);
  EdgeInsetsGeometry? padding = const EdgeInsets.all(8);

  int pageIndex = 0;
  ValueNotifier<int> secondsCountDown = ValueNotifier(5);

  ValueNotifier<int> durationNotifier = ValueNotifier(0);
  Timer? _timer;
  Timer? _timer2;
  // Future<ExerciseModel?> getAExercise(String id) async {
  //   ExerciseModel exerciseModel =
  //       await ExerciseRequest.exerciseById(id: id) as ExerciseModel;
  //   return exerciseModel;
  // }

  void timerFn(int index) {
    if (context.mounted) {
      isPlaying.value = false;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (secondsCountDown.value > 0) {
          secondsCountDown.value -= 1;

          print(secondsCountDown);
        } else if (secondsCountDown.value == 0) {
          isPlaying.value = true;
          getCurrentExercise(index + 1);
          await pageController.animateToPage(index + 1,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn);

          setState(() {});
          _timer?.cancel();
        }
      });
    }
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    getCurrentExercise(pageController.initialPage);

    _timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isPlaying.value) {
        durationNotifier.value += 1;
      }
    });

    // TODO: implement initState
    super.initState();
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
  getCurrentExercise(int index) {
    if (widget.exerciseData.isNotEmpty && index < widget.exerciseData.length) {
      sliderWarmUp.value = index + 1.toDouble();
      sliderExercise.value = 0;
      sliderExercise2.value = 0;
      data = widget.exerciseData[index];

      getRound(0, index);
      workoutCountDownTimerFn(index);
    } else if (widget.exerciseWorkoutData.isNotEmpty &&
        index < widget.exerciseWorkoutData.length) {
      sliderExercise.value = index - widget.exerciseData.length + 1.toDouble();
      sliderExercise2.value = 0;
      data = widget.exerciseWorkoutData[index - widget.exerciseData.length];
      getRoundExerciseWorkout(1, index - widget.exerciseData.length);
    } else if (widget.exerciseWorkoutData2.isNotEmpty &&
        index < widget.exerciseWorkoutData2.length) {
      sliderExercise2.value =
          index - widget.exerciseWorkoutData2.length + 1.toDouble();
      data = widget
          .exerciseWorkoutData2[index - widget.exerciseWorkoutData2.length];
      getRoundExerciseWorkout2(2, index - widget.exerciseWorkoutData2.length);
    }
  }

  @override
  void dispose() {
    if (_timer2?.isActive == true) {
      _timer2?.cancel();
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

  getRound(int phaseIndex, int exerciseIndex) {
    totalRounds = widget.workoutModel.phases?[phaseIndex].items.first
            .seExercises?[exerciseIndex].sets.length
            .toInt() ??
        0;
    title = widget.workoutModel.phases?[phaseIndex].title.toString() ?? '';
    // totalExerciseInRound=widget.workoutModel.phases?[phaseIndex].items.first
    //     .seExercises?[exerciseIndex]..length
    //     .toInt() ??
    // 0;
  }

  getRoundExerciseWorkout(int phaseIndex, int exerciseIndex) {
    totalRounds = 1;

    title = widget.workoutModel.phases?[phaseIndex].title.toString() ?? '';
    // totalExerciseInRound=widget.workoutModel.phases?[phaseIndex].items.first
    //     .seExercises?[exerciseIndex]..length
    //     .toInt() ??
    // 0;
  }

  getRoundExerciseWorkout2(int phaseIndex, int exerciseIndex) {
    totalRounds = 1;

    title = widget.workoutModel.phases?[phaseIndex].title.toString() ?? '';
    // totalExerciseInRound=widget.workoutModel.phases?[phaseIndex].items.first
    //     .seExercises?[exerciseIndex]..length
    //     .toInt() ??
    // 0;
  }

  workoutCountDownTimerFn(int index) {
    workoutCountDown.value = widget.workoutModel.phases?[0].items.first
            .seExercises?[index].sets[currentROund].goalTargets.first.value
            .toInt() ??
        0;
    secondsCountDown.value = 5;
    workoutCountDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isPlaying.value && workoutCountDown.value > 0) {
        workoutCountDown.value -= 1;
      } else if (workoutCountDown.value == 0) {
        timerFn(index);
        workoutCountDownTimer?.cancel();
      } else if (index > widget.exerciseData.length) {
        workoutCountDownTimer?.cancel();
      }
    });
  }

  String title = '';
  double _height = 40;
  double _width = 40;
  ValueNotifier<int> workoutCountDown = ValueNotifier(0);
  Timer? workoutCountDownTimer;
  ValueNotifier<bool> isPlaying = ValueNotifier(true);
  int totalRounds = 1;
  int currentROund = 1;
  int totalExerciseInRound = 1;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColor.surfaceBackgroundColor,
        appBar: StartWorkoutHeaderWidget(
          exerciseData: widget.exerciseData,
          exerciseWorkoutData2: widget.exerciseWorkoutData2,
          exerciseWorkoutData: widget.exerciseWorkoutData,
          sliderExercise2: sliderExercise2,
          workoutModel: widget.workoutModel,
          durationNotifier: durationNotifier,
          warmupBody: pageIndex,
          workoutCircuitBody: pageIndex,
          workoutRepsBody: pageIndex,
          sliderCoolDown: sliderCoolDown,
          sliderExercise: sliderExercise,
          sliderWarmUp: sliderWarmUp,
          goHereTap: (index) async {
            context.popPage();
            await pageController.animateToPage(index,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeIn);

            getCurrentExercise(pageController.page!.toInt());
            setState(() {});
          },
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              itemCount: widget.exerciseData.length +
                  widget.exerciseWorkoutData.length +
                  widget.exerciseWorkoutData2.length,
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
                        SvgPicture.asset(
                          AppAssets.infoIcon,
                          color: AppColor.textPrimaryColor,
                        )
                      ],
                    ),
                    ValueListenableBuilder<bool>(
                        valueListenable: isPlaying,
                        builder: (context, value, child) {
                          return Container(
                              foregroundDecoration: value == false
                                  ? const BoxDecoration(
                                      color: Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    )
                                  : null,
                              margin: const EdgeInsets.only(
                                  left: 45, right: 45, top: 8, bottom: 16),
                              child: cacheNetworkWidget(
                                  imageUrl: value == true
                                      ? data?.mapGif?.url ?? ''
                                      : data?.mapImage?.url ?? ''));
                        }),
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
                    8.height(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColor.surfaceBackgroundColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColor.borderSecondaryColor, width: 2)),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: '60',
                            style: AppTypography.title24XL
                                .copyWith(color: AppColor.textEmphasisColor)),
                        TextSpan(
                            text: '  kg',
                            style: AppTypography.label14SM
                                .copyWith(color: AppColor.textSubTitleColor)),
                      ])),
                    ),
                    // if (index < widget.exerciseData.length)
                    //   Padding(
                    //     padding: EdgeInsets.symmetric(
                    //         vertical: context.dynamicHeight * 0.03),
                    //     child: Column(
                    //       children: [
                    //         const Text('seconds'),
                    //         Text(
                    //           'seconds',
                    //           style: AppTypography.title28_2XL,
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // if (index >= widget.exerciseData.length)
                    //   Padding(
                    //     padding: EdgeInsets.symmetric(
                    //         vertical: context.dynamicHeight * 0.03,
                    //         horizontal: 16),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.end,
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Column(
                    //           children: [
                    //             Text(
                    //               'Set',
                    //               style: AppTypography.label12XSM,
                    //             ),
                    //             Text(
                    //               "1/2",
                    //               style: AppTypography.title24XL,
                    //             )
                    //           ],
                    //         ),
                    //         // 50.width(),
                    //         Column(
                    //           children: [
                    //             Text(
                    //               'Reps',
                    //               style: AppTypography.label12XSM,
                    //             ),
                    //             Text(
                    //               '5',
                    //               style: AppTypography.title40_4XL,
                    //             )
                    //           ],
                    //         ),
                    //         Container()
                    //       ],
                    //     ),
                    //   ),
                    // if (index < widget.exerciseData.length)
                    //   Divider(
                    //     endIndent: 50,
                    //     indent: 50,
                    //     thickness: 5,
                    //     color: AppColor.linkPrimaryColor,
                    //   ),
                    // if (index >= widget.exerciseData.length)
                    //   Container(
                    //     width: double.infinity,
                    //     height: 50,
                    //     margin: const EdgeInsets.only(
                    //       left: 16,
                    //       right: 16,
                    //       bottom: 10,
                    //     ),
                    //     child: CustomElevatedButton(
                    //         onPressed: () {}, child: const Text('Set Done')),
                    //   ),

                    Align(
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
                                                        const EdgeInsets.all(6);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  color:
                                                      AppColor.textPrimaryColor,
                                                ))
                                          ],
                                        ),
                                        Text(
                                          'Push shoulder blades into bench.',
                                          style: AppTypography.paragraph14MD
                                              .copyWith(
                                                  color: AppColor
                                                      .textPrimaryColor),
                                        )
                                      ],
                                    )),
                        )),
                    18.height(),
                    Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: context.dynamicWidth * 0.9),
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
                                      padding: const EdgeInsets.all(20),
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: '1',
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
                                    SizedBox(
                                      height: 95,
                                      child: VerticalDivider(
                                        color: AppColor.borderSecondaryColor,
                                        thickness: 1.5,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: ValueListenableBuilder<int>(
                                            valueListenable: workoutCountDown,
                                            builder: (context, value, child) {
                                              return widget
                                                      .exerciseData.isNotEmpty
                                                  ? mordernDurationMSTextWidget(
                                                      clockTimer: Duration(
                                                          seconds: value))
                                                  : Text(
                                                      '20',
                                                      style: AppTypography
                                                          .title60_6XL
                                                          .copyWith(
                                                              color: AppColor
                                                                  .textEmphasisColor),
                                                    );
                                            })),
                                    SizedBox(
                                      height: 95,
                                      child: VerticalDivider(
                                        color: AppColor.borderSecondaryColor,
                                        thickness: 1.5,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: '1',
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
                                            text: '1',
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
                              // top: -context.dynamicHeight * 0.01,
                              // left: context.dynamicWidth * 0.03,
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
                                    widget.exerciseData.isNotEmpty
                                        ? 'Time'
                                        : 'Reps',
                                    style: AppTypography.label10XXSM.copyWith(
                                        color: AppColor.textPrimaryColor),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -8,
                              right: 10,
                              // top: -context.dynamicHeight * 0.01,
                              // left: context.dynamicWidth * 0.72,
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
                                  'Exercise',
                                  style: AppTypography.label10XXSM.copyWith(
                                      color: AppColor.textPrimaryColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: [
                    //       InkWell(
                    //         onTap: () async {
                    //           await pageController.animateToPage(
                    //               pageController.page!.toInt() - 1,
                    //               duration: const Duration(milliseconds: 100),
                    //               curve: Curves.easeOut);
                    //           getCurrentExercise(pageController.page!.toInt());
                    //           setState(() {});
                    //         },
                    //         child: Container(
                    //           color: AppColor.surfaceBackgroundBaseColor,
                    //           padding: const EdgeInsets.all(10),
                    //           child: const Icon(
                    //             Icons.keyboard_arrow_left,
                    //             size: 35,
                    //           ),
                    //         ),
                    //       ),
                    //       InkWell(
                    //         onTap: () {
                    //           // context.navigateTo(CategoryPlayerView(
                    //           //     videoURL: data?.mapVideo?.url.toString() ?? '',
                    //           //     thumbNail:
                    //           //         data?.mapImage?.url.toString() ?? ''));

                    //           if (_stopWatch.isRunning) {
                    //             _stopWatch.stop();
                    //           } else {
                    //             _stopWatch.start();
                    //           }

                    //           // _timer2.cancel();
                    //         },
                    //         child: Container(
                    //           color: AppColor.surfaceBackgroundBaseColor,
                    //           padding: const EdgeInsets.all(10),
                    //           child: const Icon(
                    //             Icons.pause,
                    //             size: 35,
                    //           ),
                    //         ),
                    //       ),
                    //       InkWell(
                    //         onTap: () async {
                    //           await pageController.animateToPage(
                    //               pageController.page!.toInt() + 1,
                    //               duration: const Duration(milliseconds: 100),
                    //               curve: Curves.easeIn);

                    //           getCurrentExercise(pageController.page!.toInt());
                    //           setState(() {});
                    //           // if (pageController.page!.toInt() >=
                    //           //     widget.exerciseData.length) {
                    //           //   await showModalBottomSheet(
                    //           //     isScrollControlled: true,
                    //           //     context: context,
                    //           //     builder: (context) => GetReadyViewWidget(
                    //           //         workoutModel: widget.workoutModel,
                    //           //         exerciseData: widget.exerciseData,
                    //           //         exerciseWorkoutData2:
                    //           //             widget.exerciseWorkoutData2,
                    //           //         exerciseWorkoutData: widget.exerciseData),
                    //           //   );
                    //           // } else {}
                    //         },
                    //         child: Container(
                    //           color: AppColor.surfaceBackgroundBaseColor,
                    //           padding: const EdgeInsets.all(10),
                    //           child: const Icon(
                    //             Icons.keyboard_arrow_right,
                    //             size: 35,
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // )
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
                                                Colors.black.withOpacity(0.5)),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
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
                                                child: BaseHelper.loadingWidget(
                                                    strokeWidth: 6,
                                                    value:
                                                        value.toDouble() / 5),
                                              ),
                                              Text(
                                                value.toString(),
                                                style: AppTypography.title40_4XL
                                                    .copyWith(
                                                        color: AppColor
                                                            .textInvertEmphasis),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                : Container();
                          })
                      : Container();
                }),
            Align(
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
                                getCurrentExercise(
                                    pageController.page!.toInt());
                                setState(() {});
                              },
                              child: Text('Prev',
                                  style: AppTypography.label18LG.copyWith(
                                      color: AppColor.buttonSecondaryColor))),
                        )),
                        16.width(),
                        Expanded(
                            child: ValueListenableBuilder<bool>(
                                valueListenable: isPlaying,
                                builder: (context, value, child) {
                                  return SizedBox(
                                    height: 50,
                                    child: CustomElevatedButton(
                                        btnColor: AppColor.buttonTertiaryColor,
                                        onPressed: () {
                                          isPlaying.value = !isPlaying.value;
                                        },
                                        child: value == true
                                            ? Icon(
                                                Icons.pause,
                                                color: AppColor
                                                    .buttonSecondaryColor,
                                              )
                                            : Icon(
                                                Icons.play_arrow_rounded,
                                                color: AppColor
                                                    .buttonSecondaryColor,
                                              )),
                                  );
                                })),
                        16.width(),
                        Expanded(
                            child: SizedBox(
                          height: 50,
                          child: CustomElevatedButton(
                              onPressed: () async {
                                await pageController.animateToPage(
                                    pageController.page!.toInt() + 1,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.easeIn);

                                getCurrentExercise(
                                    pageController.page!.toInt());
                                setState(() {});
                              },
                              child: const Text("Next")),
                        ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Up next: Jumping jacks',
                        style: AppTypography.label12XSM
                            .copyWith(color: AppColor.textPrimaryColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
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

  mordernDurationMSTextWidget({required Duration clockTimer}) {
    return Text(
      "${clockTimer.inMinutes.toString().padLeft(2, '0')}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}",
      style:
          AppTypography.title60_6XL.copyWith(color: AppColor.textEmphasisColor),
    );
  }
}
