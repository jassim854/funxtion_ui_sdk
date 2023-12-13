import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../ui_tool_kit.dart';

class OverviewBottomSheet extends StatefulWidget {
  final WorkoutModel workoutModel;
  final Map<ExerciseDetailModel, ExerciseModel> warmUpData;
  final Map<ExerciseDetailModel, ExerciseModel> trainingData;
  final Map<ExerciseDetailModel, ExerciseModel> coolDownData;
  final int? warmupBody;
  final int? trainingBody;
  final int? coolDownBody;
  final void Function(int)? goHereTapWarmUp;
  final void Function(int)? goHereTapTraining;
  final void Function(int)? goHereTapCoolDown;
  final bool headerWarmUpActive,
      subHeaderWarmupActive,
      headerWorkoutActive,
      subHeaderWorkoutActive,
      header2WorkoutActive,
      subHeader2WorkoutActive;
  const OverviewBottomSheet(
      {super.key,
      required this.workoutModel,
      required this.warmUpData,
      required this.trainingData,
      required this.coolDownData,
      this.warmupBody,
      this.trainingBody,
      this.coolDownBody,
      this.header2WorkoutActive = false,
      this.headerWarmUpActive = false,
      this.headerWorkoutActive = false,
      this.subHeader2WorkoutActive = false,
      this.subHeaderWarmupActive = false,
      this.subHeaderWorkoutActive = false,
      this.goHereTapWarmUp,
      this.goHereTapTraining,
      this.goHereTapCoolDown});

  @override
  State<OverviewBottomSheet> createState() => _OverviewBottomSheetState();
}

class _OverviewBottomSheetState extends State<OverviewBottomSheet> {
  ValueNotifier<bool> warmUpExpand = ValueNotifier(true);

  ValueNotifier<bool> trainingExpand = ValueNotifier(true);
  ValueNotifier<bool> coolDownExpand = ValueNotifier(true);
  ValueNotifier<bool> ctExpandWarmup = ValueNotifier(true);
  ValueNotifier<bool> crExpandWarmup = ValueNotifier(true);
  ValueNotifier<bool> seExpandWarmup = ValueNotifier(true);
  ValueNotifier<bool> rftExpandWarmup = ValueNotifier(true);
  ValueNotifier<bool> ssExpandWarmup = ValueNotifier(true);
  ValueNotifier<bool> amrapExpandWarmup = ValueNotifier(true);
  ValueNotifier<bool> enomExpandWarmup = ValueNotifier(true);

  ValueNotifier<bool> ctExpandTraining = ValueNotifier(true);
  ValueNotifier<bool> crExpandTraining = ValueNotifier(true);
  ValueNotifier<bool> seExpandTraining = ValueNotifier(true);
  ValueNotifier<bool> rftExpandTraining = ValueNotifier(true);
  ValueNotifier<bool> ssExpandTraining = ValueNotifier(true);
  ValueNotifier<bool> amrapExpandTraining = ValueNotifier(true);
  ValueNotifier<bool> enomExpandTraining = ValueNotifier(true);

