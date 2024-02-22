import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';

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

  ValueNotifier<List<SelectedFilterModel>> confirmedFilter = ValueNotifier([]);
  ValueNotifier<List<SelectedFilterModel>> followedConfirmedFilter =
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
    ListController.filterListData.clear();
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
                                         context.loc.trainingAll,
                                          style: AppTypography.label14SM
                                              .copyWith(
                                                  color: AppColor
                                                      .textEmphasisColor),
                                        ),
                                        Text(
                                       context.loc.trainingFollow,
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
                          listTrainingPLanData: listTrainingPLanData,
                          nextPage: nextPage,
                          scrollControllerPage1: _scrollControllerPage1,
                          showCloseIcon: showCloseIcon,
                          searchDelayFn: (value) {
                            ListController.delayedFunction(fn: () {
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
   context.loc.titleText("training"),
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

      isLoadingNotifier = isScroll == true ? false : true;
    });
    try {
      await ListController.getListTrainingPlanData(
        context,
        confirmedFilter: confirmedFilter,
        mainSearch: _searchControllerPage1.text == ""
            ? null
            : _searchControllerPage1.text,
        pageNumber: pageNumber,
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
        } else if (value?.isEmpty ?? false) {
          nextPage = false;
          isLoadMore = false;
          isLoadingNotifier = isScroll == true ? false : false;
          setState(() {});
        } else if (value == null) {
          setState(() {
            isLoadMore = false;
            isNodData = true;
            nextPage = true;

            isLoadingNotifier = isScroll == true ? false : false;
          });
        }
      });
    } on RequestException catch (e) {
      if (context.mounted) {
        BaseHelper.showSnackBar(context, e.message);
      }
    }
  }
}
