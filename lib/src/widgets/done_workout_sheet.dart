import 'package:flutter/material.dart';
import 'package:ui_tool_kit/src/ui/view/workout_detail_view.dart';

import '../../ui_tool_kit.dart';

class DoneWorkoutSheet extends StatelessWidget {
  final String workoutName, type;
  final int totalDuration;
  const DoneWorkoutSheet(
      {super.key,
      required this.workoutName,
      required this.type,
      required this.totalDuration});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.surfaceBackgroundBaseColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 24, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.grey,
                    ),
                    Text(
                      "You’ve completed",
                      style: AppTypography.label14SM
                          .copyWith(color: AppColor.textSubTitleColor),
                    )
                  ],
                ),
                Text(
                  "",
                  style: AppTypography.title28_2XL
                      .copyWith(color: AppColor.textEmphasisColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 31),
            child: Row(
              children: [
                Expanded(
                  child: BuildCardWidget(
                      checkNum: false,
                      subtitle: totalDuration.mordernDurationTextWidget,
                      title: 'Total Duration'),
                ),
                20.width(),
                Expanded(child: BuildCardWidget(title: 'Type', subtitle: ''))
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            height: context.dynamicHeight * 0.065,
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
            child: CustomElevatedButton(
                radius: 16,
                btnColor: AppColor.buttonPrimaryColor,
                onPressed: () {
                  context.navigateToRemovedUntil(
                      const VideoAudioClassesListView(
                          categoryName: CategoryName.workouts));
                },
                child: Text(
                  "Done",
                  style: AppTypography.label18LG
                      .copyWith(color: AppColor.textInvertEmphasis),
                )),
          )
        ],
      ),
    );
  }
}
