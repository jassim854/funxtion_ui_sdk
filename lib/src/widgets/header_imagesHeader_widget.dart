import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';
import 'detail_exercise_bottom_sheet_widget.dart';

class BuildBodySingleExercise extends StatelessWidget {
  BuildBodySingleExercise(
      {super.key,
      required this.dataList,
      required this.valueListenable,
      required this.valueListenable1,
      this.goHereTap,
      this.workoutModel,
      this.showTrailing = false,
      required this.bodySubtitle});
  final List<ExerciseModel> dataList;
  final WorkoutModel? workoutModel;
  ValueListenable<bool> valueListenable;
  ValueListenable<bool> valueListenable1;
  final String bodySubtitle;
  bool showTrailing;
  final void Function(int)? goHereTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      color: AppColor.surfaceBackgroundColor,
      child: ValueListenableBuilder(
          valueListenable: valueListenable,
          builder: (_, value, child) {
            return ExpandedSection(
              expand: value,
              child: ValueListenableBuilder(
                valueListenable: valueListenable1,
                builder: (_, value, child) {
                  return value == true
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: BaseHelper.loadingWidget(),
                          ),
                        )
                      : dataList.isEmpty
                          ? const Center(
                              child: Text('No Data'),
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, top: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Round 1',
                                        style: AppTypography.label14SM.copyWith(
                                            color: AppColor.textPrimaryColor),
                                      ),
                                      const Expanded(
                                        child: CustomDivider(
                                          endIndent: 20,
                                          indent: 40,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                listData(),
                              ],
                            );
                },
              ),
            );
          }),
    );
  }

  ListView listData() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 50),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Transform.scale(
              scale: 1.5,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: context.dynamicWidth * 0.12,
                  child: cacheNetworkWidget(
                      imageUrl: dataList[index].mapImage?.url ?? ""),
                ),
              ),
            ),
            title: Text(
              dataList[index].name,
              style: AppTypography.label16MD
                  .copyWith(color: AppColor.textEmphasisColor),
            ),
            subtitle: Text(bodySubtitle,
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
                            backgroundColor:
                                AppColor.surfaceBackgroundBaseColor,
                            context: context,
                            builder: (context) => DetailWorkoutBottomSheet(
                                exerciseModel: dataList[index]));
                        // context.navigateTo(DetailExerciseBottomSheet(
                        //     exerciseModel: dataList[index]));
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
                          onTap: () {},
                        )
                      ];
                    },
                    child: SvgPicture.asset(
                      AppAssets.horizontalVertIcon,
                      color: AppColor.surfaceBrandDarkColor,
                    ))
                : null);
      },
      separatorBuilder: (context, index) {
        return const CustomDivider(
          indent: 80,
          endIndent: 20,
        );
      },
    );
  }
}

