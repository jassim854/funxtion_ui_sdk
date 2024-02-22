import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../ui_tool_kit.dart';

class FirstTabWidget extends StatefulWidget {
  final List<FollowTrainingplanModel>? followTrainingData;
  final TextEditingController searchControllerPage1;
  final void Function() requestCall;
  final void Function(String) searchDelayFn;
  final bool nextPage;
  final bool showCloseIcon;
  final bool isLoadingNotifier;
  final bool isLoadMore;
  final bool isNodData;
  final List<TrainingPlanModel> listTrainingPLanData;
  final ValueNotifier<List<SelectedFilterModel>> confirmedFilter;
  final ScrollController scrollControllerPage1;
  final Map<int, String> fitnessGoalData;

  const FirstTabWidget(
      {super.key,
      this.followTrainingData,
      required this.searchControllerPage1,
      required this.confirmedFilter,
      required this.requestCall,
      required this.isLoadMore,
      required this.isLoadingNotifier,
      required this.isNodData,
      required this.listTrainingPLanData,
      required this.nextPage,
      required this.scrollControllerPage1,
      required this.showCloseIcon,
      required this.searchDelayFn,
      required this.fitnessGoalData});

  @override
  State<FirstTabWidget> createState() => _FirstTabWidgetState();
}

class _FirstTabWidgetState extends State<FirstTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColoredBox(
            color: AppColor.surfaceBackgroundColor,
            child: BottomSearchWIdget(
                searchController: widget.searchControllerPage1,
                searchDelayFn: widget.searchDelayFn,
                requestCall: widget.requestCall,
                confirmedFilter: widget.confirmedFilter,
                categoryName: CategoryName.trainingPlans)),
        1.height(),
        Expanded(
          child: Stack(
            children: [
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: widget.confirmedFilter,
                      builder: (context, value, child) {
                        return FilterRowWidget(
                          confirmedFilter: widget.confirmedFilter,
                          deleteAFilterOnTap: (e) {
                            ListController.deleteAFilter(
                                context,
                                e.filterName.toString(),
                                widget.confirmedFilter);
                            widget.requestCall();
                          },
                          hideOnTap: () {
                            ListController.hideAllFilter();
                            setState(() {});
                          },
                          showOnTap: () {
                            ListController.showAllFiltter();
                            setState(() {});
                          },
                          clearOnTap: () {
                            ListController.clearAppliedFilter(
                                widget.confirmedFilter);
                            widget.requestCall();
                          },
                        );
                      },
                    ),
                    if (widget.isLoadingNotifier == false)
                      widget.isNodData == true
                          ? const CustomErrorWidget()
                          : widget.listTrainingPLanData.isEmpty
                              ? const NoResultFOundWIdget()
                              : Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.textInvertEmphasis,
                                    ),
                                    child: ListView.separated(
                                        key: widget.key,
                                        controller:
                                            widget.scrollControllerPage1,
                                        keyboardDismissBehavior:
                                            ScrollViewKeyboardDismissBehavior
                                                .onDrag,
                                        padding: const EdgeInsets.only(
                                            top: 20,
                                            left: 20,
                                            right: 20,
                                            bottom: 20),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              CustomListtileWidget(
                                                  onTap: () {
                                                    context.hideKeypad();
                                                    context.navigateTo(
                                                        TrainingPlanDetailView(
                                                            id: widget
                                                                .listTrainingPLanData[
                                                                    index]
                                                                .id));
                                                  },
                                                  imageHeaderIcon:
                                                      AppAssets.calendarIcon,
                                                  imageUrl: widget.listTrainingPLanData[index].image
                                                      .toString(),
                                                  onSubtitleWidget: widget
                                                          .followTrainingData!
                                                          .any((element) =>
                                                              element.trainingplanId ==
                                                              widget
                                                                  .listTrainingPLanData[
                                                                      index]
                                                                  .id)
                                                      ? FollowSubtitleWidget(
                                                          followTrainingData: widget
                                                              .followTrainingData!
                                                              .elementAt(widget
                                                                  .followTrainingData!
                                                                  .indexWhere((element) =>
                                                                      element.trainingplanId ==
                                                                      widget
                                                                          .listTrainingPLanData[index]
                                                                          .id)))
                                                      : Text(
                                                          "${widget.listTrainingPLanData[index].daysTotal} workouts • ${widget.fitnessGoalData.entries.toList()[index].value} • ${widget.listTrainingPLanData[index].level}",
                                                          style: AppTypography
                                                              .paragraph14MD
                                                              .copyWith(
                                                                  color: AppColor
                                                                      .textPrimaryColor),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                  title: widget.listTrainingPLanData[index].title.toString()),
                                              if (index ==
                                                      widget.listTrainingPLanData
                                                              .length -
                                                          1 &&
                                                  widget.nextPage == false)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0)
                                                          .copyWith(top: 12),
                                                  child: Text(
                                                    "Nothing to load",
                                                    style:
                                                        AppTypography.label14SM,
                                                  ),
                                                )
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Padding(
                                            padding: EdgeInsets.only(
                                                top: 12, bottom: 12),
                                            child: CustomDivider(indent: 102),
                                          );
                                        },
                                        itemCount:
                                            widget.listTrainingPLanData.length),
                                  ),
                                ),
                    if (widget.isLoadMore == true)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: BaseHelper.loadingWidget(),
                        ),
                      ),
                  ]),
              if (widget.isLoadingNotifier) ...[
                ModalBarrier(
                    dismissible: false, color: AppColor.surfaceBackgroundColor),
                Center(child: BaseHelper.loadingWidget()),
              ]
            ],
          ),
        ),
      ],
    );
  }
}

