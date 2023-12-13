import 'package:flutter/material.dart';
import 'package:ui_tool_kit/src/ui/view/start_workout_view.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class GetReadyViewWidget extends StatefulWidget {
  const GetReadyViewWidget(
      {super.key,
      required this.workoutModel,
      required this.warmUpData,
      required this.trainingData,
      required this.coolDownData,
      this.fitnessGoalModel,
      required this.equipmentData});
  final WorkoutModel workoutModel;
  final Map<ExerciseDetailModel, ExerciseModel> warmUpData;
  final Map<ExerciseDetailModel, ExerciseModel> trainingData;
  final Map<ExerciseDetailModel, ExerciseModel> coolDownData;
  final FitnessGoalModel? fitnessGoalModel;
  final List<EquipmentModel> equipmentData;

  @override
  State<GetReadyViewWidget> createState() => _GetReadyViewWidgetState();
}

class _GetReadyViewWidgetState extends State<GetReadyViewWidget> {
  Map<ExerciseDetailModel, ExerciseModel> circuitTimeData = {};
  Map<ExerciseDetailModel, ExerciseModel> rftExerciseData = {};
  Map<ExerciseDetailModel, ExerciseModel> seExerciseData = {};
  Map<ExerciseDetailModel, ExerciseModel> ssExerciseData = {};
  String? title;
  Map<ExerciseDetailModel, ExerciseModel> currentListData = {};
  ValueNotifier<bool> expand = ValueNotifier(true);

  initFn() {
    if (widget.warmUpData.isEmpty && widget.trainingData.isNotEmpty) {
      title = 'Training';

      currentListData = widget.trainingData;
    } else if (widget.trainingData.isEmpty && widget.coolDownData.isNotEmpty) {
      title = 'Cool Down';

      currentListData = widget.coolDownData;
    } else {
      title = 'Warmup';

      currentListData = widget.warmUpData;
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
        warmUpData: widget.warmUpData,
        coolDownData: widget.coolDownData,
        trainingData: widget.trainingData,
        workoutModel: widget.workoutModel,
        durationNotifier: ValueNotifier(0),
        sliderWarmUp: ValueNotifier(0),
        sliderExercise: ValueNotifier(0),
        sliderCoolDown: ValueNotifier(0),
        sliderExercise2: ValueNotifier(0),
        actionWidget: InkWell(
            onTap: () async {
              await showModalBottomSheet(
                backgroundColor: AppColor.surfaceBackgroundBaseColor,
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (context) => OverviewBottomSheet(
                  warmUpData: widget.warmUpData,
                  coolDownData: widget.coolDownData,
                  trainingData: widget.trainingData,
                  workoutModel: widget.workoutModel,
                ),
              );
            },
            child: const Icon(Icons.interests_outlined)),
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
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 0),
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
                                widget.equipmentData[index].name,
                                style: AppTypography.label16MD.copyWith(
                                    color: AppColor.textEmphasisColor),
                              ),
                              12.width(),
                              Text(
                                '',
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
                      itemCount: widget.equipmentData.length)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  BuildHeader(
                    loaderListenAble: ValueNotifier(false),
                    dataLIst: currentListData,
                    title: title.toString(),
                    expandHeaderValueListenable: expand,
                    onTap: () {
                      expand.value = !expand.value;
                    },
                  ),
                  BuildBodyWidget(
                    currentListData: currentListData,
                    expandHeaderValueListenable: expand,
                    loaderValueListenable: ValueNotifier(false),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 15),
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
                      warmUpData: widget.warmUpData,
                      trainingData: widget.trainingData,
                      coolDownData: widget.coolDownData,
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