class BuildHeader extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  List<ExerciseModel> dataLIst;
  ValueListenable valueListenable, loaderListenAble;

  final Widget? leadingWidget;
  BuildHeader(
      {super.key,
      this.onTap,
      required this.title,
      this.leadingWidget,
      required this.dataLIst,
      required this.valueListenable,
      required this.loaderListenAble});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColor.surfaceBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: ListTile(
          leading: leadingWidget,
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
                  valueListenable: valueListenable,
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

class BuildHeader2 extends StatelessWidget {
  final VoidCallback? onTap;
  final String title, subtitle;
  final List<ExerciseModel> exerciseWorkoutData;
  ValueListenable<bool> expandValueListenable,
      loaderListenable,
      expandBodyValueListenable;

  BuildHeader2(
      {super.key,
      this.onTap,
      required this.title,
      required this.expandBodyValueListenable,
      required this.loaderListenable,
      required this.expandValueListenable,
      required this.exerciseWorkoutData,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: expandBodyValueListenable,
        builder: (context, value, child) {
          return ExpandedSection(
            expand: value,
            child: ColoredBox(
              color: AppColor.surfaceBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 20),
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
                          child: ValueListenableBuilder(
                              valueListenable: loaderListenable,
                              builder: (context, value, child) {
                                return value == true
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: BaseHelper.loadingWidget(),
                                        ),
                                      )
                                    : Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 4),
                                            child: Column(
                                              children: [
                                                if (exerciseWorkoutData
                                                    .isNotEmpty) ...[
                                                  Expanded(
                                                      child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .surfaceBackgroundColor,
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8))),
                                                          child:
                                                              Transform.scale(
                                                            scale: 1.2,
                                                            child: cacheNetworkWidget(
                                                                imageUrl: exerciseWorkoutData[
                                                                            0]
                                                                        .mapImage
                                                                        ?.url ??
                                                                    ""),
                                                          ),
                                                        ),
                                                      ),
                                                      if (exerciseWorkoutData
                                                              .length >
                                                          3) ...[
                                                        4.width(),
                                                        Expanded(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: AppColor
                                                                    .surfaceBackgroundColor,
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            8))),
                                                            child:
                                                                Transform.scale(
                                                              scale: 1.2,
                                                              child: cacheNetworkWidget(
                                                                  imageUrl: exerciseWorkoutData[
                                                                              3]
                                                                          .mapImage
                                                                          ?.url ??
                                                                      ""),
                                                            ),
                                                          ),
                                                        )
                                                      ]
                                                    ],
                                                  )),
                                                  if (exerciseWorkoutData
                                                          .length >
                                                      1) ...[
                                                    4.height(),
                                                    Expanded(
                                                        child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: Container(
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .surfaceBackgroundColor,
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8))),
                                                          child:
                                                              Transform.scale(
                                                            scale: 1.2,
                                                            child: cacheNetworkWidget(
                                                                imageUrl: exerciseWorkoutData[
                                                                            1]
                                                                        .mapImage
                                                                        ?.url ??
                                                                    ''),
                                                          ),
                                                        )),
                                                        if (exerciseWorkoutData
                                                                .length >
                                                            2) ...[
                                                          4.width(),
                                                          Expanded(
                                                              child: Container(
                                                            decoration: BoxDecoration(
                                                                color: AppColor
                                                                    .surfaceBackgroundColor,
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            8))),
                                                            child:
                                                                Transform.scale(
                                                              scale: 1.2,
                                                              child: cacheNetworkWidget(
                                                                  imageUrl: exerciseWorkoutData[
                                                                              2]
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
                                          if (exerciseWorkoutData.length > 4)
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                clipBehavior: Clip.hardEdge,
                                                alignment: Alignment.center,
                                                height: context.dynamicHeight *
                                                    0.022,
                                                width:
                                                    context.dynamicWidth * 0.05,
                                                decoration: BoxDecoration(
                                                    color: AppColor
                                                        .surfaceBackgroundBaseColor),
                                                child: FittedBox(
                                                    child: Text(
                                                  "+${exerciseWorkoutData.length - 4}",
                                                  style: AppTypography
                                                      .label10XXSM
                                                      .copyWith(
                                                          color: AppColor
                                                              .textEmphasisColor),
                                                )),
                                              ),
                                            )
                                        ],
                                      );
                              })),
                    ),
                    8.width(),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: AppTypography.label18LG.copyWith(
                                    color: AppColor.textEmphasisColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: ValueListenableBuilder(
                                    valueListenable: loaderListenable,
                                    builder: (_, value, child) {
                                      return value == true
                                          ? Text(
                                              subtitle + " 0 exercise",
                                              style: AppTypography.paragraph14MD
                                                  .copyWith(
                                                      color: AppColor
                                                          .textPrimaryColor),
                                            )
                                          : Text(
                                              subtitle +
                                                  " ${exerciseWorkoutData.length == 0 ? "${exerciseWorkoutData.length} exercise" : "${exerciseWorkoutData.length} exercises"}",
                                              style: AppTypography.paragraph14MD
                                                  .copyWith(
                                                      color: AppColor
                                                          .textPrimaryColor),
                                            );
                                    }),
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: onTap,
                              child: ValueListenableBuilder(
                                  valueListenable: expandValueListenable,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
