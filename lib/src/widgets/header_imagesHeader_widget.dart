import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';
import 'detail_exercise_bottom_sheet_widget.dart';

class BuildBodyWidget extends StatefulWidget {
  const BuildBodyWidget({
    super.key,
    required this.currentListData,
    this.goHereTap,
    this.showTrailing = false,
    required this.expandHeaderValueListenable,
    required this.loaderValueListenable,
  });
  final Map<ExerciseDetailModel, ExerciseModel> currentListData;

  final ValueNotifier<bool> loaderValueListenable;

  final bool showTrailing;

  final ValueNotifier<bool> expandHeaderValueListenable;
  final void Function(int)? goHereTap;

  @override
  State<BuildBodyWidget> createState() => _BuildBodyWidgetState();
}

class _BuildBodyWidgetState extends State<BuildBodyWidget> {
  ValueNotifier<bool> ctExpand = ValueNotifier(true);
  ValueNotifier<bool> crExpand = ValueNotifier(true);
  ValueNotifier<bool> seExpand = ValueNotifier(true);
  ValueNotifier<bool> rftExpand = ValueNotifier(true);
  ValueNotifier<bool> ssExpand = ValueNotifier(true);
  ValueNotifier<bool> amrapExpand = ValueNotifier(true);
  ValueNotifier<bool> enomExpand = ValueNotifier(true);
  Map<ExerciseDetailModel, ExerciseModel> seExercise = {};
  Map<ExerciseDetailModel, ExerciseModel> circuitTimeExercise = {};
  Map<ExerciseDetailModel, ExerciseModel> rftExercise = {};
  Map<ExerciseDetailModel, ExerciseModel> ssExercise = {};
  Map<ExerciseDetailModel, ExerciseModel> circuitRepExercise = {};
  Map<ExerciseDetailModel, ExerciseModel> amrapExercise = {};
  Map<ExerciseDetailModel, ExerciseModel> enomExercise = {};

