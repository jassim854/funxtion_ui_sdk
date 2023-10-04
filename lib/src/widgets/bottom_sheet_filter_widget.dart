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
  @override
  void initState() {
    selectedFilter.addAll(widget.confirmedFilter.value);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Level',
                  style: AppTypography.title18LG
                      .copyWith(color: AppColor.textEmphasisColor)),
              12.height(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: CategoryListController.level
                      .map((e) => InkWell(
                          onTap: () {
                            CategoryListController.addFilter(
                                TypeFilterModel(type: "level", filter: e.text),
                                selectedFilter,
                                widget.confirmedFilter);
                            setState(() {});
                            // print(ref.read(videoProvider).selectedFilter);
                          },
                          child: levelContainer(context,
                              e: e,
                              selectedFilter: selectedFilter,
                              type: 'level')))
                      .toList()),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 12),
                child: Text('Duration',
                    style: AppTypography.title18LG
                        .copyWith(color: AppColor.textEmphasisColor)),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widget.categoryName == CategoryName.videoClasses ||
                          widget.categoryName == CategoryName.workouts ||
                          widget.categoryName == CategoryName.audioClasses
                      ? CategoryListController.duration
                          .map((e) => InkWell(
                              onTap: () {
                                CategoryListController.addFilter(
                                    TypeFilterModel(
                                        type: "duration", filter: e.text),
                                    selectedFilter,
                                    widget.confirmedFilter);

                                setState(() {});
                                // print(ref.read(videoProvider).selectedFilter);
                              },
                              child: levelContainer(context,
                                  e: e,
                                  selectedFilter: selectedFilter,
                                  type: 'duration')))
                          .toList()
                      : CategoryListController.durationWeek
                          .map((e) => InkWell(
                              onTap: () {
                                CategoryListController.addFilter(
                                    TypeFilterModel(
                                        type: "duration", filter: e.text),
                                    selectedFilter,
                                    widget.confirmedFilter);

                                setState(() {});
                                // print(ref.read(videoProvider).selectedFilter);
                              },
                              child: levelContainer(context,
                                  e: e,
                                  selectedFilter: selectedFilter,
                                  type: 'duration')))
                          .toList()),
              if (widget.categoryName == CategoryName.trainingPLans) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 12),
                  child: Text('Workouts Per Week',
                      style: AppTypography.title18LG
                          .copyWith(color: AppColor.textEmphasisColor)),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: Slider(
                        min: 1.0,
                        max: 5.0,
                        value: CategoryListController.slderValue,
                        divisions: 4,
                        label: '${CategoryListController.slderValue.round()}',
                        onChanged: (value) {
                          if (value != 1.0) {
                            CategoryListController.slderValue = value;
                            CategoryListController.addAFilter(
                                TypeFilterModel(
                                    type: "workout per week",
                                    filter: value.toString()),
                                selectedFilter);
                          }

                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.dynamicHeight * 0.025,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '1',
                            style: AppTypography.label14SM
                                .copyWith(color: AppColor.textEmphasisColor),
                          ),
                          Text(
                            '2',
                            style: AppTypography.label14SM
                                .copyWith(color: AppColor.textEmphasisColor),
                          ),
                          Text(
                            '3',
                            style: AppTypography.label14SM
                                .copyWith(color: AppColor.textEmphasisColor),
                          ),
                          Text(
                            '4',
                            style: AppTypography.label14SM
                                .copyWith(color: AppColor.textEmphasisColor),
                          ),
                          Text(
                            '5',
                            style: AppTypography.label14SM
                                .copyWith(color: AppColor.textEmphasisColor),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 12),
                child: Text('Location',
                    style: AppTypography.title18LG
                        .copyWith(color: AppColor.textEmphasisColor)),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: CategoryListController.location
                      .map((e) => InkWell(
                          onTap: () {
                            CategoryListController.addFilter(
                                TypeFilterModel(
                                    type: "location", filter: e.text),
                                selectedFilter,
                                widget.confirmedFilter);
                            setState(() {});
                            // print(ref.read(videoProvider).selectedFilter);
                          },
                          child: levelContainer(context,
                              e: e,
                              selectedFilter: selectedFilter,
                              type: 'location')))
                      .toList()),
              if (widget.categoryName != CategoryName.trainingPLans) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 12),
                  child: Text('Type',
                      style: AppTypography.title18LG
                          .copyWith(color: AppColor.textEmphasisColor)),
                ),
                Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: CategoryListController.type
                        .map((e) => InkWell(
                            onTap: () {
                              CategoryListController.addFilter(
                                  TypeFilterModel(type: "type", filter: e.text),
                                  selectedFilter,
                                  widget.confirmedFilter);
                              setState(() {});
                              // print(ref.read(videoProvider).selectedFilter);
                            },
                            child: levelContainer(context,
                                e: e,
                                selectedFilter: selectedFilter,
                                type: 'type')))
                        .toList()),
              ],
              if (widget.categoryName == CategoryName.workouts ||
                  widget.categoryName == CategoryName.trainingPLans) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 12),
                  child: Text('Goals',
                      style: AppTypography.title18LG
                          .copyWith(color: AppColor.textEmphasisColor)),
                ),
                Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: CategoryListController.goals
                        .map((e) => InkWell(
                            onTap: () {
                              CategoryListController.addFilter(
                                  TypeFilterModel(type: "goal", filter: e.text),
                                  selectedFilter,
                                  widget.confirmedFilter);
                              setState(() {});
                              // print(ref.read(videoProvider).selectedFilter);
                            },
                            child: levelContainer(context,
                                e: e,
                                selectedFilter: selectedFilter,
                                type: 'goal')))
                        .toList())
              ]
            ]),
          )
        ],
      ),
    );
  }
}

Widget levelContainer(BuildContext context,
    {required IconTextModel e,
    required List<TypeFilterModel> selectedFilter,
    required String type}) {
  return Container(
    padding: const EdgeInsets.all(16).copyWith(top: 18),
    width: e.imageName != null ? context.dynamicWidth * 0.28 : null,
    decoration: BoxDecoration(
        border: selectedFilter.any((element) {
          return element.filter == e.text && element.type == type;
        })
            ? Border.all(color: AppColor.buttonPrimaryColor, width: 2)
            : null,
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
