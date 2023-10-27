import 'package:flutter/material.dart';

import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/src/ui/view/start_workout_view.dart';
import 'package:ui_tool_kit/src/widgets/start_workout_header_widget.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

import 'header_imagesHeader_widget.dart';

class GetReadyViewWidget extends StatefulWidget {
  const GetReadyViewWidget(
      {super.key,
      required this.workoutModel,
      required this.exerciseData,
      required this.exerciseWorkoutData,
      required this.exerciseWorkoutData2,
      this.fitnessGoalModel});
  final WorkoutModel workoutModel;
  final List<ExerciseModel> exerciseData;
  final List<ExerciseModel> exerciseWorkoutData;
  final List<ExerciseModel> exerciseWorkoutData2;
  final FitnessGoalModel? fitnessGoalModel;

  @override
  State<GetReadyViewWidget> createState() => _GetReadyViewWidgetState();
}

class _GetReadyViewWidgetState extends State<GetReadyViewWidget> {
  String? title, headerTitle, headerSubtitle, bodySubtitle;
  List<ExerciseModel>? currentExerciseData;
  ValueNotifier<bool> warmUpExpand1 = ValueNotifier(true);

  // listWarmUpFn() {
  //   if (widget.workoutModel.phases!.first.items.isNotEmpty) {
  //     warmUpLength =
  //         widget.workoutModel.phases!.first.items.first.seExercises!.length;
  //   }
  //   if (widget.workoutModel.phases![1].items.isNotEmpty) {
  //     if (widget.workoutModel.phases![1].items.first.ctRounds!.isNotEmpty) {
  //       workoutLength = widget.workoutModel.phases![1].items.first.ctRounds!
  //           .first.exercises.length;
  //     } else {
  //       workoutLength =
  //           widget.workoutModel.phases![1].items.first.rftExercises?.length ??
  //               0;
  //     }
  //   }
  //   if (widget.workoutModel.phases![2].items.isNotEmpty) {
  //     coolDOwnnLength = widget.workoutModel.phases![2].items.length;
  //   }

  //   lengthPhases = warmUpLength + workoutLength + coolDOwnnLength;
  // }
  initFn() {
    if (widget.exerciseData.isEmpty && widget.exerciseWorkoutData.isNotEmpty) {
      title = 'Training';
      headerTitle = 'Circuit Time';
      headerSubtitle =
          "${widget.workoutModel.phases?[1].items.first.ctRounds?.isEmpty == 0 ? 0 : widget.workoutModel.phases?[1].items.first.ctRounds?.length} rounds";
      bodySubtitle =
          "${widget.workoutModel.phases?[1].items.first.ctRounds?.first.exercises.map((e) => e.notes)}";
      currentExerciseData = widget.exerciseWorkoutData;
    } else if (widget.exerciseWorkoutData.isEmpty &&
        widget.exerciseWorkoutData2.isNotEmpty) {
      title = 'training 2';
      headerTitle = 'Reps Time';
      headerSubtitle =
          "${widget.workoutModel.phases?[1].items.first.rftExercises?.isEmpty??false ? 0 : widget.workoutModel.phases?[1].items.first.rftExercises?.first.goalTargets.length} rounds";
      bodySubtitle =
          "${widget.workoutModel.phases?[1].items.first.rftExercises?.first.notes}";
      currentExerciseData = widget.exerciseWorkoutData2;
    } else {
      title = 'Warmup';
      headerTitle = 'Single Exercise';
      headerSubtitle =
          "${widget.workoutModel.phases?.first.items.isEmpty??false ? 0 : widget.workoutModel.phases?.first.items.first.seExercises?.first.sets.length} rounds";
      bodySubtitle =
          "${widget.workoutModel.phases?[0].items.first.seExercises?.map((e) => e.sets.first.goalTargets.first.value)} seconds";
      currentExerciseData = widget.exerciseData;
    }
  }

  @override
  void initState() {
    initFn();
    // listWarmUpFn();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surfaceBackgroundBaseColor,
      appBar: StartWorkoutHeaderWidget(
        exerciseData: widget.exerciseData,
        exerciseWorkoutData2: widget.exerciseWorkoutData2,
        exerciseWorkoutData: widget.exerciseWorkoutData,
        workoutModel: widget.workoutModel,
        durationNotifier: ValueNotifier(0),
        sliderWarmUp: ValueNotifier(0),
        sliderExercise: ValueNotifier(0),
        sliderCoolDown: ValueNotifier(0),
        sliderExercise2: ValueNotifier(0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 40),
              child: Text('Up next',
                  style: AppTypography.label14SM
                      .copyWith(color: AppColor.textSubTitleColor)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                title.toString(),
                style: AppTypography.title28_2XL,
              ),
            ),
            Card(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              color: AppColor.surfaceBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 12, bottom: 12),
                    child: Text("Equipment",
                        style: AppTypography.label14SM
                            .copyWith(color: AppColor.textPrimaryColor)),
                  ),
                  const CustomDivider(),
                  ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 20),
                          child: Row(
                            children: [
                              Text(
                                'Kettlebell',
                                style: AppTypography.label16MD.copyWith(
                                    color: AppColor.textEmphasisColor),
                              ),
                              12.width(),
                              Text(
                                '20 kg',
                                style: AppTypography.paragraph14MD
                                    .copyWith(color: AppColor.textPrimaryColor),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const CustomDivider();
                      },
                      itemCount: 2)
                ],
              ),
            ),
            Column(
              children: [
                BuildHeader2(
                  expandBodyValueListenable: ValueNotifier(true),
                  subtitle: headerSubtitle.toString(),
                  loaderListenable: ValueNotifier(false),
                  expandValueListenable: warmUpExpand1,
                  exerciseWorkoutData: currentExerciseData ?? [],
                  title: headerTitle.toString(),
                  onTap: () {
                    warmUpExpand1.value = !warmUpExpand1.value;
                  },
                ),
                BuildBodySingleExercise(
                    workoutModel: widget.workoutModel,
                    dataList: currentExerciseData ?? [],
                    valueListenable: warmUpExpand1,
                    valueListenable1: ValueNotifier(false),
                    bodySubtitle: bodySubtitle.toString()),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
        child: Row(
          children: [
            Expanded(
                child: SizedBox(
              height: 50,
              child: CustomElevatedButton(
                  btnColor: AppColor.surfaceBackgroundSecondaryColor,
                  onPressed: () {},
                  child: Text('Prev',
                      style: AppTypography.label18LG
                          .copyWith(color: AppColor.textSubTitleColor))),
            )),
            16.width(),
            Expanded(
                child: SizedBox(
              height: 50,
              child: CustomElevatedButton(
                  onPressed: () {
                    context.navigateTo(StartWorkoutView(
                      workoutModel: widget.workoutModel,
                      exerciseData: widget.exerciseData,
                      exerciseWorkoutData: widget.exerciseWorkoutData,
                      exerciseWorkoutData2: widget.exerciseWorkoutData2,
                    ));
                  },
                  child: const Text("Let's go")),
            ))
          ],
        ),
      ),
    );
  }
}
