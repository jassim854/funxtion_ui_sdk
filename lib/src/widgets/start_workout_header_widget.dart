import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

import 'header_imagesHeader_widget.dart';

class StartWorkoutHeaderWidget extends StatelessWidget
    implements PreferredSize {
  const StartWorkoutHeaderWidget({
    super.key,
    required this.durationNotifier,
    required this.sliderWarmUp,
    required this.sliderExercise,
    required this.sliderCoolDown,
    required this.sliderExercise2,
    required this.workoutModel,
    required this.warmUpData,
    required this.trainingData,
    required this.coolDownData,
    required this.actionWidget,
  });
  final ValueNotifier<int> durationNotifier;
  final WorkoutModel workoutModel;
  final Map<ExerciseDetailModel,ExerciseModel>warmUpData;
  final Map<ExerciseDetailModel,ExerciseModel>trainingData;
  final Map<ExerciseDetailModel,ExerciseModel>coolDownData;
  final ValueNotifier<double> sliderWarmUp;
  final ValueNotifier<double> sliderExercise;
  final ValueNotifier<double> sliderExercise2;
  final ValueNotifier<double> sliderCoolDown;

  final Widget actionWidget;
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
                return Text(value.mordernDurationTextWidget,
                    style: AppTypography.label14SM
                        .copyWith(color: AppColor.textPrimaryColor));
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
                if (warmUpData.isNotEmpty) ...[
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: sliderWarmUp,
                        builder: (context, value, child) {
                          return SizedBox(
                            height: 8,
                            child: CustomSLiderWidget(
                              sliderValue: value,
                              division: warmUpData.length,
                            ),
                          );
                        }),
                  ),
                  4.width(),
                ],

                if (trainingData.isNotEmpty) ...[
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: sliderExercise,
                        builder: (context, value, child) {
                          return SizedBox(
                            height: 8,
                            child: CustomSLiderWidget(
                              sliderValue: value,
                              division: trainingData.length,
                            ),
                          );
                        }),
                  ),
                  4.width(),
                ],

                if (coolDownData.isNotEmpty)
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: sliderExercise2,
                        builder: (context, value, child) {
                          return SizedBox(
                            height: 8,
                            child: CustomSLiderWidget(
                              sliderValue: value,
                              division: coolDownData.length,
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
                actionWidget
              ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);

  @override
  // TODO: implement child
  Widget get child => const Scaffold();
}


