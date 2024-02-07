import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ui_tool_kit/src/helper/boxes.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';
import '../../model/follow_trainingplan_model.dart';

class TrainingPlanListView extends StatefulWidget {
  final int initialIndex;
  const TrainingPlanListView({
    super.key,
    required this.initialIndex,
  });

  @override
  State<TrainingPlanListView> createState() =>
      _VideoAudioClassesListViewState();
}

class _VideoAudioClassesListViewState extends State<TrainingPlanListView>
    with SingleTickerProviderStateMixin {
  late TextEditingController _searchControllerPage1;
  late TextEditingController _searchControllerPage2;
  late ScrollController _scrollControllerPage2;
  late ScrollController _scrollControllerPage1;

  late TabController _tabController;
  int pageNumber = 0;
  // Map<int, List<FitnessGoalModel>> fitnessGoalData = {};
  List<FollowTrainingplanModel>? followTrainingData;
  List<TrainingPlanModel> listTrainingPLanData = [];
  List<TrainingPlanModel> tempListTrainingPLanData = [];
  List<TrainingPlanModel> localTrainingPlanData = [];
  Map<int, String> fitnessGoalData = {};
  bool alreadyCalled = false;
  bool nextPage = true;
  bool showCloseIcon = false;
  bool followedShowCloseIcon = false;
  bool isLoadMore = false;
  bool isNodData = false;
  bool shouldBreakLoop = false;
  bool isLoadingNotifier = false;
  // final ValueNotifier<int> _length = ValueNotifier(1);

  ValueNotifier<List<TypeFilterModel>> confirmedFilter = ValueNotifier([]);
  ValueNotifier<List<TypeFilterModel>> followedConfirmedFilter =
      ValueNotifier([]);
  // ValueNotifier<bool> isSubtitleLoading = ValueNotifier(false);

  bool isFollowed = false;

  @override
  void initState() {
    _searchControllerPage1 = TextEditingController();
    _searchControllerPage2 = TextEditingController();
    _scrollControllerPage1 = ScrollController();
    _scrollControllerPage2 = ScrollController();
    _tabController = TabController(
        length: 2, vsync: this, initialIndex: widget.initialIndex);

    // _tabController.addListener(() {
    //   if (_tabController.index == 0) {
    getData(isScroll: false);
    _scrollControllerPage1.addListener(
      () {
        if (isLoadMore == false &&
            nextPage == true &&
            _scrollControllerPage1.position.extentAfter < 300.0 &&
            _scrollControllerPage1.position.extentAfter != 0.0) {
          isLoadMore = true;
          pageNumber += 10;
          getData(
            isScroll: true,
          );
        }
      },
    );

    super.initState();
  }

  checkIsFollowed() {
    isFollowed = Boxes.getTrainingPlanBox().isNotEmpty;
    if (isFollowed == false) {
      _tabController.animateTo(0);
    }
  }

  @override
  void dispose() {
    shouldBreakLoop = true;
    _scrollControllerPage1.dispose();
    _searchControllerPage1.dispose();
    _searchControllerPage2.dispose();
    _scrollControllerPage2.dispose();
    _tabController.dispose();
    CategoryListController.filterListData.clear();
    super.dispose();
  }

  addData(Box<FollowTrainingplanModel> box) {
    if (_searchControllerPage2.text.isEmpty &&
        followedConfirmedFilter.value.isEmpty) {
      followTrainingData = box.values.toList();
    } else if (_searchControllerPage2.text.isNotEmpty) {
      followTrainingData = box.values
          .where((element) => element.trainingPlanTitle
              .toLowerCase()
              .contains(_searchControllerPage2.text.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<FollowTrainingplanModel>>(
        valueListenable: Boxes.getTrainingPlanBox().listenable(),
        builder: (_, box, child) {
          checkIsFollowed();
          addData(box);
          return Scaffold(
              backgroundColor: AppColor.surfaceBackgroundBaseColor,
              appBar: AppBar(
                  surfaceTintColor: AppColor.surfaceBackgroundColor,
                  titleSpacing: 0,
                  leadingWidth: 75,
                  toolbarHeight: 40,
                  leading: Navigator.of(context).canPop()
                      ? GestureDetector(
                          onTap: () {
                            context.maybePopPage();
                          },
                          child: SvgPicture.asset(
                            AppAssets.backArrowIcon,
                          ),
                        )
                      : const SizedBox.shrink(),
                  backgroundColor: AppColor.surfaceBackgroundColor,
                  elevation: 0.0,
                  centerTitle: true,
                  title: titleWidget(),
                  bottom: isFollowed == true
                      ? AppBar(
                          toolbarHeight: 45,
                          backgroundColor: AppColor.surfaceBackgroundColor,
                          surfaceTintColor: AppColor.surfaceBackgroundColor,
                          leading: const SizedBox.shrink(),
                          leadingWidth: 0,
                          titleSpacing: 0,
                          elevation: 0,
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(2),
                                  margin: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  decoration: BoxDecoration(
                                      color: AppColor
                                          .surfaceBackgroundSecondaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TabBar(
                                      controller: _tabController,
                                      labelPadding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicator: BoxDecoration(
                                          color:
                                              AppColor.surfaceBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      tabs: [
                                        Text(
                                          'All',
                                          style: AppTypography.label14SM
                                              .copyWith(
                                                  color: AppColor
                                                      .textEmphasisColor),
                                        ),
                                        Text(
                                          'Followed',
                                          style: AppTypography.label14SM
                                              .copyWith(
                                                  color: AppColor
                                                      .textEmphasisColor),
                                        )
                                      ])),
                            ],
                          ),
                        )
                      : null),
              body: Column(
                children: [
                  1.height(),
                  Expanded(
                    child: TabBarView(
                      physics: isFollowed == false
                          ? const NeverScrollableScrollPhysics()
                          : null,
                      controller: _tabController,
                      children: [
                        FirstTabWidget(
                          followTrainingData: followTrainingData,
                          key: const PageStorageKey("page1"),
                          searchControllerPage1: _searchControllerPage1,
                          confirmedFilter: confirmedFilter,
                          requestCall: () {
                            getData(
                              isScroll: false,
                            );
                          },
                          isLoadMore: isLoadMore,
                          isLoadingNotifier: isLoadingNotifier,
                          isNodData: isNodData,
                          // isSubtitleLoading: isSubtitleLoading,
                          listTrainingPLanData: listTrainingPLanData,
                          nextPage: nextPage,
                          scrollControllerPage1: _scrollControllerPage1,
                          showCloseIcon: showCloseIcon,
                          searchDelayFn: (value) {
                            CategoryListController.delayedFunction(fn: () {
                              getData(
                                isScroll: false,
                              );
                            });
                          },
                          fitnessGoalData: fitnessGoalData,
                        ),
                        isFollowed == false
                            ? Container()
                            : SecondTabWidget(
                                box: box,
                                scrollControllerPage2: _scrollControllerPage2,
                                searchControllerPage2: _searchControllerPage2,
                                followedConfirmedFilter:
                                    followedConfirmedFilter,
                                isNodData: isNodData,
                                followTrainingData: followTrainingData
                                    as List<FollowTrainingplanModel>),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }

  Text titleWidget() {
    return Text(
      "Training Plans",
      style:
          AppTypography.label18LG.copyWith(color: AppColor.textEmphasisColor),
    );
  }

  void getData({
    required bool isScroll,
  }) async {
    setState(() {
      isNodData = false;

      if (isScroll == false) {
        listTrainingPLanData.clear();
        tempListTrainingPLanData.clear();
        fitnessGoalData.clear();
        pageNumber = 0;
      }
      // isSubtitleLoading.value = isScroll == true ? false : true;
      isLoadingNotifier = isScroll == true ? false : true;
    });
    try {
      await CategoryListController.getListTrainingPlanData(
        context,
        confirmedFilter: confirmedFilter,
        mainSearch: _searchControllerPage1.text == ""
            ? null
            : _searchControllerPage1.text,
        pageNumber: pageNumber.toString(),
      ).then((value) async {
        if (value != null && value.isNotEmpty) {
          nextPage = true;
          isLoadMore = false;

          tempListTrainingPLanData.addAll(value);

          CommonController.getFilterFitnessGoalData(context,
              shouldBreakLoop: shouldBreakLoop,
              trainingPlanData: tempListTrainingPLanData,
              filterFitnessGoalData: fitnessGoalData);
          listTrainingPLanData.addAll(value);
          isLoadingNotifier = isScroll == true ? false : false;
          setState(() {});

          // isSubtitleLoading.value = isScroll == true ? false : false;
        } else if (value?.isEmpty ?? false) {
          nextPage = false;
          isLoadMore = false;
          isLoadingNotifier = isScroll == true ? false : false;
          setState(() {
            // isSubtitleLoading.value = isScroll == true ? false : false;
          });
        } else if (value == null) {
          setState(() {
            isLoadMore = false;
            isNodData = true;
            nextPage = true;

            // isSubtitleLoading.value = isScroll == true ? false : false;
            isLoadingNotifier = isScroll == true ? false : false;
          });
        }
      });
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
  }
}

class SecondTabWidget extends StatefulWidget {
  final Box<FollowTrainingplanModel> box;

  final ScrollController scrollControllerPage2;
  final TextEditingController searchControllerPage2;
  final ValueNotifier<List<TypeFilterModel>> followedConfirmedFilter;
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
                        .addAll(CategoryListController.searchFilterLocal(
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
                            CategoryListController.deleteAFilter(
                                context,
                                e.filter.toString(),
                                widget.followedConfirmedFilter);
                            widget.followTrainingData.clear();
                            widget.followTrainingData =
                                widget.box.values.toList();
                            setState(() {});
                          },
                          hideOnTap: () {
                            CategoryListController.hideAllFilter();
                            setState(() {});
                          },
                          showOnTap: () {
                            CategoryListController.showAllFiltter();
                            setState(() {});
                          },
                          clearOnTap: () {
                            CategoryListController.clearAppliedFilter(
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

class FollowSubtitleWidget extends StatelessWidget {
  FollowTrainingplanModel followTrainingData;
  FollowSubtitleWidget({super.key, required this.followTrainingData});
  String calculatePercentage(
    int current,
    int total,
  ) {
    double percentage = (current / total) * 100;
    return "${percentage.toStringAsFixed(1)} %";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: AppColor.buttonPrimaryColor, shape: BoxShape.circle),
          child: Icon(Icons.check, size: 14, color: AppColor.buttonLabelColor),
        ),
        4.width(),
        Text('Following',
            style: AppTypography.label14SM
                .copyWith(color: AppColor.buttonPrimaryColor)),
        Text(
          " • ",
          style: AppTypography.label16MD
              .copyWith(color: AppColor.textPrimaryColor),
        ),
        Text(
          calculatePercentage(followTrainingData.workoutCount.toInt(),
              followTrainingData.totalWorkoutLength.toInt()),
          style: AppTypography.paragraph14MD
              .copyWith(color: AppColor.textPrimaryColor),
        )
      ],
    );
  }
}

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
  final ValueNotifier<List<TypeFilterModel>> confirmedFilter;
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
                            CategoryListController.deleteAFilter(context,
                                e.filter.toString(), widget.confirmedFilter);
                            widget.requestCall();
                          },
                          hideOnTap: () {
                            CategoryListController.hideAllFilter();
                            setState(() {});
                          },
                          showOnTap: () {
                            CategoryListController.showAllFiltter();
                            setState(() {});
                          },
                          clearOnTap: () {
                            CategoryListController.clearAppliedFilter(
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
