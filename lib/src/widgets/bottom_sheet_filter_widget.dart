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
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: CategoryListController.onDemandfiltersData
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
                                          Text(
                                              data.label.toString() == "Goal"
                                                  ? "Goals"
                                                  : data.label.toString(),
                                              style: AppTypography.title18LG
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
                                                                        id: e
                                                                            .id,
                                                                        type: data
                                                                            .key
                                                                            .toString(),
                                                                        filter: e
                                                                            .label
                                                                            .toString()),
                                                                    selectedFilter,
                                                                    widget
                                                                        .confirmedFilter);
                                                                setState(() {});
                                                                // print(ref.read(videoProvider).selectedFilter);
                                                              },
                                                              child:
                                                                  levelContainer(
                                                                context,
                                                                e: IconTextModel(
                                                                    text: e
                                                                        .label
                                                                        .toString(),
                                                                    id: e.id),
                                                                selectedFilter:
                                                                    selectedFilter,
                                                                type: data.key
                                                                    .toString(),
                                                              )))
                                                      .toList(),
                                                )
                                              : Wrap(
                                                  spacing: 8,
                                                  runSpacing: 8,
                                                  children: data.dynamicValues!
                                                      .map((e) =>
                                                          GestureDetector(
                                                              onTap: () {
                                                                CategoryListController.addFilter(
                                                                    TypeFilterModel(
                                                                        type: data
                                                                            .key
                                                                            .toString(),
                                                                        filter: e
                                                                            .toString()),
                                                                    selectedFilter,
                                                                    widget
                                                                        .confirmedFilter);
                                                                setState(() {});
                                                                // print(ref.read(videoProvider).selectedFilter);
                                                              },
                                                              child:
                                                                  levelContainer(
                                                                context,
                                                                e: IconTextModel(
                                                                    text: e.toString(),
                                                                    imageName: e.toString().contains(RegExp('beginner', caseSensitive: false))
                                                                        ? AppAssets.chartLowIcon
                                                                        : e.toString().contains(RegExp("intermediate", caseSensitive: false))
                                                                            ? AppAssets.chatMidIcon
                                                                            : e.toString().contains(RegExp("advanced", caseSensitive: false))
                                                                                ? AppAssets.chartFullIcon
                                                                                : null),
                                                                selectedFilter:
                                                                    selectedFilter,
                                                                type: data.key
                                                                    .toString(),
                                                              )))
                                                      .toList(),
                                                )

                                        
                                        ],
                                      ),
                                    ))
                                .toList()),
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
