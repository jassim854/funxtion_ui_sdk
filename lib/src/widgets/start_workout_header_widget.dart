import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

import 'header_imagesHeader_widget.dart';

class StartWorkoutHeaderWidget extends StatelessWidget
    implements PreferredSize {
  StartWorkoutHeaderWidget(
      {super.key,
      required this.durationNotifier,
      required this.sliderWarmUp,
      required this.sliderExercise,
      required this.sliderCoolDown,
      required this.sliderExercise2,
      required this.workoutModel,
      required this.exerciseData,
      required this.exerciseWorkoutData,
      required this.exerciseWorkoutData2,
      this.header2WorkoutActive = false,
      this.headerWarmUpActive = false,
      this.headerWorkoutActive = false,
      this.subHeader2WorkoutActive = false,
      this.subHeaderWarmupActive = false,
      this.subHeaderWorkoutActive = false,
      this.warmupBody,
      this.workoutCircuitBody,
      this.workoutRepsBody,
      this.goHereTap});
  final ValueNotifier<int> durationNotifier;
  final WorkoutModel workoutModel;
  final List<ExerciseModel> exerciseData;
  final List<ExerciseModel> exerciseWorkoutData;
  final List<ExerciseModel> exerciseWorkoutData2;
  final ValueNotifier<double> sliderWarmUp;
  final ValueNotifier<double> sliderExercise;
  final ValueNotifier<double> sliderExercise2;
  final ValueNotifier<double> sliderCoolDown;
  bool header2WorkoutActive,
      headerWarmUpActive,
      headerWorkoutActive,
      subHeader2WorkoutActive,
      subHeaderWarmupActive,
      subHeaderWorkoutActive;
  int? warmupBody, workoutCircuitBody, workoutRepsBody;
  final void Function(int)? goHereTap;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: AppColor.surfaceBrandDarkColor),
      elevation: 0,
      backgroundColor: AppColor.surfaceBackgroundColor,
      leading: Container(),
      leadingWidth: 0,
      title: Padding(
        padding: const EdgeInsets.only(top: 9),
        child: Column(
          children: [
            ValueListenableBuilder<int>(
              valueListenable: durationNotifier,
              builder: (_, value, child) {
                return mordernDurationTextWidget(clockTimer: Duration(seconds: value));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(children: [
                InkWell(
                    onTap: () {
                      context.maybePopPage();
                    },
                    child: Icon(
                      Icons.close,
                      color: AppColor.surfaceBrandDarkColor,
                    )),
                15.width(),
                if (exerciseData.isNotEmpty) ...[
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: sliderWarmUp,
                        builder: (context, value, child) {
                          return SizedBox(
                            height: 8,
                            child: CustomSLiderWidget(
                              sliderValue: value,
                              division: exerciseData.length,
                            ),
                          );
                        }),
                  ),
                  4.width(),
                ],

                if (exerciseWorkoutData.isNotEmpty) ...[
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: sliderExercise,
                        builder: (context, value, child) {
                          return SizedBox(
                            height: 8,
                            child: CustomSLiderWidget(
                              sliderValue: value,
                              division: exerciseWorkoutData.length,
                            ),
                          );
                        }),
                  ),
                  4.width(),
                ],

                if (exerciseWorkoutData2.isNotEmpty)
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: sliderExercise2,
                        builder: (context, value, child) {
                          return SizedBox(
                            height: 8,
                            child: CustomSLiderWidget(
                              sliderValue: value,
                              division: exerciseWorkoutData2.length,
                            ),
                          );
                        }),
                  ),
                // 6.width(),
                // if (false)
                //   Expanded(
                //     child: ValueListenableBuilder(
                //         valueListenable: sliderCoolDown,
                //         builder: (context, value, child) {
                //           return SizedBox(
                //             height: 8,
                //
                //             child: CustomSLiderWidget(
                //               sliderValue: value,
                //               division: ,
                //             ),
                //           );
                //         }),
                //   ),
                15.width(),
                InkWell(
                    onTap: () async {
                      await showModalBottomSheet(
                        backgroundColor: AppColor.surfaceBackgroundBaseColor,
                        useSafeArea: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => OverviewBottomSheet(
                          exerciseWorkoutData2: exerciseWorkoutData2,
                          workoutModel: workoutModel,
                          exerciseData: exerciseData,
                          exerciseWorkoutData: exerciseWorkoutData,
                          header2WorkoutActive: header2WorkoutActive,
                          headerWarmUpActive: headerWarmUpActive,
                          headerWorkoutActive: headerWorkoutActive,
                          subHeader2WorkoutActive: subHeader2WorkoutActive,
                          subHeaderWarmupActive: subHeaderWarmupActive,
                          subHeaderWorkoutActive: subHeaderWorkoutActive,
                          warmupBody: warmupBody,
                          workoutCircuitBody: workoutCircuitBody,
                          workoutRepsBody: workoutRepsBody,
                          goHereTap: goHereTap,
                        ),
                      );
                    },
                    child: const Icon(Icons.interests_outlined)),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  mordernDurationTextWidget({required Duration clockTimer}) {
    return Text(
      "${clockTimer.inHours.remainder(60).toString()}:${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}",
      style: AppTypography.label14SM.copyWith(color: AppColor.textPrimaryColor),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);

  @override
  // TODO: implement child
  Widget get child => const Scaffold();
}

class OverviewBottomSheet extends StatefulWidget {
  final WorkoutModel workoutModel;
  final List<ExerciseModel> exerciseData;
  final List<ExerciseModel> exerciseWorkoutData;
  final List<ExerciseModel> exerciseWorkoutData2;
  final int? warmupBody;
  final int? workoutCircuitBody;
  final int? workoutRepsBody;
  final void Function(int)? goHereTap;
  bool headerWarmUpActive,
      subHeaderWarmupActive,
      headerWorkoutActive,
      subHeaderWorkoutActive,
      header2WorkoutActive,
      subHeader2WorkoutActive;
  OverviewBottomSheet(
      {super.key,
      required this.workoutModel,
      required this.exerciseData,
      required this.exerciseWorkoutData,
      required this.exerciseWorkoutData2,
      this.warmupBody,
      this.workoutCircuitBody,
      this.workoutRepsBody,
      required this.header2WorkoutActive,
      required this.headerWarmUpActive,
      required this.headerWorkoutActive,
      required this.subHeader2WorkoutActive,
      required this.subHeaderWarmupActive,
      required this.subHeaderWorkoutActive,
      this.goHereTap});

  @override
  State<OverviewBottomSheet> createState() => _OverviewBottomSheetState();
}

class _OverviewBottomSheetState extends State<OverviewBottomSheet> {
  ValueNotifier<bool> warmUpExpand = ValueNotifier(true);
  ValueNotifier<bool> warmUpExpand1 = ValueNotifier(true);
  ValueNotifier<bool> trainingExpand = ValueNotifier(true);
  ValueNotifier<bool> trainingExpand1 = ValueNotifier(true);
  ValueNotifier<bool> trainingExpand2 = ValueNotifier(true);

  List<Widget>? stepperData;
  List<Widget>? stepperData2;
  List oddList = [];
  List evenList = [];
  List firstOddThenEven = [];
  @override
  void initState() {
    print(firstOddThenEven);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text(
                  'Overview',
                  style: AppTypography.title18LG
                      .copyWith(color: AppColor.textEmphasisColor),
                ),
                InkWell(
                  onTap: () {
                    context.popPage();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 16,
                    ),
                    decoration: BoxDecoration(
                        color: AppColor.surfaceBackgroundSecondaryColor,
                        shape: BoxShape.circle),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.close,
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
          const CustomDivider(thickness: 2.5),
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 40, bottom: 20),
            child: Text(
              widget.workoutModel.title,
              style: AppTypography.title28_2XL
                  .copyWith(color: AppColor.textEmphasisColor),
            ),
          ),
          ColoredBox(
            color: AppColor.surfaceBackgroundColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Column(
                    children: [
                      20.height(),

                      ///header warmup
                      Column(
                        children: [
                          StepWidget(isActive: widget.headerWarmUpActive),
                          Container(
                              width: 2.5,
                              height: 40,
                              color: AppColor.surfaceBrandDarkColor),
                        ],
                      ),

                      /// header2
                      ValueListenableBuilder<bool>(
                          valueListenable: warmUpExpand,
                          builder: (context, value, child) {
                            return ExpandedSection(
                              expand: value,
                              child: Column(
                                children: [
                                  Container(
                                      width: 2.5,
                                      height: 30,
                                      color: AppColor.surfaceBrandDarkColor),
                                  StepWidget(
                                      isActive: widget.subHeaderWarmupActive),
                                  Container(
                                      width: 2.5,
                                      height: 35,
                                      color: AppColor.surfaceBrandDarkColor),
                                ],
                              ),
                            );
                          }),

                      /// wramup body loop
                      for (int i = 0; i < widget.exerciseData.length; i++)
                        ValueListenableBuilder<bool>(
                            valueListenable: warmUpExpand1,
                            builder: (context, value, child) {
                              return ExpandedSection(
                                expand: value,
                                child: Column(
                                  children: [
                                    if (i == 0)
                                      Container(
                                          width: 2.5,
                                          height: 35,
                                          color:
                                              AppColor.surfaceBrandDarkColor),
                                    StepWidget(
                                      isActive: i == widget.warmupBody,
                                    ),
                                    if (i < widget.exerciseData.length - 1)
                                      Container(
                                          width: 2.5,
                                          height: 70,
                                          color: AppColor.surfaceBrandDarkColor)
                                  ],
                                ),
                              );
                            }),

                      ///header workout
                      Column(
                        children: [
                          Container(
                              width: 2.5,
                              height: 40,
                              color: AppColor.surfaceBrandDarkColor),
                          StepWidget(
                            isActive: widget.headerWorkoutActive,
                          ),
                        ],
                      ),

                      /// header 2 workout
                      ValueListenableBuilder<bool>(
                          valueListenable: trainingExpand,
                          builder: (context, value, child) {
                            return ExpandedSection(
                              expand: value,
                              child: Column(
                                children: [
                                  Container(
                                      width: 2.5,
                                      height: 60,
                                      color: AppColor.surfaceBrandDarkColor),
                                  StepWidget(
                                      isActive: widget.subHeaderWorkoutActive),
                                  Container(
                                      width: 2.5,
                                      height: 35,
                                      color: AppColor.surfaceBrandDarkColor),
                                ],
                              ),
                            );
                          }),

                      /// circuit time body loop
                      for (int i = 0;
                          i < widget.exerciseWorkoutData.length;
                          i++)
                        ValueListenableBuilder<bool>(
                            valueListenable: trainingExpand1,
                            builder: (context, value, child) {
                              return ExpandedSection(
                                expand: value,
                                child: Column(
                                  children: [
                                    if (i == 0)
                                      Container(
                                          width: 2.5,
                                          height: 35,
                                          color:
                                              AppColor.surfaceBrandDarkColor),
                                    StepWidget(
                                      isActive: i == widget.workoutCircuitBody,
                                    ),
                                    if (i <
                                        widget.exerciseWorkoutData.length - 1)
                                      Container(
                                          width: 2.5,
                                          height: 70,
                                          color: AppColor.surfaceBrandDarkColor)
                                  ],
                                ),
                              );
                            }),

                      /// after circuit body loop
                      ValueListenableBuilder(
                          valueListenable: trainingExpand,
                          builder: (context, value, child) {
                            return ExpandedSection(
                              expand: value,
                              child: Column(
                                children: [
                                  Container(
                                      width: 2.5,
                                      height: 35,
                                      color: AppColor.surfaceBrandDarkColor),
                                  StepWidget(
                                      isActive: widget.subHeader2WorkoutActive),
                                ],
                              ),
                            );
                          }),

                      /// reps body time loop
                      for (int i = 0;
                          i < widget.exerciseWorkoutData2.length;
                          i++)
                        ValueListenableBuilder<bool>(
                            valueListenable: trainingExpand2,
                            builder: (context, value, child) {
                              return ExpandedSection(
                                expand: value,
                                child: Column(
                                  children: [
                                    if (i == 0)
                                      Container(
                                          width: 2.5,
                                          height: 75,
                                          color:
                                              AppColor.surfaceBrandDarkColor),
                                    StepWidget(
                                      isActive: i == widget.workoutRepsBody,
                                    ),
                                    if (i <
                                        widget.exerciseWorkoutData2.length - 1)
                                      Container(
                                          width: 2.5,
                                          height: 75,
                                          color: AppColor.surfaceBrandDarkColor)
                                  ],
                                ),
                              );
                            }),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      BuildHeader(
                        loaderListenAble: ValueNotifier(false),
                        dataLIst: widget.exerciseData,
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
                      BuildHeader2(
                        expandBodyValueListenable: warmUpExpand,
                        subtitle:
                            "${widget.workoutModel.phases?.first.items.isEmpty??false ? 0 : widget.workoutModel.phases?.first.items.first.seExercises?.first.sets.length} rounds",
                        loaderListenable: ValueNotifier(false),
                        expandValueListenable: warmUpExpand1,
                        exerciseWorkoutData: widget.exerciseData,
                        title: 'Single Exercise',
                        onTap: () {
                          warmUpExpand1.value = !warmUpExpand1.value;
                        },
                      ),
                      BuildBodySingleExercise(
                        showTrailing: true,
                        goHereTap: widget.goHereTap,
                        workoutModel: widget.workoutModel,
                        dataList: widget.exerciseData,
                        valueListenable: warmUpExpand1,
                        valueListenable1: ValueNotifier(false),
                        bodySubtitle:
                            "${widget.workoutModel.phases?[0].items.isEmpty??false ? '' : widget.workoutModel.phases?[0].items.first.seExercises?.map((e) => e.sets.first.goalTargets.first.value)} seconds",
                      ),
                      const CustomDivider(
                        thickness: 2.5,
                      ),
                      BuildHeader(
                        loaderListenAble: ValueNotifier(false),
                        dataLIst: widget.exerciseWorkoutData,
                        title: 'Workout',
                        valueListenable: trainingExpand,
                        onTap: () {
                          if (trainingExpand.value == true) {
                            trainingExpand.value = false;
                            trainingExpand1.value = false;
                            trainingExpand2.value = false;
                          } else {
                            trainingExpand.value = true;
                          }
                        },
                      ),
                      BuildHeader2(
                        expandBodyValueListenable: trainingExpand,
                        subtitle:
                            "${widget.workoutModel.phases?[1].items.first.ctRounds?.isEmpty??false ? 0 : widget.workoutModel.phases?[1].items.first.ctRounds?.length} rounds",
                        loaderListenable: ValueNotifier(false),
                        title: "Circuit Time",
                        expandValueListenable: trainingExpand1,
                        onTap: () {
                          trainingExpand1.value = !trainingExpand1.value;
                        },
                        exerciseWorkoutData: widget.exerciseWorkoutData,
                      ),
                      BuildBodySingleExercise(
                          goHereTap: widget.goHereTap,
                          showTrailing: true,
                          bodySubtitle:
                              "${widget.workoutModel.phases?[1].items.first.ctRounds?.isEmpty??false ? "" : widget.workoutModel.phases?[1].items.first.ctRounds?.first.exercises.map((e) => e.notes).toString()}",
                          workoutModel: widget.workoutModel,
                          dataList: widget.exerciseWorkoutData,
                          valueListenable: trainingExpand1,
                          valueListenable1: ValueNotifier(false)),
                      BuildHeader2(
                        expandBodyValueListenable: trainingExpand,
                        subtitle:
                            "${widget.workoutModel.phases?[1].items.first.rftExercises?.isEmpty??false ? "0" : widget.workoutModel.phases?[1].items.first.rftExercises?.first.goalTargets.length} rounds",
                        loaderListenable: ValueNotifier(false),
                        title: "Reps Time",
                        expandValueListenable: trainingExpand2,
                        onTap: () {
                          trainingExpand2.value = !trainingExpand2.value;
                        },
                        exerciseWorkoutData: widget.exerciseWorkoutData2,
                      ),
                      BuildBodySingleExercise(
                          goHereTap: widget.goHereTap,
                          showTrailing: true,
                          bodySubtitle:
                              "${widget.workoutModel.phases?[1].items.first.rftExercises?.isNotEmpty??false ? {
                                  widget.workoutModel.phases?[1].items.first
                                      .rftExercises?.first.notes
                                } : ""}",
                          workoutModel: widget.workoutModel,
                          dataList: widget.exerciseWorkoutData2,
                          valueListenable: trainingExpand2,
                          valueListenable1: ValueNotifier(false))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StepWidget extends StatelessWidget {
  bool isActive;

  StepWidget({
    super.key,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? Colors.black : Colors.white,
                border: Border.all(color: Colors.black, width: 2.5)),
            child: isActive
                ? Transform.scale(
                    scale: 1.5,
                    child: const Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.white,
                      weight: 2,
                      shadows: [
                        Shadow(
                            color: Colors.white,
                            offset: Offset(0, 0.1),
                            blurRadius: 30)
                      ],
                    ),
                  )
                : null),
      ],
    );
  }
}