  addData() {
    for (var element in widget.currentListData.entries) {
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
          valueListenable: widget.expandHeaderValueListenable,
          builder: (_, value, child) {
            return ExpandedSection(
              expand: value,
              child: ValueListenableBuilder(
                valueListenable: widget.loaderValueListenable,
                builder: (_, value, child) {
                  return value == true
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: BaseHelper.loadingWidget(),
                          ),
                        )
                      : widget.currentListData.isEmpty
                          ? const Center(
                              child: Text('No Data'),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: widget.currentListData.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  addData();
                                }
                                return widget.currentListData.keys
                                            .toList()[index]
                                            .exerciseCategoryName ==
                                        ItemType.circuitTime
                                    ? Column(
                                        children: [
                                          header2CheckWidget(
                                              index: index,
                                              expandVar: ctExpand),
                                          ValueListenableBuilder<bool>(
                                              valueListenable: ctExpand,
                                              builder: (context, value, child) {
                                                return ExpandedSection(
                                                  expand: value,
                                                  child: Column(children: [
                                                    roundCheckWidget(index),
                                                    showExerciseTileWidget(
                                                      context,
                                                      widget.currentListData,
                                                      index,
                                                    ),
                                                    cutomDiviDerWidget(index)
                                                  ]),
                                                );
                                              })
                                        ],
                                      )
                                    : widget.currentListData.keys
                                                .toList()[index]
                                                .exerciseCategoryName ==
                                            ItemType.singleExercise
                                        ? Column(
                                            children: [
                                              header2CheckWidget(
                                                  index: index,
                                                  expandVar: seExpand),
                                              ValueListenableBuilder<bool>(
                                                  valueListenable: seExpand,
                                                  builder:
                                                      (context, value, child) {
                                                    return ExpandedSection(
                                                      expand: value,
                                                      child: Column(children: [
                                                        // roundCheckWidget(index),
                                                        12.height(),
                                                        showExerciseTileWidget(
                                                          context,
                                                          widget
                                                              .currentListData,
                                                          index,
                                                        ),
                                                        cutomDiviDerWidget(
                                                            index)
                                                      ]),
                                                    );
                                                  })
                                            ],
                                          )
                                        : widget.currentListData.keys
                                                    .toList()[index]
                                                    .exerciseCategoryName ==
                                                ItemType.superSet
                                            ? Column(
                                                children: [
                                                  header2CheckWidget(
                                                      index: index,
                                                      expandVar: ssExpand),
                                                  ValueListenableBuilder<bool>(
                                                      valueListenable: ssExpand,
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
                                                              widget
                                                                  .currentListData,
                                                              index,
                                                            ),
                                                            cutomDiviDerWidget(
                                                                index)
                                                          ]),
                                                        );
                                                      })
                                                ],
                                              )
                                            : widget.currentListData.keys
                                                        .toList()[index]
                                                        .exerciseCategoryName ==
                                                    ItemType.circuitRep
                                                ? Column(
                                                    children: [
                                                      header2CheckWidget(
                                                          index: index,
                                                          expandVar: crExpand),
                                                      ValueListenableBuilder<
                                                              bool>(
                                                          valueListenable:
                                                              crExpand,
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
                                                                      widget
                                                                          .currentListData,
                                                                      index,
                                                                    ),
                                                                    cutomDiviDerWidget(
                                                                        index)
                                                                  ]),
                                                            );
                                                          })
                                                    ],
                                                  )
                                                : widget.currentListData.keys
                                                            .toList()[index]
                                                            .exerciseCategoryName ==
                                                        ItemType.rft
                                                    ? Column(
                                                        children: [
                                                          header2CheckWidget(
                                                              index: index,
                                                              expandVar:
                                                                  rftExpand),
                                                          ValueListenableBuilder<
                                                                  bool>(
                                                              valueListenable:
                                                                  rftExpand,
                                                              builder: (context,
                                                                  value,
                                                                  child) {
                                                                return ExpandedSection(
                                                                  expand: value,
                                                                  child: Column(
                                                                      children: [
                                                                        // roundCheckWidget(
                                                                        //     index),
                                                                        12.height(),
                                                                        showExerciseTileWidget(
                                                                          context,
                                                                          widget
                                                                              .currentListData,
                                                                          index,
                                                                        ),
                                                                        cutomDiviDerWidget(
                                                                            index)
                                                                      ]),
                                                                );
                                                              })
                                                        ],
                                                      )
                                                    : widget.currentListData
                                                                .keys
                                                                .toList()[index]
                                                                .exerciseCategoryName ==
                                                            ItemType.enom
                                                        ? Column(
                                                            children: [
                                                              header2CheckWidget(
                                                                  index: index,
                                                                  expandVar:
                                                                      enomExpand),
                                                              ValueListenableBuilder<
                                                                      bool>(
                                                                  valueListenable:
                                                                      enomExpand,
                                                                  builder:
                                                                      (context,
                                                                          value,
                                                                          child) {
                                                                    return ExpandedSection(
                                                                      expand:
                                                                          value,
                                                                      child: Column(
                                                                          children: [
                                                                            roundCheckWidget(index),
                                                                            showExerciseTileWidget(
                                                                              context,
                                                                              widget.currentListData,
                                                                              index,
                                                                            ),
                                                                            cutomDiviDerWidget(index)
                                                                          ]),
                                                                    );
                                                                  })
                                                            ],
                                                          )
                                                        : widget.currentListData
                                                                    .keys
                                                                    .toList()[
                                                                        index]
                                                                    .exerciseCategoryName ==
                                                                ItemType.amrap
                                                            ? Column(
                                                                children: [
                                                                  header2CheckWidget(
                                                                      index:
                                                                          index,
                                                                      expandVar:
                                                                          enomExpand),
                                                                  ValueListenableBuilder<
                                                                          bool>(
                                                                      valueListenable:
                                                                          amrapExpand,
                                                                      builder: (context,
                                                                          value,
                                                                          child) {
                                                                        return ExpandedSection(
                                                                          expand:
                                                                              value,
                                                                          child:
                                                                              Column(children: [
                                                                            roundCheckWidget(index),
                                                                            showExerciseTileWidget(
                                                                              context,
                                                                              widget.currentListData,
                                                                              index,
                                                                            ),
                                                                            cutomDiviDerWidget(index)
                                                                          ]),
                                                                        );
                                                                      })
                                                                ],
                                                              )
                                                            : Container();
                              });
                },
              ),
            );
          }),
    );
  }

  header2CheckWidget(
      {required int index,

      // required String subtitle,
      required ValueNotifier<bool> expandVar}) {
    return index == 0
        ? BuildHeader2(
            subtitle: widget.currentListData.currentHeaderSubTitle(
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
            exerciseWorkoutData: WorkoutDetailController.addCurrentList(
                index, widget.currentListData),
            title: widget.currentListData.currentHeaderTitle(index),
            onExpand: () {
              expandVar.value = !expandVar.value;
              // setState(() {});
            })
        : index == widget.currentListData.length - 1
            ? Container()
            : widget.currentListData.entries
                        .toList()[index]
                        .key
                        .exerciseCategoryName !=
                    widget.currentListData.entries
                        .toList()[index - 1]
                        .key
                        .exerciseCategoryName
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: BuildHeader2(
                        subtitle: widget.currentListData.currentHeaderSubTitle(
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
                                index, widget.currentListData),
                        title: widget.currentListData.currentHeaderTitle(index),
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
            listData: widget.currentListData,
          )
        : i == widget.currentListData.length - 1
            ? Container()
            : widget.currentListData.entries.toList()[i].key.setsCount !=
                    widget.currentListData.entries.toList()[i - 1].key.setsCount
                ? RoundWidget(
                    i: i,
                    listData: widget.currentListData,
                  )
                : Container();
  }

  StatelessWidget cutomDiviDerWidget(int i) {
    return i == 0
        ? const CustomDivider(
            indent: 130,
            endIndent: 20,
          )
        : i == widget.currentListData.length - 1
            ? Container()
            : widget.currentListData.entries.toList()[i + 1].key.setsCount !=
                    widget.currentListData.entries.toList()[i].key.setsCount
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
              widget.currentListData.keys
                              .toList()[index]
                              .exerciseCategoryName ==
                          ItemType.singleExercise ||
                      widget.currentListData.keys
                              .toList()[index]
                              .exerciseCategoryName ==
                          ItemType.rft
                  ? "${widget.currentListData.keys.toList()[index].getGoalAndResistantTargets} • ${widget.currentListData.keys.toList()[index].setsCount} sets"
                  : widget.currentListData.keys
                      .toList()[index]
                      .getGoalAndResistantTargets,
              style: AppTypography.paragraph14MD.copyWith(
                color: AppColor.textPrimaryColor,
              )),
          trailing: widget.showTrailing == true
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
                      if (widget.goHereTap != null) {
                        widget.goHereTap!(index);
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

class RoundWidget extends StatelessWidget {
  const RoundWidget({super.key, required this.i, required this.listData});

  final int i;
  final Map<ExerciseDetailModel, ExerciseModel> listData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 20, bottom: 8),
      child: Row(children: [
        Text(
          listData.entries.toList()[i].key.exerciseCategoryName ==
                      ItemType.singleExercise ||
                  listData.entries.toList()[i].key.exerciseCategoryName ==
                      ItemType.superSet
              ? 'Round 1'
              : 'Round ${listData.entries.toList()[i].key.setsCount!.toInt() + 1}',
          style: AppTypography.label14SM
              .copyWith(color: AppColor.textPrimaryColor),
        ),
        const Expanded(
          child: CustomDivider(
            endIndent: 20,
            indent: 40,
          ),
        )
      ]),
    );
  }
}

