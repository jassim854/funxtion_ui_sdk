import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';
import '../ui/view/start_workout_view.dart';

class StartWorkoutSheet extends StatelessWidget {
  const StartWorkoutSheet(
      {super.key,
      required this.workoutModel,
      required this.exerciseData,
      required this.exerciseWorkoutData,
      required this.fitnessGoalModel});
  final WorkoutModel workoutModel;
  final List<ExerciseModel> exerciseData;
  final List<ExerciseModel> exerciseWorkoutData;
  final FitnessGoalModel? fitnessGoalModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      color: AppColor.surfaceBackgroundBaseColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    context.popPage();
                  },
                  child: const Icon(Icons.close)),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Workout",
                    style: AppTypography.label16MD,
                  )),
              Container()
            ],
          ),
          20.height(),
          Text(
            'Get ready for',
            style: AppTypography.paragraph14MD
                .copyWith(color: AppColor.textSubTitleColor),
          ),
          Text(
            'DOUBLE THE FUN',
            style: AppTypography.title28_2XL,
          ),
          20.height(),
          Row(
            children: [
              Expanded(
                child: BuildCardWidget(
                    subtitle: workoutModel.duration, title: 'Duration'),
              ),
              20.width(),
              Expanded(
                  child: BuildCardWidget(
                      title: 'Goal', subtitle: fitnessGoalModel?.name ?? ""))
            ],
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: CustomElevatedButton(
                elevation: 0,
                btnColor: const Color(0xffE6EDFD),
                onPressed: () {
                  context.navigateTo(StartWorkoutView(
                    fitnessGoalModel: fitnessGoalModel,
                    workoutModel: workoutModel,
                    exerciseData: exerciseData,
                    exerciseWorkoutData: exerciseWorkoutData,
                  ));
                },
                child: Text(
                  'Start Workout',
                  style: AppTypography.label18LG
                      .copyWith(color: const Color(0xff5A7DCE)),
                )),
          )
        ],
      ),
    );
  }
}
