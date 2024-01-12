import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';

class FilterSheetWidget extends StatefulWidget {
  CategoryName categoryName;
  ValueNotifier<List<TypeFilterModel>> confirmedFilter;
  void Function(List<TypeFilterModel> selectedFilter) onDone;

  FilterSheetWidget(
      {super.key,
      required this.categoryName,
      required this.onDone,
      required this.confirmedFilter});

  @override
  State<FilterSheetWidget> createState() => _FilterSheetWidgetState();
}

class _FilterSheetWidgetState extends State<FilterSheetWidget> {
  List<TypeFilterModel> selectedFilter = [];
  ValueNotifier<bool> filterLoader = ValueNotifier(false);
  @override
  void initState() {
    CategoryListController.runComplexTask(
        context, widget.categoryName, filterLoader);
    selectedFilter.addAll(widget.confirmedFilter.value);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: selectedFilter.isNotEmpty
                    ? () {
                        CategoryListController.resetFilter(
                            context, selectedFilter, widget.confirmedFilter);

                        setState(() {});
                      }
                    : null,
                child: Text('Reset',
                    style: selectedFilter.isNotEmpty
                        ? AppTypography.label14SM
                            .copyWith(color: AppColor.linkPrimaryColor)
                        : AppTypography.label14SM
                            .copyWith(color: AppColor.linkDisableColor)),
              ),
              Text(
                'Filter',
                style: AppTypography.label18LG
                    .copyWith(color: AppColor.textEmphasisColor),
              ),
              InkWell(
                onTap: () {
                  context.popPage();
                  widget.onDone(selectedFilter);
                },
                child: Text('Done',
                    style: AppTypography.label14SM
                        .copyWith(color: AppColor.linkPrimaryColor)),
              ),
            ],
          ),
        ),
        const CustomDivider(),
        ValueListenableBuilder<bool>(
            valueListenable: filterLoader,
            builder: (_, value, child) {
              return value == true
                  ? Center(
                      child: BaseHelper.loadingWidget(),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  CategoryListController.onDemandfiltersData
                                      .map((data) => Padding(
                                            padding: EdgeInsets.only(
                                                top: CategoryListController
                                                            .onDemandfiltersData
                                                            .first ==
                                                        data
                                                    ? 20
                                                    : 35,
                                                bottom: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(data.label.toString(),
                                                    style: AppTypography
                                                        .title18LG
                                                        .copyWith(
                                                            color: AppColor
                                                                .textEmphasisColor)),
                                                12.height(),
                                                data.values != null
                                                    ? Wrap(
                                                        spacing: 8,
                                                        runSpacing: 8,
                                                        children: data.values!
                                                            .map((e) =>
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      CategoryListController.addFilter(
                                                                          TypeFilterModel(
                                                                              id: e.id,
                                                                              type: data.key.toString(),
                                                                              filter: e.label.toString()),
                                                                          selectedFilter,
                                                                          widget.confirmedFilter);
                                                                      setState(
                                                                          () {});
                                                                      // print(ref.read(videoProvider).selectedFilter);
                                                                    },
                                                                    child:
                                                                        levelContainer(
                                                                      context,
                                                                      e: IconTextModel(
                                                                          text: e
                                                                              .label
                                                                              .toString(),
                                                                          id: e
                                                                              .id),
                                                                      selectedFilter:
                                                                          selectedFilter,
                                                                      type: data
                                                                          .key
                                                                          .toString(),
                                                                    )))
                                                            .toList(),
                                                      )
                                                    : Wrap(
                                                        spacing: 8,
                                                        runSpacing: 8,
                                                        children: data
                                                            .dynamicValues!
                                                            .map((e) =>
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      CategoryListController.addFilter(
                                                                          TypeFilterModel(
                                                                              type: data.key.toString(),
                                                                              filter: data.key!.contains("max_days_per_week") ? e[1].toString() : e.toString()),
                                                                          selectedFilter,
                                                                          widget.confirmedFilter);
                                                                      setState(
                                                                          () {});
                                                                      // print(ref.read(videoProvider).selectedFilter);
                                                                    },
                                                                    child:
                                                                        levelContainer(
                                                                      context,
                                                                      e: IconTextModel(
                                                                          text: data.key!.contains("max_days_per_week") ? e[1].toString() : e.toString(),
                                                                          imageName: e.toString().contains(RegExp('beginner', caseSensitive: false))
                                                                              ? AppAssets.chartLowIcon
                                                                              : e.toString().contains(RegExp("intermediate", caseSensitive: false))
                                                                                  ? AppAssets.chatMidIcon
                                                                                  : e.toString().contains(RegExp("advanced", caseSensitive: false))
                                                                                      ? AppAssets.chartFullIcon
                                                                                      : null),
                                                                      selectedFilter:
                                                                          selectedFilter,
                                                                      type: data
                                                                          .key
                                                                          .toString(),
                                                                    )))
                                                            .toList(),
                                                      )

                                                // Row(
                                                //     mainAxisAlignment:
                                                //         MainAxisAlignment.spaceBetween,
                                                //     children: CategoryListController.level
                                                //         .map((e) => InkWell(
                                                //             onTap: () {
                                                //               CategoryListController.addFilter(
                                                //                   TypeFilterModel(
                                                //                       type: data.key.toString(),
                                                //                       filter: e.text),
                                                //                   selectedFilter,
                                                //                   widget.confirmedFilter);
                                                //               setState(() {});
                                                //               // print(ref.read(videoProvider).selectedFilter);
                                                //             },
                                                //             child: levelContainer(context,
                                                //                 e: e,
                                                //                 selectedFilter: selectedFilter,
                                                //                 type: 'level')))
                                                //         .toList()),
                                              ],
                                            ),
                                          ))
                                      .toList()

                              // if (widget.categoryName != CategoryName.trainingPLans) ...[
                              //   Padding(
                              //     padding: const EdgeInsets.only(top: 40, bottom: 12),
                              //     child: Text('Duration',
                              //         style: AppTypography.title18LG
                              //             .copyWith(color: AppColor.textEmphasisColor)),
                              //   ),
                              //   Row(
                              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //       children: CategoryListController.duration
                              //           .map((e) => InkWell(
                              //               onTap: () {
                              //                 CategoryListController.addFilter(
                              //                     TypeFilterModel(
                              //                         type: "duration", filter: e.text),
                              //                     selectedFilter,
                              //                     widget.confirmedFilter);

                              //                 setState(() {});
                              //                 // print(ref.read(videoProvider).selectedFilter);
                              //               },
                              //               child: levelContainer(context,
                              //                   e: e,
                              //                   selectedFilter: selectedFilter,
                              //                   type: 'duration')))
                              //           .toList()),
                              // ],

                              // //  CategoryListController.durationWeek
                              // //     .map((e) => InkWell(
                              // //         onTap: () {
                              // //           CategoryListController.addFilter(
                              // //               TypeFilterModel(
                              // //                   type: "duration", filter: e.text),
                              // //               selectedFilter,
                              // //               widget.confirmedFilter);

                              // //           setState(() {});
                              // //           // print(ref.read(videoProvider).selectedFilter);
                              // //         },
                              // //         child: levelContainer(context,
                              // //             e: e,
                              // //             selectedFilter: selectedFilter,
                              // //             type: 'duration')))
                              // //     .toList()),

                              // if (widget.categoryName == CategoryName.workouts) ...[
                              //   Padding(
                              //     padding: const EdgeInsets.only(top: 40, bottom: 12),
                              //     child: Text('Type',
                              //         style: AppTypography.title18LG
                              //             .copyWith(color: AppColor.textEmphasisColor)),
                              //   ),
                              //   Wrap(
                              //       spacing: 8,
                              //       runSpacing: 8,
                              //       children: CategoryListController.typesFilters
                              //           .map((e) => InkWell(
                              //               onTap: () {
                              //                 CategoryListController.addFilter(
                              //                     TypeFilterModel(
                              //                         type: "type", filter: e.text, id: e.id),
                              //                     selectedFilter,
                              //                     widget.confirmedFilter);
                              //                 setState(() {});
                              //                 // print(ref.read(videoProvider).selectedFilter);
                              //               },
                              //               child: levelContainer(context,
                              //                   e: e,
                              //                   selectedFilter: selectedFilter,
                              //                   type: 'type')))
                              //           .toList()),
                              // ],
                              // if (widget.categoryName == CategoryName.workouts ||
                              //     widget.categoryName == CategoryName.trainingPLans) ...[
                              //   Padding(
                              //     padding: const EdgeInsets.only(top: 40, bottom: 12),
                              //     child: Text('Location',
                              //         style: AppTypography.title18LG
                              //             .copyWith(color: AppColor.textEmphasisColor)),
                              //   ),
                              //   Row(
                              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //       children: CategoryListController.location
                              //           .map((e) => InkWell(
                              //               onTap: () {
                              //                 CategoryListController.addFilter(
                              //                     TypeFilterModel(
                              //                         type: "location", filter: e.text),
                              //                     selectedFilter,
                              //                     widget.confirmedFilter);
                              //                 setState(() {});
                              //                 // print(ref.read(videoProvider).selectedFilter);
                              //               },
                              //               child: levelContainer(context,
                              //                   e: e,
                              //                   selectedFilter: selectedFilter,
                              //                   type: 'location')))
                              //           .toList()),
                              // ],
                              // if (widget.categoryName == CategoryName.videoClasses ||
                              //     widget.categoryName == CategoryName.audioClasses) ...[
                              //   Padding(
                              //     padding: const EdgeInsets.only(top: 40, bottom: 12),
                              //     child: Text('Category',
                              //         style: AppTypography.title18LG
                              //             .copyWith(color: AppColor.textEmphasisColor)),
                              //   ),
                              //   Wrap(
                              //       spacing: 8,
                              //       runSpacing: 8,
                              //       children: CategoryListController.categoryTypeFilters
                              //           .map((e) => InkWell(
                              //               onTap: () {
                              //                 CategoryListController.addFilter(
                              //                     TypeFilterModel(
                              //                         type: "category",
                              //                         filter: e.text,
                              //                         id: e.id),
                              //                     selectedFilter,
                              //                     widget.confirmedFilter);

                              //                 setState(() {});
                              //                 // print(ref.read(videoProvider).selectedFilter);
                              //               },
                              //               child: levelContainer(context,
                              //                   e: e,
                              //                   selectedFilter: selectedFilter,
                              //                   type: 'category')))
                              //           .toList())
                              // ],
                              // if (widget.categoryName == CategoryName.videoClasses ||
                              //     widget.categoryName == CategoryName.audioClasses) ...[
                              //   Padding(
                              //     padding: const EdgeInsets.only(top: 40, bottom: 12),
                              //     child: Text('Equipment',
                              //         style: AppTypography.title18LG
                              //             .copyWith(color: AppColor.textEmphasisColor)),
                              //   ),
                              //   Wrap(
                              //       spacing: 8,
                              //       runSpacing: 8,
                              //       children: CategoryListController.equipmentFilter
                              //           .map((e) => InkWell(
                              //               onTap: () {
                              //                 CategoryListController.addFilter(
                              //                     TypeFilterModel(
                              //                         type: "equipment",
                              //                         filter: e.text,
                              //                         id: e.id),
                              //                     selectedFilter,
                              //                     widget.confirmedFilter);
                              //                 setState(() {});
                              //                 // print(ref.read(videoProvider).selectedFilter);
                              //               },
                              //               child: levelContainer(context,
                              //                   e: e,
                              //                   selectedFilter: selectedFilter,
                              //                   type: 'equipment')))
                              //           .toList()),
                              // ],
                              // if (widget.categoryName == CategoryName.videoClasses ||
                              //     widget.categoryName == CategoryName.audioClasses) ...[
                              //   Padding(
                              //     padding: const EdgeInsets.only(top: 40, bottom: 12),
                              //     child: Text('Instructor',
                              //         style: AppTypography.title18LG
                              //             .copyWith(color: AppColor.textEmphasisColor)),
                              //   ),
                              //   Wrap(
                              //       spacing: 8,
                              //       runSpacing: 8,
                              //       children: CategoryListController.instructorFilter
                              //           .map((e) => InkWell(
                              //               onTap: () {
                              //                 CategoryListController.addFilter(
                              //                     TypeFilterModel(
                              //                         type: "instructor",
                              //                         filter: e.text,
                              //                         id: e.id),
                              //                     selectedFilter,
                              //                     widget.confirmedFilter);
                              //                 setState(() {});
                              //                 // print(ref.read(videoProvider).selectedFilter);
                              //               },
                              //               child: levelContainer(context,
                              //                   e: e,
                              //                   selectedFilter: selectedFilter,
                              //                   type: 'instructor')))
                              //           .toList()),
                              // ],
                              // // if (widget.categoryName != CategoryName.trainingPLans) ...[
                              // //   Padding(
                              // //     padding: const EdgeInsets.only(top: 40, bottom: 12),
                              // //     child: Text('Type',
                              // //         style: AppTypography.title18LG
                              // //             .copyWith(color: AppColor.textEmphasisColor)),
                              // //   ),
                              // //   Wrap(
                              // //       spacing: 8,
                              // //       runSpacing: 8,
                              // //       children: CategoryListController.categoryType
                              // //           .map((e) => InkWell(
                              // //               onTap: () {
                              // //                 CategoryListController.addFilter(
                              // //                     TypeFilterModel(type: "type", filter: e.text),
                              // //                     selectedFilter,
                              // //                     widget.confirmedFilter);
                              // //                 setState(() {});
                              // //                 // print(ref.read(videoProvider).selectedFilter);
                              // //               },
                              // //               child: levelContainer(context,
                              // //                   e: e,
                              // //                   selectedFilter: selectedFilter,
                              // //                   type: 'type')))
                              // //           .toList()),
                              // // ],
                              // if (widget.categoryName == CategoryName.workouts ||
                              //     widget.categoryName == CategoryName.trainingPLans) ...[
                              //   Padding(
                              //     padding: const EdgeInsets.only(top: 40, bottom: 12),
                              //     child: Text('Goals',
                              //         style: AppTypography.title18LG
                              //             .copyWith(color: AppColor.textEmphasisColor)),
                              //   ),
                              //   Wrap(
                              //       spacing: 8,
                              //       runSpacing: 8,
                              //       children: CategoryListController.goalsFilters
                              //           .map((e) => InkWell(
                              //               onTap: () {
                              //                 CategoryListController.addFilter(
                              //                     TypeFilterModel(
                              //                         type: "goal", filter: e.text, id: e.id),
                              //                     selectedFilter,
                              //                     widget.confirmedFilter);
                              //                 setState(() {});
                              //                 // print(ref.read(videoProvider).selectedFilter);
                              //               },
                              //               child: levelContainer(context,
                              //                   e: e,
                              //                   selectedFilter: selectedFilter,
                              //                   type: 'goal')))
                              //           .toList()),
                              // ],
                              // if (widget.categoryName == CategoryName.workouts) ...[
                              //   Padding(
                              //     padding: const EdgeInsets.only(top: 40, bottom: 12),
                              //     child: Text('Bodypart',
                              //         style: AppTypography.title18LG
                              //             .copyWith(color: AppColor.textEmphasisColor)),
                              //   ),
                              //   Wrap(
                              //       spacing: 8,
                              //       runSpacing: 8,
                              //       children: CategoryListController.bodyPartFilter
                              //           .map((e) => InkWell(
                              //               onTap: () {
                              //                 CategoryListController.addFilter(
                              //                     TypeFilterModel(
                              //                         type: "bodyPart",
                              //                         filter: e.text,
                              //                         id: e.id),
                              //                     selectedFilter,
                              //                     widget.confirmedFilter);
                              //                 setState(() {});
                              //               },
                              //               child: levelContainer(context,
                              //                   e: e,
                              //                   selectedFilter: selectedFilter,
                              //                   type: 'bodyPart')))
                              //           .toList()),
                              // ]

                              ),
                        ),
                      ),
                    );
            })
      ],
    );
  }
}

Widget levelContainer(BuildContext context,
    {required IconTextModel e,
    required List<TypeFilterModel> selectedFilter,
    required String type}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        border: selectedFilter.any((element) {
          return element.filter == e.text && element.type == type;
        })
            ? Border.all(color: AppColor.buttonPrimaryColor, width: 1)
            : Border.all(color: AppColor.borderOutlineColor, width: 1),
        color: AppColor.surfaceBackgroundColor,
        borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        e.imageName != null
            ? SvgPicture.asset(
                e.imageName.toString(),
                color: selectedFilter.any((element) {
                  return element.filter == e.text && element.type == type;
                })
                    ? AppColor.buttonPrimaryColor
                    : AppColor.textEmphasisColor,
              )
            : const SizedBox.shrink(),
        4.height(),
        Text(
          e.text,
          style: AppTypography.label14SM.copyWith(
              color: selectedFilter.any((element) {
            return element.filter == e.text && element.type == type;
          })
                  ? AppColor.buttonPrimaryColor
                  : AppColor.textEmphasisColor),
        )
      ],
    ),
  );
}