class BuildHeader extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Map<ExerciseDetailModel, ExerciseModel> dataLIst;
  final ValueNotifier<bool> expandHeaderValueListenable, loaderListenAble;

  const BuildHeader(
      {super.key,
      this.onTap,
      required this.title,
      required this.dataLIst,
      required this.expandHeaderValueListenable,
      required this.loaderListenAble});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColor.surfaceBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: ListTile(
          title: Text(
            title,
            style: AppTypography.label18LG
                .copyWith(color: AppColor.textEmphasisColor),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: ValueListenableBuilder(
                valueListenable: loaderListenAble,
                builder: (_, value, child) {
                  return value == true
                      ? Text(
                          "0 exercise",
                          style: AppTypography.paragraph14MD
                              .copyWith(color: AppColor.textPrimaryColor),
                        )
                      : Text(
                          "${dataLIst.length} exercises",
                          style: AppTypography.paragraph14MD
                              .copyWith(color: AppColor.textPrimaryColor),
                        );
                }),
          ),
          trailing: InkWell(
              onTap: onTap,
              child: ValueListenableBuilder(
                  valueListenable: expandHeaderValueListenable,
                  builder: (_, value, child) {
                    return value == true
                        ? Icon(
                            Icons.keyboard_arrow_up,
                            color: AppColor.textPrimaryColor,
                            size: 32,
                          )
                        : Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColor.textPrimaryColor,
                            size: 32,
                          );
                  })),
        ),
      ),
    );
  }
}