class SecondTabWidget extends StatefulWidget {
  final Box<FollowTrainingplanModel> box;

  final ScrollController scrollControllerPage2;
  final TextEditingController searchControllerPage2;
  final ValueNotifier<List<SelectedFilterModel>> followedConfirmedFilter;
  List<FollowTrainingplanModel> followTrainingData;

  final bool isNodData;
  SecondTabWidget(
      {super.key,
      required this.box,
      required this.scrollControllerPage2,
      required this.searchControllerPage2,
      required this.followedConfirmedFilter,
      required this.isNodData,
      required this.followTrainingData});

  @override
  State<SecondTabWidget> createState() => _SecondTabWidgetState();
}

class _SecondTabWidgetState extends State<SecondTabWidget> {
  String calculatePercentage(
    int current,
    int total,
  ) {
    double percentage = (current / total) * 100;
    return "${percentage.toStringAsFixed(1)} %";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ColoredBox(
            color: AppColor.surfaceBackgroundColor,
            child: BottomSearchWIdget(
                searchController: widget.searchControllerPage2,
                searchDelayFn: (value) {
                  if (value.isNotEmpty) {
                    widget.followTrainingData.clear();
                    var result = widget.box.values.toList().where((element) =>
                        element.trainingPlanTitle
                            .toLowerCase()
                            .contains(value.toLowerCase()));
                    widget.followTrainingData = result.toList();
                    setState(() {});
                  } else {
                    widget.followTrainingData = widget.box.values.toList();
                    setState(() {});
                  }
                },
                requestCall: () {
                  if (widget.followedConfirmedFilter.value.isNotEmpty) {
                    widget.followTrainingData.clear();

                    widget.followTrainingData
                        .addAll(ListController.searchFilterLocal(
                      widget.followedConfirmedFilter,
                      widget.box,
                    ));

                    setState(() {});
                  } else {
                    widget.followTrainingData.clear();
                    widget.followTrainingData = widget.box.values.toList();
                    setState(() {});
                  }
                },
                confirmedFilter: widget.followedConfirmedFilter,
                categoryName: CategoryName.trainingPlans)),
        4.height(),
        Expanded(
          child: Stack(
            children: [
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: widget.followedConfirmedFilter,
                      builder: (context, value, child) {
                        return FilterRowWidget(
                          confirmedFilter: widget.followedConfirmedFilter,
                          deleteAFilterOnTap: (e) {
                            ListController.deleteAFilter(
                                context,
                                e.filterName.toString(),
                                widget.followedConfirmedFilter);
                            widget.followTrainingData.clear();
                            widget.followTrainingData =
                                widget.box.values.toList();
                            setState(() {});
                          },
                          hideOnTap: () {
                            ListController.hideAllFilter();
                            setState(() {});
                          },
                          showOnTap: () {
                            ListController.showAllFiltter();
                            setState(() {});
                          },
                          clearOnTap: () {
                            ListController.clearAppliedFilter(
                                widget.followedConfirmedFilter);

                            widget.followTrainingData =
                                widget.box.values.toList();
                            setState(() {});
                          },
                        );
                      },
                    ),
                    widget.isNodData == true
                        ? const NoResultFOundWIdget()
                        : widget.followTrainingData.isEmpty
                            ? const NoResultFOundWIdget()
                            : Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.textInvertEmphasis,
                                  ),
                                  child: ListView.separated(
                                      key: const PageStorageKey("page2"),
                                      controller: widget.scrollControllerPage2,
                                      keyboardDismissBehavior:
                                          ScrollViewKeyboardDismissBehavior
                                              .onDrag,
                                      padding: const EdgeInsets.only(
                                          top: 20,
                                          left: 20,
                                          right: 20,
                                          bottom: 20),
                                      itemBuilder: (context, index) {
                                        return CustomListtileWidget(
                                            onTap: () {
                                              context.hideKeypad();
                                              context.navigateTo(
                                                  TrainingPlanDetailView(
                                                id: widget
                                                    .followTrainingData[index]
                                                    .trainingplanId,
                                              ));
                                            },
                                            imageHeaderIcon:
                                                AppAssets.calendarIcon,
                                            imageUrl: widget
                                                .followTrainingData[index]
                                                .trainingPlanImg
                                                .toString(),
                                            onSubtitleWidget:
                                                FollowSubtitleWidget(
                                                    followTrainingData: widget
                                                            .followTrainingData[
                                                        index]),
                                            title: widget
                                                .followTrainingData[index]
                                                .trainingPlanTitle
                                                .toString());
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Padding(
                                          padding: EdgeInsets.only(
                                              top: 12, bottom: 12),
                                          child: CustomDivider(indent: 102),
                                        );
                                      },
                                      itemCount:
                                          widget.followTrainingData.length),
                                ),
                              ),
                  ]),
            ],
          ),
        ),
      ],
    );
  }
}