  ValueNotifier<bool> ctExpandCoolDown = ValueNotifier(true);
  ValueNotifier<bool> crExpandCoolDown = ValueNotifier(true);
  ValueNotifier<bool> seExpandCoolDown = ValueNotifier(true);
  ValueNotifier<bool> rftExpandCoolDown = ValueNotifier(true);
  ValueNotifier<bool> ssExpandCoolDown = ValueNotifier(true);
  ValueNotifier<bool> amrapExpandCoolDown = ValueNotifier(true);
  ValueNotifier<bool> enomExpandCoolDown = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 12, bottom: 8, left: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 16,
                ),
                Text(
                  'Overview',
                  style: AppTypography.title18LG
                      .copyWith(color: AppColor.textEmphasisColor),
                ),
                InkWell(
                  onTap: () {
                    context.maybePopPage();
                  },
                  child: Container(
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
              widget.workoutModel.title.toString(),
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
                      30.height(),
                      if (widget.warmUpData.isNotEmpty) ...[
                        ProgressBarWidget(
                          currentList: widget.warmUpData,
                          current: widget.warmupBody?.toInt() ?? -1,
                          amrapExpand: amrapExpandWarmup,
                          crExpand: crExpandWarmup,
                          ctExpand: ctExpandWarmup,
                          enomExpand: enomExpandWarmup,
                          rftExpand: rftExpandWarmup,
                          seExpand: seExpandWarmup,
                          ssExpand: ssExpandWarmup,
                          currentExpand: warmUpExpand,
                        ),
                      ],
                      if (widget.warmUpData.isNotEmpty &&
                          widget.trainingData.isNotEmpty)
                        Container(
                            width: 2.5,
                            height: 55,
                            color: AppColor.borderBrandDarkColor),
                      if (widget.trainingData.isNotEmpty)
                        ProgressBarWidget(
                          currentList: widget.trainingData,
                          current: widget.trainingBody?.toInt() ?? -1,
                          amrapExpand: amrapExpandTraining,
                          crExpand: crExpandTraining,
                          ctExpand: ctExpandTraining,
                          enomExpand: enomExpandTraining,
                          rftExpand: rftExpandTraining,
                          seExpand: seExpandTraining,
                          ssExpand: ssExpandTraining,
                          currentExpand: trainingExpand,
                        ),
                      if (widget.trainingData.isNotEmpty &&
                          widget.coolDownData.isNotEmpty)
                        Container(
                            width: 2.5,
                            height: 55,
                            color: AppColor.borderBrandDarkColor),
                      if (widget.coolDownData.isNotEmpty)
                        ProgressBarWidget(
                          currentList: widget.coolDownData,
                          current: widget.coolDownBody?.toInt() ?? -1,
                          amrapExpand: amrapExpandCoolDown,
                          crExpand: crExpandCoolDown,
                          ctExpand: ctExpandCoolDown,
                          enomExpand: enomExpandCoolDown,
                          rftExpand: rftExpandCoolDown,
                          seExpand: seExpandCoolDown,
                          ssExpand: ssExpandCoolDown,
                          currentExpand: coolDownExpand,
                        ),
                      30.height(),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(children: [
                    if (widget.warmUpData.isNotEmpty)
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            children: [
                              BuildHeader(
                                loaderListenAble: ValueNotifier(false),
                                dataLIst: widget.warmUpData,
                                title: "Warmup",
                                expandHeaderValueListenable: warmUpExpand,
                                onTap: () {
                                  warmUpExpand.value = !warmUpExpand.value;
                                },
                              ),
                              BuildBodyWidgetInOverview(
                                goHereTap: widget.goHereTapWarmUp,
                                showTrailing: widget.goHereTapWarmUp != null
                                    ? true
                                    : false,
                                amrapExpand: amrapExpandWarmup,
                                crExpand: crExpandWarmup,
                                ctExpand: ctExpandWarmup,
                                currentListData: widget.warmUpData,
                                emomExpand: enomExpandWarmup,
                                expandHeaderValueListenable: warmUpExpand,
                                rftExpand: rftExpandWarmup,
                                seExpand: seExpandWarmup,
                                ssExpand: ssExpandWarmup,
                              )
                            ],
                          )),
                    if (widget.trainingData.isNotEmpty)
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            children: [
                              BuildHeader(
                                loaderListenAble: ValueNotifier(false),
                                dataLIst: widget.trainingData,
                                title: "Training",
                                expandHeaderValueListenable: trainingExpand,
                                onTap: () {
                                  trainingExpand.value = !trainingExpand.value;
                                },
                              ),
                              BuildBodyWidgetInOverview(
                                goHereTap: widget.goHereTapTraining,
                                showTrailing: widget.goHereTapTraining != null
                                    ? true
                                    : false,
                                amrapExpand: amrapExpandTraining,
                                crExpand: crExpandTraining,
                                ctExpand: ctExpandTraining,
                                currentListData: widget.trainingData,
                                emomExpand: enomExpandTraining,
                                expandHeaderValueListenable: trainingExpand,
                                rftExpand: rftExpandTraining,
                                seExpand: seExpandTraining,
                                ssExpand: ssExpandTraining,
                              )
                            ],
                          )),
                    if (widget.coolDownData.isNotEmpty)
                      Column(
                        children: [
                          BuildHeader(
                            loaderListenAble: ValueNotifier(false),
                            dataLIst: widget.coolDownData,
                            title: "Cooldown",
                            expandHeaderValueListenable: coolDownExpand,
                            onTap: () {
                              coolDownExpand.value = !coolDownExpand.value;
                            },
                          ),
                          BuildBodyWidgetInOverview(
                            showTrailing:
                                widget.goHereTapCoolDown != null ? true : false,
                            goHereTap: widget.goHereTapCoolDown,
                            amrapExpand: amrapExpandCoolDown,
                            crExpand: crExpandCoolDown,
                            ctExpand: ctExpandCoolDown,
                            currentListData: widget.coolDownData,
                            emomExpand: enomExpandCoolDown,
                            expandHeaderValueListenable: coolDownExpand,
                            rftExpand: rftExpandCoolDown,
                            seExpand: seExpandCoolDown,
                            ssExpand: ssExpandCoolDown,
                          )
                        ],
                      )
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget(
      {super.key,
      required this.currentList,
      required this.current,
      required this.ctExpand,
      required this.crExpand,
      required this.seExpand,
      required this.rftExpand,
      required this.ssExpand,
      required this.amrapExpand,
      required this.enomExpand,
      required this.currentExpand});
  final Map<ExerciseDetailModel, ExerciseModel> currentList;
  final int current;
  final ValueNotifier<bool> currentExpand;

  final ValueNotifier<bool> ctExpand;
  final ValueNotifier<bool> crExpand;
  final ValueNotifier<bool> seExpand;
  final ValueNotifier<bool> rftExpand;
  final ValueNotifier<bool> ssExpand;
  final ValueNotifier<bool> amrapExpand;
  final ValueNotifier<bool> enomExpand;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const StepWidget(),
      ValueListenableBuilder<bool>(
          valueListenable: currentExpand,
          builder: (_, value, child) {
            return ExpandedSection(
              expand: value,
              child: Column(
                children: [
                  const LineWidget(
                    height: 70,
                  ),
                  SizedBox(
                    width: 25,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: currentList.length,
                      itemBuilder: (context, i) {
                        return currentList.keys
                                    .toList()[i]
                                    .exerciseCategoryName ==
                                ItemType.singleExercise
                            ? Column(
                                children: [
                                  headerCheckWidget(
                                      i: i, header2Expand: seExpand),
                                  ValueListenableBuilder<bool>(
                                      valueListenable: seExpand,
                                      builder: (_, value, child) {
                                        return ExpandedSection(
                                          expand: value,
                                          child: Column(
                                            children: [
                                              if (i == 0)
                                                LineWidget(
                                                    height:
                                                        context.dynamicHeight *
                                                            0.065),
                                              StepWidget(
                                                isActive: i == current,
                                              ),
                                              if (i != currentList.length - 1 &&
                                                  currentList.entries
                                                          .toList()[i]
                                                          .key
                                                          .exerciseCategoryName ==
                                                      currentList.entries
                                                          .toList()[i + 1]
                                                          .key
                                                          .exerciseCategoryName)
                                                Container(
                                                    width: 2.5,
                                                    height: 70,
                                                    color: AppColor
                                                        .borderBrandDarkColor)
                                            ],
                                          ),
                                        );
                                      }),
                                ],
                              )
                            : currentList.keys
                                        .toList()[i]
                                        .exerciseCategoryName ==
                                    ItemType.circuitTime
                                ? Column(
                                    children: [
                                      headerCheckWidget(
                                          i: i, header2Expand: ctExpand),
                                      ValueListenableBuilder<bool>(
                                          valueListenable: ctExpand,
                                          builder: (_, value, child) {
                                            return ExpandedSection(
                                              expand: value,
                                              child: Column(
                                                children: [
                                                  if (i == 0)
                                                    LineWidget(
                                                      height: context
                                                              .dynamicHeight *
                                                          0.09,
                                                    ),
                                                  StepWidget(
                                                    isActive: i == current,
                                                  ),
                                                  roundCheckWidget(
                                                    i: i,
                                                  ),
                                                  if (i !=
                                                          currentList.length -
                                                              1 &&
                                                      currentList.entries
                                                              .toList()[i]
                                                              .key
                                                              .exerciseCategoryName ==
                                                          currentList.entries
                                                              .toList()[i + 1]
                                                              .key
                                                              .exerciseCategoryName)
                                                    Container(
                                                        width: 2.5,
                                                        height: 70,
                                                        color: AppColor
                                                            .borderBrandDarkColor)
                                                ],
                                              ),
                                            );
                                          }),
                                    ],
                                  )
                                : currentList.keys
                                            .toList()[i]
                                            .exerciseCategoryName ==
                                        ItemType.circuitRep
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          headerCheckWidget(
                                              i: i, header2Expand: crExpand),
                                          ValueListenableBuilder<bool>(
                                              valueListenable: crExpand,
                                              builder: (_, value, child) {
                                                return ExpandedSection(
                                                  expand: value,
                                                  child: Column(
                                                    children: [
                                                      if (i == 0)
                                                        LineWidget(
                                                          height: context
                                                                  .dynamicHeight *
                                                              0.09,
                                                        ),
                                                      StepWidget(
                                                        isActive: i == current,
                                                      ),
                                                      roundCheckWidget(
                                                        i: i,
                                                      ),
                                                      if (i !=
                                                              currentList
                                                                      .length -
                                                                  1 &&
                                                          currentList.entries
                                                                  .toList()[i]
                                                                  .key
                                                                  .exerciseCategoryName ==
                                                              currentList
                                                                  .entries
                                                                  .toList()[
                                                                      i + 1]
                                                                  .key
                                                                  .exerciseCategoryName)
                                                        Container(
                                                            width: 2.5,
                                                            height: 70,
                                                            color: AppColor
                                                                .borderBrandDarkColor)
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ],
                                      )
                                    : currentList.keys
                                                .toList()[i]
                                                .exerciseCategoryName ==
                                            ItemType.rft
                                        ? Column(
                                            children: [
                                              headerCheckWidget(
                                                i: i,
                                                header2Expand: rftExpand,
                                              ),
                                              ValueListenableBuilder<bool>(
                                                  valueListenable: rftExpand,
                                                  builder: (_, value, child) {
                                                    return ExpandedSection(
                                                      expand: value,
                                                      child: Column(
                                                        children: [
                                                          if (i == 0)
                                                            LineWidget(
                                                              height: context
                                                                      .dynamicHeight *
                                                                  0.09,
                                                            ),
                                                          StepWidget(
                                                            isActive:
                                                                i == current,
                                                          ),
                                                          roundCheckWidget(
                                                            i: i,
                                                          ),
                                                          if (i !=
                                                                  currentList
                                                                          .length -
                                                                      1 &&
                                                              currentList
                                                                      .entries
                                                                      .toList()[
                                                                          i]
                                                                      .key
                                                                      .exerciseCategoryName ==
                                                                  currentList
                                                                      .entries
                                                                      .toList()[
                                                                          i + 1]
                                                                      .key
                                                                      .exerciseCategoryName)
                                                            Container(
                                                                width: 2.5,
                                                                height: 70,
                                                                color: AppColor
                                                                    .borderBrandDarkColor)
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ],
                                          )
                                        : currentList.keys
                                                    .toList()[i]
                                                    .exerciseCategoryName ==
                                                ItemType.superSet
                                            ? Column(
                                                children: [
                                                  headerCheckWidget(
                                                    i: i,
                                                    header2Expand: ssExpand,
                                                  ),
                                                  ValueListenableBuilder<bool>(
                                                      valueListenable: ssExpand,
                                                      builder:
                                                          (_, value, child) {
                                                        return ExpandedSection(
                                                          expand: value,
                                                          child: Column(
                                                            children: [
                                                              if (i == 0)
                                                                LineWidget(
                                                                  height: context
                                                                          .dynamicHeight *
                                                                      0.09,
                                                                ),
                                                              StepWidget(
                                                                isActive: i ==
                                                                    current,
                                                              ),
                                                              roundCheckWidget(
                                                                i: i,
                                                              ),
                                                              if (i !=
                                                                      currentList
                                                                              .length -
                                                                          1 &&
                                                                  currentList
                                                                          .entries
                                                                          .toList()[
                                                                              i]
                                                                          .key
                                                                          .exerciseCategoryName ==
                                                                      currentList
                                                                          .entries
                                                                          .toList()[i +
                                                                              1]
                                                                          .key
                                                                          .exerciseCategoryName)
                                                                Container(
                                                                    width: 2.5,
                                                                    height: 70,
                                                                    color: AppColor
                                                                        .borderBrandDarkColor)
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                ],
                                              )
                                            : currentList.keys
                                                        .toList()[i]
                                                        .exerciseCategoryName ==
                                                    ItemType.amrap
                                                ? Column(
                                                    children: [
                                                      headerCheckWidget(
                                                        i: i,
                                                        header2Expand:
                                                            amrapExpand,
                                                      ),
                                                      ValueListenableBuilder<
                                                              bool>(
                                                          valueListenable:
                                                              amrapExpand,
                                                          builder: (_, value,
                                                              child) {
                                                            return ExpandedSection(
                                                              expand: value,
                                                              child: Column(
                                                                children: [
                                                                  if (i == 0)
                                                                    LineWidget(
                                                                      height: context
                                                                              .dynamicHeight *
                                                                          0.09,
                                                                    ),
                                                                  StepWidget(
                                                                    isActive: i ==
                                                                        current,
                                                                  ),
                                                                  roundCheckWidget(
                                                                    i: i,
                                                                  ),
                                                                  if (i !=
                                                                          currentList.length -
                                                                              1 &&
                                                                      currentList
                                                                              .entries
                                                                              .toList()[
                                                                                  i]
                                                                              .key
                                                                              .exerciseCategoryName ==
                                                                          currentList
                                                                              .entries
                                                                              .toList()[i +
                                                                                  1]
                                                                              .key
                                                                              .exerciseCategoryName)
                                                                    Container(
                                                                        width:
                                                                            2.5,
                                                                        height:
                                                                            70,
                                                                        color: AppColor
                                                                            .borderBrandDarkColor)
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                    ],
                                                  )
                                                : currentList.keys
                                                            .toList()[i]
                                                            .exerciseCategoryName ==
                                                        ItemType.enom
                                                    ? Column(
                                                        children: [
                                                          headerCheckWidget(
                                                            i: i,
                                                            header2Expand:
                                                                enomExpand,
                                                          ),
                                                          ValueListenableBuilder<
                                                                  bool>(
                                                              valueListenable:
                                                                  enomExpand,
                                                              builder: (_,
                                                                  value,
                                                                  child) {
                                                                return ExpandedSection(
                                                                  expand: value,
                                                                  child: Column(
                                                                    children: [
                                                                      if (i ==
                                                                          0)
                                                                        LineWidget(
                                                                          height:
                                                                              context.dynamicHeight * 0.09,
                                                                        ),
                                                                      StepWidget(
                                                                        isActive:
                                                                            i ==
                                                                                current,
                                                                      ),
                                                                      roundCheckWidget(
                                                                        i: i,
                                                                      ),
                                                                      if (i != currentList.length - 1 && currentList.entries.toList()[i].key.exerciseCategoryName == currentList.entries.toList()[i + 1].key.exerciseCategoryName)
                                                                        Container(
                                                                            width:
                                                                                2.5,
                                                                            height:
                                                                                70,
                                                                            color:
                                                                                AppColor.borderBrandDarkColor)
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                        ],
                                                      )
                                                    : Container();
                      },
                    ),
                  )
                ],
              ),
            );
          })
    ]);
  }

  StatelessWidget roundCheckWidget({
    required int i,
  }) {
    return i == 0
        ? Container()
        : i == currentList.length - 1
            ? Container()
            : currentList.entries.toList()[i].key.setsCount !=
                        currentList.entries.toList()[i + 1].key.setsCount &&
                    currentList.entries.toList()[i].key.exerciseCategoryName ==
                        currentList.entries
                            .toList()[i + 1]
                            .key
                            .exerciseCategoryName
                ? Container(
                    width: 2.5,
                    height: 10,
                    color: AppColor.borderBrandDarkColor,
                  )
                : Container();
  }

  Widget headerCheckWidget(
      {required int i, required ValueNotifier<bool> header2Expand}) {
    return i == 0
        ? const StepWidget()
        : i == currentList.length - 1
            ? Container()
            : currentList.entries.toList()[i].key.exerciseCategoryName !=
                    currentList.entries.toList()[i - 1].key.exerciseCategoryName
                ? Column(
                    children: [
                      Container(
                          width: 2.5,
                          height: 80,
                          color: AppColor.borderBrandDarkColor),
                      const StepWidget(),
                      ValueListenableBuilder<bool>(
                          valueListenable: header2Expand,
                          builder: (_, value, child) {
                            return ExpandedSection(
                              expand: value,
                              child: Center(
                                child: Container(
                                    width: 2.5,
                                    height: currentList.entries
                                                .toList()[i]
                                                .key
                                                .exerciseCategoryName ==
                                            ItemType.singleExercise
                                        ? 90
                                        : 115,
                                    color: AppColor.borderBrandDarkColor),
                              ),
                            );
                          }),
                    ],
                  )
                : Container();
  }
}

class BuildBodyWidgetInOverview extends StatelessWidget {
  BuildBodyWidgetInOverview({
    super.key,
    required this.currentListData,
    this.goHereTap,
    this.showTrailing = false,
    required this.expandHeaderValueListenable,
    required this.ctExpand,
    required this.crExpand,
    required this.seExpand,
    required this.rftExpand,
    required this.ssExpand,
    required this.amrapExpand,
    required this.emomExpand,
  });
  final Map<ExerciseDetailModel, ExerciseModel> currentListData;

  final bool showTrailing;

  final ValueNotifier<bool> expandHeaderValueListenable;
  final void Function(int)? goHereTap;

  final ValueNotifier<bool> ctExpand;

  final ValueNotifier<bool> crExpand;

  final ValueNotifier<bool> seExpand;

  final ValueNotifier<bool> rftExpand;

  final ValueNotifier<bool> ssExpand;

  final ValueNotifier<bool> amrapExpand;

  final ValueNotifier<bool> emomExpand;

  Map<ExerciseDetailModel, ExerciseModel> seExercise = {};

  Map<ExerciseDetailModel, ExerciseModel> circuitTimeExercise = {};

  Map<ExerciseDetailModel, ExerciseModel> rftExercise = {};

  Map<ExerciseDetailModel, ExerciseModel> ssExercise = {};

  Map<ExerciseDetailModel, ExerciseModel> circuitRepExercise = {};

  Map<ExerciseDetailModel, ExerciseModel> amrapExercise = {};

  Map<ExerciseDetailModel, ExerciseModel> enomExercise = {};

  addData() {
    for (var element in currentListData.entries) {
      if (element.key.exerciseCategoryName == ItemType.circuitTime) {
        circuitTimeExercise.addEntries({element});
      }
      if (element.key.exerciseCategoryName == ItemType.rft) {
        rftExercise.addEntries({element});
      }
      if (element.key.exerciseCategoryName == ItemType.singleExercise) {
        seExercise.addEntries({element});
      }
      if (element.key.exerciseCategoryName == ItemType.superSet) {
        ssExercise.addEntries({element});
      }
      if (element.key.exerciseCategoryName == ItemType.amrap) {
        amrapExercise.addEntries({element});
      }
      if (element.key.exerciseCategoryName == ItemType.circuitRep) {
        circuitRepExercise.addEntries({element});
      }
      if (element.key.exerciseCategoryName == ItemType.enom) {
        enomExercise.addEntries({element});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      color: AppColor.surfaceBackgroundColor,
      child: ValueListenableBuilder(
          valueListenable: expandHeaderValueListenable,
          builder: (_, value, child) {
            return ExpandedSection(
                expand: value,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: currentListData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        addData();
                      }
                      return currentListData.keys
                                  .toList()[index]
                                  .exerciseCategoryName ==
                              ItemType.circuitTime
                          ? Column(
                              children: [
                                header2CheckWidget(
                                    index: index, expandVar: ctExpand),
                                ValueListenableBuilder<bool>(
                                    valueListenable: ctExpand,
                                    builder: (context, value, child) {
                                      return ExpandedSection(
                                        expand: value,
                                        child: Column(children: [
                                          roundCheckWidget(index),
                                          showExerciseTileWidget(
                                            context,
                                            currentListData,
                                            index,
                                          ),
                                          cutomDiviDerWidget(index)
                                        ]),
                                      );
                                    })
                              ],
                            )
                          : currentListData.keys
                                      .toList()[index]
                                      .exerciseCategoryName ==
                                  ItemType.singleExercise
                              ? Column(
                                  children: [
                                    header2CheckWidget(
                                        index: index, expandVar: seExpand),
                                    ValueListenableBuilder<bool>(
                                        valueListenable: seExpand,
                                        builder: (context, value, child) {
                                          return ExpandedSection(
                                            expand: value,
                                            child: Column(children: [
                                              // roundCheckWidget(index),
                                              12.height(),
                                              showExerciseTileWidget(
                                                context,
                                                currentListData,
                                                index,
                                              ),
                                              cutomDiviDerWidget(index)
                                            ]),
                                          );
                                        })
                                  ],
                                )
                              : currentListData.keys
                                          .toList()[index]
                                          .exerciseCategoryName ==
                                      ItemType.superSet
                                  ? Column(
                                      children: [
                                        header2CheckWidget(
                                            index: index, expandVar: ssExpand),
                                        ValueListenableBuilder<bool>(
                                            valueListenable: ssExpand,
                                            builder: (context, value, child) {
                                              return ExpandedSection(
                                                expand: value,
                                                child: Column(children: [
                                                  roundCheckWidget(index),
                                                  showExerciseTileWidget(
                                                    context,
                                                    currentListData,
                                                    index,
                                                  ),
                                                  cutomDiviDerWidget(index)
                                                ]),
                                              );
                                            })
                                      ],
                                    )
                                  : currentListData.keys
                                              .toList()[index]
                                              .exerciseCategoryName ==
                                          ItemType.circuitRep
                                      ? Column(
                                          children: [
                                            header2CheckWidget(
                                                index: index,
                                                expandVar: crExpand),
                                            ValueListenableBuilder<bool>(
                                                valueListenable: crExpand,
                                                builder:
                                                    (context, value, child) {
                                                  return ExpandedSection(
                                                    expand: value,
                                                    child: Column(children: [
                                                      roundCheckWidget(index),
                                                      showExerciseTileWidget(
                                                        context,
                                                        currentListData,
                                                        index,
                                                      ),
                                                      cutomDiviDerWidget(index)
                                                    ]),
                                                  );
                                                })
                                          ],
                                        )
                                      : currentListData.keys
                                                  .toList()[index]
                                                  .exerciseCategoryName ==
                                              ItemType.rft
                                          ? Column(
                                              children: [
                                                header2CheckWidget(
                                                    index: index,
                                                    expandVar: rftExpand),
                                                ValueListenableBuilder<bool>(
                                                    valueListenable: rftExpand,
                                                    builder: (context, value,
                                                        child) {
                                                      return ExpandedSection(
                                                        expand: value,
                                                        child:
                                                            Column(children: [
                                                          roundCheckWidget(
                                                              index),
                                                          showExerciseTileWidget(
                                                            context,
                                                            currentListData,
                                                            index,
                                                          ),
                                                          cutomDiviDerWidget(
                                                              index)
                                                        ]),
                                                      );
                                                    })
                                              ],
                                            )
                                          : currentListData.keys
                                                      .toList()[index]
                                                      .exerciseCategoryName ==
                                                  ItemType.enom
                                              ? Column(
                                                  children: [
                                                    header2CheckWidget(
                                                        index: index,
                                                        expandVar: emomExpand),
                                                    ValueListenableBuilder<
                                                            bool>(
                                                        valueListenable:
                                                            emomExpand,
                                                        builder: (context,
                                                            value, child) {
                                                          return ExpandedSection(
                                                            expand: value,
                                                            child: Column(
                                                                children: [
                                                                  roundCheckWidget(
                                                                      index),
                                                                  showExerciseTileWidget(
                                                                    context,
                                                                    currentListData,
                                                                    index,
                                                                  ),
                                                                  cutomDiviDerWidget(
                                                                      index)
                                                                ]),
                                                          );
                                                        })
                                                  ],
                                                )
                                              : currentListData.keys
                                                          .toList()[index]
                                                          .exerciseCategoryName ==
                                                      ItemType.amrap
                                                  ? Column(
                                                      children: [
                                                        header2CheckWidget(
                                                            index: index,
                                                            expandVar:
                                                                emomExpand),
                                                        ValueListenableBuilder<
                                                                bool>(
                                                            valueListenable:
                                                                amrapExpand,
                                                            builder: (context,
                                                                value, child) {
                                                              return ExpandedSection(
                                                                expand: value,
                                                                child: Column(
                                                                    children: [
                                                                      roundCheckWidget(
                                                                          index),
                                                                      showExerciseTileWidget(
                                                                        context,
                                                                        currentListData,
                                                                        index,
                                                                      ),
                                                                      cutomDiviDerWidget(
                                                                          index)
                                                                    ]),
                                                              );
                                                            })
                                                      ],
                                                    )
                                                  : Container();
                    }));
          }),
    );
  }

  header2CheckWidget(
      {required int index,

      // required String subtitle,
      required ValueNotifier<bool> expandVar}) {
    return index == 0
        ? BuildHeader2(
            subtitle: currentListData.currentHeaderSubTitle(
              index: index,
              amrapExercise: amrapExercise,
              circuitRepExercise: circuitRepExercise,
              circuitTimeExercise: circuitTimeExercise,
              enomExercise: enomExercise,
              rftExercise: rftExercise,
              seExercise: seExercise,
              ssExercise: ssExercise,
            ),
            expandValueListenable: expandVar,
            exerciseWorkoutData:
                WorkoutDetailController.addCurrentList(index, currentListData),
            title: currentListData.currentHeaderTitle(index),
            onExpand: () {
              expandVar.value = !expandVar.value;
              // setState(() {});
            })
        : index == currentListData.length - 1
            ? Container()
            : currentListData.entries
                        .toList()[index]
                        .key
                        .exerciseCategoryName !=
                    currentListData.entries
                        .toList()[index - 1]
                        .key
                        .exerciseCategoryName
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: BuildHeader2(
                        subtitle: currentListData.currentHeaderSubTitle(
                          index: index,
                          amrapExercise: amrapExercise,
                          circuitRepExercise: circuitRepExercise,
                          circuitTimeExercise: circuitTimeExercise,
                          enomExercise: enomExercise,
                          rftExercise: rftExercise,
                          seExercise: seExercise,
                          ssExercise: ssExercise,
                        ),
                        expandValueListenable: expandVar,
                        exerciseWorkoutData:
                            WorkoutDetailController.addCurrentList(
                                index, currentListData),
                        title: currentListData.currentHeaderTitle(index),
                        onExpand: () {
                          expandVar.value = !expandVar.value;
                          // setState(() {});
                        }),
                  )
                : Container();
  }

  StatelessWidget roundCheckWidget(int i) {
    return i == 0
        ? RoundWidget(
            i: i,
            listData: currentListData,
          )
        : i == currentListData.length - 1
            ? Container()
            : currentListData.entries.toList()[i].key.setsCount !=
                    currentListData.entries.toList()[i - 1].key.setsCount
                ? RoundWidget(
                    i: i,
                    listData: currentListData,
                  )
                : Container();
  }

  StatelessWidget cutomDiviDerWidget(int i) {
    return i == 0
        ? const CustomDivider(
            indent: 130,
            endIndent: 20,
          )
        : i == currentListData.length - 1
            ? Container()
            : currentListData.entries.toList()[i + 1].key.setsCount !=
                    currentListData.entries.toList()[i].key.setsCount
                ? Container()
                : const CustomDivider(
                    indent: 130,
                    endIndent: 20,
                  );
  }

  Padding showExerciseTileWidget(
    BuildContext context,
    Map<ExerciseDetailModel, ExerciseModel> dataList,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 40,
      ),
      child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Transform.scale(
            scale: 1.5,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: context.dynamicWidth * 0.12,
                child: cacheNetworkWidget(
                    imageUrl:
                        dataList.values.toList()[index].mapImage?.url ?? ""),
              ),
            ),
          ),
          title: Text(
            dataList.values.toList()[index].name,
            style: AppTypography.label16MD
                .copyWith(color: AppColor.textEmphasisColor),
          ),
          subtitle: Text(
              currentListData.keys.toList()[index].exerciseCategoryName ==
                      ItemType.singleExercise
                  ? "${currentListData.keys.toList()[index].getGoalAndResistantTargets} • ${currentListData.keys.toList()[index].setsCount} sets"
                  : currentListData.keys
                      .toList()[index]
                      .getGoalAndResistantTargets,
              style: AppTypography.paragraph14MD.copyWith(
                color: AppColor.textPrimaryColor,
              )),
          trailing: showTrailing == true
              ? PopupMenuButton(
                  onSelected: (value) {
                    if (value == 1) {
                      showModalBottomSheet(
                          isDismissible: false,
                          isScrollControlled: true,
                          useSafeArea: true,
                          backgroundColor: AppColor.surfaceBackgroundBaseColor,
                          context: context,
                          builder: (context) => DetailWorkoutBottomSheet(
                              exerciseModel: dataList.values.toList()[index]));
                      // context.navigateTo(DetailExerciseBottomSheet(
                      //     exerciseModel: warmupListData[index]));
                    } else if (value == 2) {
                      if (goHereTap != null) {
                        goHereTap!(index);
                      }
                    }
                  },
                  padding: const EdgeInsets.all(16),
                  constraints: const BoxConstraints(minWidth: 250),
                  elevation: 15,
                  offset: const Offset(-10, 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: AppColor.surfaceBackgroundBaseColor,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Show info',
                                style: AppTypography.label16MD.copyWith(
                                  color: AppColor.textEmphasisColor,
                                )),
                            SvgPicture.asset(AppAssets.infoIcon),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Go here',
                                style: AppTypography.label16MD.copyWith(
                                  color: AppColor.textEmphasisColor,
                                )),
                            SvgPicture.asset(AppAssets.returnIcon),
                          ],
                        ),
                      )
                    ];
                  },
                  child: SvgPicture.asset(
                    AppAssets.horizontalVertIcon,
                    color: AppColor.surfaceBrandDarkColor,
                  ))
              : null),
    );
  }
}

class LineWidget extends StatelessWidget {
  final double height;
  const LineWidget({super.key, this.height = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 2.5, height: height, color: AppColor.surfaceBrandDarkColor);
  }
}

class StepWidget extends StatelessWidget {
  final bool isActive;

  const StepWidget({
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
                color: isActive
                    ? AppColor.borderBrandDarkColor
                    : AppColor.textInvertEmphasis,
                border: Border.all(
                    color: AppColor.borderBrandDarkColor, width: 2.5)),
            child: isActive
                ? Transform.scale(
                    scale: 1.5,
                    child: Icon(
                      Icons.check,
                      size: 12,
                      color: AppColor.textInvertEmphasis,
                      weight: 2,
                      shadows: [
                        Shadow(
                            color: AppColor.textInvertEmphasis,
                            offset: const Offset(0, 0.1),
                            blurRadius: 30)
                      ],
                    ),
                  )
                : null),
      ],
    );
  }
}
