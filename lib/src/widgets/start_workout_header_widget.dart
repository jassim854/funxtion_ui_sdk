import 'dart:async';

import 'package:flutter/material.dart';

import '../../ui_tool_kit.dart';

class StartWorkoutHeaderWidget extends StatefulWidget
    implements PreferredSizeWidget {
  StartWorkoutHeaderWidget(
      {super.key,
      required this.workoutModel,
      required this.mainTimer,
      required this.warmUpData,
      required this.trainingData,
      required this.coolDownData,
      required this.sliderWarmUp,
      required this.sliderTraining,
      required this.sliderCoolDown,
      required this.actionWidget,
      required this.durationNotifier});

  final WorkoutModel workoutModel;
  final Map<ExerciseDetailModel, ExerciseModel> warmUpData;
  final Map<ExerciseDetailModel, ExerciseModel> trainingData;
  final Map<ExerciseDetailModel, ExerciseModel> coolDownData;
  final ValueNotifier<double> sliderWarmUp;
  final ValueNotifier<double> sliderTraining;

  final ValueNotifier<double> sliderCoolDown;
  final ValueNotifier<int> durationNotifier;
  final Widget actionWidget;
  Timer? mainTimer;
  @override
  State<StartWorkoutHeaderWidget> createState() =>
      _StartWorkoutHeaderWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _StartWorkoutHeaderWidgetState extends State<StartWorkoutHeaderWidget> {
  @override
  void initState() {
    if (widget.mainTimer?.isActive == false ||
        widget.mainTimer == null && widget.durationNotifier.value == 0) {
      widget.mainTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        widget.durationNotifier.value += 1;
      });
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.mainTimer?.isActive == true) {
        widget.mainTimer?.cancel();
        widget.durationNotifier.value = 0;
      }
    });

    // TODO: implement dispose
    super.dispose();
  }

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
              valueListenable: widget.durationNotifier,
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
                if (widget.warmUpData.isNotEmpty) ...[
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: widget.sliderWarmUp,
                        builder: (context, value, child) {
                          return CustomSLiderWidget(
                            sliderValue: value,
                            division: widget.warmUpData.length,
                          );
                        }),
                  ),
                  4.width(),
                ],

                if (widget.trainingData.isNotEmpty) ...[
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: widget.sliderTraining,
                        builder: (context, value, child) {
                          return CustomSLiderWidget(
                            sliderValue: value,
                            division: widget.trainingData.length,
                          );
                        }),
                  ),
                  4.width(),
                ],

                if (widget.coolDownData.isNotEmpty)
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: widget.sliderCoolDown,
                        builder: (context, value, child) {
                          return CustomSLiderWidget(
                            sliderValue: value,
                            division: widget.coolDownData.length,
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
                widget.actionWidget
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
