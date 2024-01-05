import 'package:flutter/material.dart';

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
  final bool warmupHeader, warmUpWorkoutComplete;
  final bool trainingHeaer, trainingWorkoutComplete;
  final bool coolDownHeader, coolDownWorkoutComplete;

  const OverviewBottomSheet(
      {super.key,
      required this.workoutModel,
      required this.warmUpData,
      required this.trainingData,
      required this.coolDownData,
      this.warmupBody,
      this.trainingBody,
      this.coolDownBody,
      required this.warmupHeader,
      this.goHereTapWarmUp,
      this.goHereTapTraining,
      this.goHereTapCoolDown,
      required this.trainingHeaer,
      required this.coolDownHeader,
      required this.warmUpWorkoutComplete,
      required this.trainingWorkoutComplete,
      required this.coolDownWorkoutComplete});

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
    return Column(
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
                decoration: const BoxDecoration(
                    color: Colors.transparent, shape: BoxShape.circle),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.transparent,
                ),
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                workoutCompleted: widget.warmupBody ==
                                    widget.warmUpData.length,
                                isActive: widget.warmupHeader,
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
                              const LineWidget(height: 95, color: Colors.black),
                            if (widget.trainingData.isNotEmpty)
                              ProgressBarWidget(
                                workoutCompleted: false,
                                isActive: true,
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
                              const LineWidget(
                                height: 55,
                              ),
                            if (widget.coolDownData.isNotEmpty)
                              ProgressBarWidget(
                                workoutCompleted: false,
                                isActive: widget.coolDownHeader,
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
                                        warmUpExpand.value =
                                            !warmUpExpand.value;
                                      },
                                    ),
                                    //       BuildBodyWidgetInOverview(
                                    //   goHereTap: widget.goHereTapWarmUp,
                                    //   showTrailing:
                                    //       widget.goHereTapWarmUp != null
                                    //           ? true
                                    //           : false,
                                    //   amrapExpand: amrapExpandWarmup,
                                    //   crExpand: crExpandWarmup,
                                    //   ctExpand: ctExpandWarmup,
                                    //   currentListData: widget.warmUpData,
                                    //   emomExpand: enomExpandWarmup,
                                    //   expandHeaderValueListenable: warmUpExpand,
                                    //   rftExpand: rftExpandWarmup,
                                    //   seExpand: seExpandWarmup,
                                    //   ssExpand: ssExpandWarmup,
                                    // ),
                                    BuildBodyWidget(
                                      goHereTap: widget.goHereTapWarmUp,
                                      showTrailing:
                                          widget.goHereTapWarmUp != null
                                              ? true
                                              : false,
                                      currentListData: widget.warmUpData,
                                      expandHeaderValueListenable: warmUpExpand,
                                      loaderValueListenable:
                                          ValueNotifier(false),
                                      amrapExpandNew: amrapExpandWarmup,
                                      crExpandNew: crExpandWarmup,
                                      ctExpandNew: ctExpandWarmup,
                                      enomExpandNew: enomExpandWarmup,
                                      rftExpandNew: rftExpandWarmup,
                                      seExpandNew: seExpandWarmup,
                                      ssExpandNew: ssExpandWarmup,
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
                                      expandHeaderValueListenable:
                                          trainingExpand,
                                      onTap: () {
                                        trainingExpand.value =
                                            !trainingExpand.value;
                                      },
                                    ),
                                    // BuildBodyWidgetInOverview(
                                    //   goHereTap: widget.goHereTapTraining,
                                    //   showTrailing:
                                    //       widget.goHereTapTraining != null
                                    //           ? true
                                    //           : false,
                                    //   amrapExpand: amrapExpandTraining,
                                    //   crExpand: crExpandTraining,
                                    //   ctExpand: ctExpandTraining,
                                    //   currentListData: widget.trainingData,
                                    //   emomExpand: enomExpandTraining,
                                    //   expandHeaderValueListenable:
                                    //       trainingExpand,
                                    //   rftExpand: rftExpandTraining,
                                    //   seExpand: seExpandTraining,
                                    //   ssExpand: ssExpandTraining,
                                    // ),

                                    BuildBodyWidget(
                                      goHereTap: widget.goHereTapTraining,
                                      showTrailing:
                                          widget.goHereTapTraining != null
                                              ? true
                                              : false,
                                      currentListData: widget.trainingData,
                                      expandHeaderValueListenable:
                                          trainingExpand,
                                      loaderValueListenable:
                                          ValueNotifier(false),
                                      amrapExpandNew: amrapExpandTraining,
                                      crExpandNew: crExpandTraining,
                                      ctExpandNew: ctExpandTraining,
                                      enomExpandNew: enomExpandTraining,
                                      rftExpandNew: rftExpandTraining,
                                      seExpandNew: seExpandTraining,
                                      ssExpandNew: ssExpandTraining,
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
                                    coolDownExpand.value =
                                        !coolDownExpand.value;
                                  },
                                ),
                                // BuildBodyWidgetInOverview(
                                //   showTrailing: widget.goHereTapCoolDown != null
                                //       ? true
                                //       : false,
                                //   goHereTap: widget.goHereTapCoolDown,
                                //   amrapExpand: amrapExpandCoolDown,
                                //   crExpand: crExpandCoolDown,
                                //   ctExpand: ctExpandCoolDown,
                                //   currentListData: widget.coolDownData,
                                //   emomExpand: enomExpandCoolDown,
                                //   expandHeaderValueListenable: coolDownExpand,
                                //   rftExpand: rftExpandCoolDown,
                                //   seExpand: seExpandCoolDown,
                                //   ssExpand: ssExpandCoolDown,
                                // ),
                                BuildBodyWidget(
                                  showTrailing: widget.goHereTapCoolDown != null
                                      ? true
                                      : false,
                                  goHereTap: widget.goHereTapCoolDown,
                                  currentListData: widget.coolDownData,
                                  expandHeaderValueListenable: coolDownExpand,
                                  loaderValueListenable: ValueNotifier(false),
                                  amrapExpandNew: amrapExpandCoolDown,
                                  crExpandNew: crExpandCoolDown,
                                  ctExpandNew: ctExpandCoolDown,
                                  enomExpandNew: enomExpandCoolDown,
                                  rftExpandNew: rftExpandCoolDown,
                                  seExpandNew: seExpandCoolDown,
                                  ssExpandNew: ssExpandCoolDown,
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
          ),
        )
      ],
    );
  }
}

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget(
      {super.key,
      required this.isActive,
      required this.currentList,
      required this.current,
      required this.ctExpand,
      required this.crExpand,
      required this.seExpand,
      required this.rftExpand,
      required this.ssExpand,
      required this.amrapExpand,
      required this.enomExpand,
      required this.currentExpand,
      required this.workoutCompleted});
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
  final bool isActive, workoutCompleted;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StepWidget(
        isActive: workoutCompleted ? false : isActive,
        isCompleted: workoutCompleted,
      ),
      ValueListenableBuilder<bool>(
          valueListenable: currentExpand,
          builder: (_, value, child) {
            return ExpandedSection(
              expand: value,
              child: Column(
                children: [
                  LineWidget(
                      height: 65,
                      color: workoutCompleted
                          ? AppColor.borderBrandDarkColor
                          : isActive == true
                              ? AppColor.borderBrandDarkColor
                              : null),
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
                                                  height: 65,
                                                  color: workoutCompleted
                                                      ? AppColor
                                                          .surfaceBrandDarkColor
                                                      : current >= i
                                                          ? AppColor
                                                              .borderBrandDarkColor
                                                          : null,
                                                ),
                                              StepWidget(
                                                isActive: workoutCompleted
                                                    ? false
                                                    : i == current,
                                                isCompleted: workoutCompleted
                                                    ? true
                                                    : current > i,
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
                                                LineWidget(
                                                  height: 70,
                                                  color: workoutCompleted
                                                      ? AppColor
                                                          .surfaceBrandDarkColor
                                                      : current > i
                                                          ? AppColor
                                                              .surfaceBrandDarkColor
                                                          : null,
                                                ),
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
                                                      height: 90,
                                                      color: workoutCompleted
                                                          ? AppColor
                                                              .surfaceBrandDarkColor
                                                          : current >= i
                                                              ? AppColor
                                                                  .borderBrandDarkColor
                                                              : null,
                                                    ),
                                                  StepWidget(
                                                    isActive: workoutCompleted
                                                        ? false
                                                        : i == current,
                                                    isCompleted:
                                                        workoutCompleted
                                                            ? true
                                                            : current > i,
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
                                                    LineWidget(
                                                      height: 70,
                                                      color: workoutCompleted
                                                          ? AppColor
                                                              .surfaceBrandDarkColor
                                                          : current > i
                                                              ? AppColor
                                                                  .surfaceBrandDarkColor
                                                              : null,
                                                    ),
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
                                                        const LineWidget(
                                                            height: 90),
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
                                                        const LineWidget(
                                                          height: 70,
                                                        ),
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
                                                            const LineWidget(
                                                                height: 65),
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
                                                            const LineWidget(
                                                              height: 70,
                                                            ),
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
                                                                const LineWidget(
                                                                    height: 90),
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
                                                                const LineWidget(
                                                                  height: 70,
                                                                ),
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
                                                                    const LineWidget(
                                                                        height:
                                                                            90),
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
                                                                              .toList()[i + 1]
                                                                              .key
                                                                              .exerciseCategoryName)
                                                                    const LineWidget(
                                                                      height:
                                                                          70,
                                                                    ),
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
                                                                        const LineWidget(
                                                                            height:
                                                                                90),
                                                                      StepWidget(
                                                                        isActive:
                                                                            i ==
                                                                                current,
                                                                      ),
                                                                      roundCheckWidget(
                                                                        i: i,
                                                                      ),
                                                                      if (i != currentList.length - 1 &&
                                                                          currentList.entries.toList()[i].key.exerciseCategoryName ==
                                                                              currentList.entries.toList()[i + 1].key.exerciseCategoryName)
                                                                        const LineWidget(
                                                                          height:
                                                                              70,
                                                                        ),
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
                ? LineWidget(
                    height: 10,
                    color:
                        isActive == true ? AppColor.borderBrandDarkColor : null,
                  )
                : Container();
  }

  Widget headerCheckWidget(
      {required int i, required ValueNotifier<bool> header2Expand}) {
    return i == 0
        ? StepWidget(
            isActive: workoutCompleted ? false : isActive,
            isCompleted: workoutCompleted,
          )
        : i == currentList.length - 1
            ? Container()
            : currentList.entries.toList()[i].key.exerciseCategoryName !=
                    currentList.entries.toList()[i - 1].key.exerciseCategoryName
                ? Column(
                    children: [
                      LineWidget(
                        height: 80,
                      ),
                      const StepWidget(),
                      ValueListenableBuilder<bool>(
                          valueListenable: header2Expand,
                          builder: (_, value, child) {
                            return ExpandedSection(
                              expand: value,
                              child: Center(
                                  child: LineWidget(
                                height: currentList.entries
                                            .toList()[i]
                                            .key
                                            .exerciseCategoryName ==
                                        ItemType.singleExercise
                                    ? 90
                                    : 115,
                              )),
                            );
                          }),
                    ],
                  )
                : Container();
  }
}

class LineWidget extends StatelessWidget {
  final double height;
  final Color? color;
  const LineWidget({super.key, this.height = 40, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 3.5,
        height: height,
        color: color ?? AppColor.borderSecondaryColor);
  }
}

class StepWidget extends StatelessWidget {
  final bool isActive;
  final bool isCompleted;
  const StepWidget({
    super.key,
    this.isActive = false,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? AppColor.textInvertEmphasis
                    : isCompleted
                        ? AppColor.borderBrandDarkColor
                        : AppColor.borderSecondaryColor,
                border: Border.all(
                    color: isActive
                        ? AppColor.borderBrandDarkColor
                        : isCompleted
                            ? AppColor.borderBrandDarkColor
                            : AppColor.borderSecondaryColor,
                    width: 3.5)),
            child: isCompleted
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
