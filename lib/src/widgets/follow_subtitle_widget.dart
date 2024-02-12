import 'package:flutter/material.dart';

import '../../ui_tool_kit.dart';

class FollowSubtitleWidget extends StatelessWidget {
  FollowTrainingplanModel followTrainingData;
  FollowSubtitleWidget({super.key, required this.followTrainingData});
  String calculatePercentage(
    int current,
    int total,
  ) {
    double percentage = (current / total) * 100;
    return "${percentage.toStringAsFixed(1)} %";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: AppColor.buttonPrimaryColor, shape: BoxShape.circle),
          child: Icon(Icons.check, size: 14, color: AppColor.buttonLabelColor),
        ),
        4.width(),
        Text('Following',
            style: AppTypography.label14SM
                .copyWith(color: AppColor.buttonPrimaryColor)),
        Text(
          " • ",
          style: AppTypography.label16MD
              .copyWith(color: AppColor.textPrimaryColor),
        ),
        Text(
          calculatePercentage(followTrainingData.workoutCount.toInt(),
              followTrainingData.totalWorkoutLength.toInt()),
          style: AppTypography.paragraph14MD
              .copyWith(color: AppColor.textPrimaryColor),
        )
      ],
    );
  }
}