class BuildHeader2 extends StatefulWidget {
  final String title, subtitle;
  final Map<ExerciseDetailModel, ExerciseModel> exerciseWorkoutData;
  final ValueNotifier<bool> expandValueListenable;
  final VoidCallback? onExpand;
  const BuildHeader2(
      {super.key,
      required this.onExpand,
      required this.title,
      required this.expandValueListenable,
      required this.exerciseWorkoutData,
      required this.subtitle});

  @override
  State<BuildHeader2> createState() => _BuildHeader2State();
}

class _BuildHeader2State extends State<BuildHeader2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ColoredBox(
        color: AppColor.surfaceBackgroundColor,
        child: Row(
          children: [
            SizedBox(
                height: context.dynamicHeight * 0.1,
                width: context.dynamicWidth * 0.2,
                child: Card(
                    color: AppColor.surfaceBackgroundBaseColor,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          child: Column(
                            children: [
                              if (widget.exerciseWorkoutData.isNotEmpty) ...[
                                Expanded(
                                    child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColor
                                                .surfaceBackgroundColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(8))),
                                        child: Transform.scale(
                                          scale: 1.2,
                                          child: cacheNetworkWidget(
                                              imageUrl: widget
                                                      .exerciseWorkoutData
                                                      .values
                                                      .toList()[0]
                                                      .mapImage
                                                      ?.url ??
                                                  ""),
                                        ),
                                      ),
                                    ),
                                    if (widget.exerciseWorkoutData.length >
                                        3) ...[
                                      4.width(),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColor
                                                  .surfaceBackgroundColor,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(8))),
                                          child: Transform.scale(
                                            scale: 1.2,
                                            child: cacheNetworkWidget(
                                                imageUrl: widget
                                                        .exerciseWorkoutData
                                                        .values
                                                        .toList()[3]
                                                        .mapImage
                                                        ?.url ??
                                                    ""),
                                          ),
                                        ),
                                      )
                                    ]
                                  ],
                                )),
                                if (widget.exerciseWorkoutData.length > 1) ...[
                                  4.height(),
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColor
                                                .surfaceBackgroundColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(8))),
                                        child: Transform.scale(
                                          scale: 1.2,
                                          child: cacheNetworkWidget(
                                              imageUrl: widget
                                                      .exerciseWorkoutData
                                                      .values
                                                      .toList()[1]
                                                      .mapImage
                                                      ?.url ??
                                                  ''),
                                        ),
                                      )),
                                      if (widget.exerciseWorkoutData.length >
                                          2) ...[
                                        4.width(),
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColor
                                                  .surfaceBackgroundColor,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(8))),
                                          child: Transform.scale(
                                            scale: 1.2,
                                            child: cacheNetworkWidget(
                                                imageUrl: widget
                                                        .exerciseWorkoutData
                                                        .values
                                                        .toList()[2]
                                                        .mapImage
                                                        ?.url ??
                                                    ""),
                                          ),
                                        ))
                                      ]
                                    ],
                                  ))
                                ]
                              ]
                            ],
                          ),
                        ),
                        if (widget.exerciseWorkoutData.length > 4)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              alignment: Alignment.center,
                              height: context.dynamicHeight * 0.022,
                              width: context.dynamicWidth * 0.05,
                              decoration: BoxDecoration(
                                  color: AppColor.surfaceBackgroundBaseColor),
                              child: FittedBox(
                                  child: Text(
                                "+${widget.exerciseWorkoutData.length - 4}",
                                style: AppTypography.label10XXSM.copyWith(
                                    color: AppColor.textEmphasisColor),
                              )),
                            ),
                          )
                      ],
                    ))),
            8.width(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: AppTypography.label18LG
                            .copyWith(color: AppColor.textEmphasisColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          widget.subtitle,
                          style: AppTypography.paragraph14MD
                              .copyWith(color: AppColor.textPrimaryColor),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                      onTap: widget.onExpand,
                      child: ValueListenableBuilder(
                        valueListenable: widget.expandValueListenable,
                        builder: (_, value, child) {
                          return value == true
                              ? Icon(
                                  Icons.keyboard_arrow_up,
                                  color: AppColor.textPrimaryColor,
                                  size: 32,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColor.textPrimaryColor,
                                  size: 32,
                                );
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
