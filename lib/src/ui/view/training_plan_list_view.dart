import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ui_tool_kit/src/helper/boxes.dart';
import 'package:ui_tool_kit/src/ui/view/training_plan_detail_view.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../model/follow_trainingplan_model.dart';

class TrainingPlanListView extends StatefulWidget {
  final CategoryName categoryName;
  const TrainingPlanListView({super.key, required this.categoryName});

  @override
  State<TrainingPlanListView> createState() =>
      _VideoAudioClassesListViewState();
}

class _VideoAudioClassesListViewState extends State<TrainingPlanListView> {
  late TextEditingController _searchController;
  late ScrollController _scrollController;
  int pageNumber = 1;
  Map<int, List<FitnessGoalModel>> fitnessGoalData = {};
  List<TrainingPlanModel> listTrainingPLanData = [];
  bool nextPage = true;
  bool showCloseIcon = false;
  bool isLoadMore = false;
  bool isNodData = false;
  bool shouldBreakLoop = false;
  bool isLoadingNotifier = false;

  ValueNotifier<List<TypeFilterModel>> confirmedFilter = ValueNotifier([]);
  ValueNotifier<bool> isSubtitleLoading = ValueNotifier(false);
  bool isFollowed = false;
  @override
  void initState() {
    // Boxes.getData().clear();
    checkIsFollowed();
    _searchController = TextEditingController();

    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        getData();
        _scrollController.addListener(
          () {
            if (isLoadMore == false &&
                nextPage == true &&
                _scrollController.position.extentAfter < 300) {
              isLoadMore = true;

              pageNumber += 1;
              getData(
                isScroll: true,
              );
            }
          },
        );
      },
    );

    super.initState();
  }

  checkIsFollowed() {
    isFollowed = Boxes.getData().isNotEmpty;
  }

  @override
  void dispose() {
    shouldBreakLoop = true;
    _scrollController.dispose();
    _searchController.dispose();
    CategoryListController.onDemandfiltersData.clear();
    super.dispose();
  }

  getFollowTrainingData(List<FollowTrainingplanModel> localTrainingData) {
    for (var element in localTrainingData) {
      try {
        TrainingPlanDetailController.getTrainingPlanData(context,
                id: element.trainingplanId)
            .then((value) => {});
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.surfaceBackgroundBaseColor,
          //  appBar: PreferredSize(
          // preferredSize: const Size.fromHeight(120),
          // child: AppBar(
          //   iconTheme: IconThemeData(color: AppColor.surfaceBrandDarkColor),
          //   // backgroundColor: AppColor.surfaceBackgroundColor,
          //   backgroundColor: Colors.amber,
          //   elevation: 0.4,
          //   title: titleWidget(),
          //   centerTitle: true,
          //   bottom: AppBar(
          //     elevation: 0,
          //     backgroundColor: AppColor.surfaceBackgroundColor,
          //     toolbarHeight: 80,
          //     leadingWidth: 0,
          //     titleSpacing: 0,
          //     leading: const SizedBox.shrink(),
          //     title: bottomTitleWidget(context),
          //     actions: [
          //       showCloseIcon == true
          //           ? InkWell(
          //               onTap: () {
          //                 context.hideKeypad();
          //                 _searchController.clear();
          //                 showCloseIcon = false;
          //                 CategoryListController.clearAppliedFilter(
          //                     confirmedFilter);
          //                 getData(
          //                     categoryName: widget.categoryName,
          //                     isFilter: true);
          //               },
          //               child: Container(
          //                 alignment: Alignment.center,
          //                 margin: const EdgeInsets.only(
          //                     top: 15, bottom: 15, right: 20),
          //                 child: Text('Cancel',
          //                     style: AppTypography.label14SM.copyWith(
          //                       color: AppColor.textEmphasisColor,
          //                     )),
          //               ),
          //             )
          //           : iconFilterSheetWidget(context)
          //     ],
          //   ),
          // )),
          body: DefaultTabController(
            length: isFollowed ? 2 : 1,
            child: Column(
              children: [
                8.height(),
                Container(
                    color: AppColor.surfaceBackgroundColor,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.maybePopPage();
                                },
                                child: const Icon(
                                  Icons.keyboard_arrow_left,
                                  size: 38,
                                ),
                              ),
                              titleWidget(),
                              Container(
                                width: 60,
                              ),
                            ],
                          ),
                        ),
                        if (isFollowed)
                          Container(
                              padding: const EdgeInsets.all(4),
                              margin: const EdgeInsets.only(
                                top: 12,
                                left: 20,
                                right: 20,
                              ),
                              decoration: BoxDecoration(
                                  color:
                                      AppColor.surfaceBackgroundSecondaryColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: TabBar(
                                  labelPadding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: BoxDecoration(
                                      color: AppColor.surfaceBackgroundColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  tabs: [
                                    Text(
                                      'All',
                                      style: AppTypography.label14SM.copyWith(
                                          color: AppColor.textEmphasisColor),
                                    ),
                                    Text(
                                      'Followed',
                                      style: AppTypography.label14SM.copyWith(
                                          color: AppColor.textEmphasisColor),
                                    )
                                  ])),
                        Row(
                          children: [
                            Flexible(
                              child: bottomTitleWidget(context),
                            ),
                            showCloseIcon == true
                                ? InkWell(
                                    onTap: () {
                                      context.hideKeypad();
                                      _searchController.clear();
                                      showCloseIcon = false;
                                      CategoryListController.clearAppliedFilter(
                                          confirmedFilter);
                                      getData(isFilter: true);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          bottom: 15, right: 20),
                                      child: Text('Cancel',
                                          style:
                                              AppTypography.label14SM.copyWith(
                                            color: AppColor.textEmphasisColor,
                                          )),
                                    ),
                                  )
                                : iconFilterSheetWidget(context)
                          ],
                        ),
                      ],
                    )),
                4.height(),
                Expanded(
                  child: TabBarView(
                    children: [
                      Stack(
                        children: [
                          Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: confirmedFilter,
                                  builder: (context, value, child) {
                                    return FilterRowWidget(
                                      confirmedFilter: confirmedFilter,
                                      deleteAFilterOnTap: (e) {
                                        CategoryListController.deleteAFilter(
                                            context,
                                            e.filter.toString(),
                                            confirmedFilter);
                                        getData(isFilter: true);
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
                                        CategoryListController
                                            .clearAppliedFilter(
                                                confirmedFilter);
                                        getData(isFilter: true);
                                      },
                                    );
                                  },
                                ),
                                if (nextPage == true &&
                                    isLoadingNotifier == false)
                                  isNodData == true
                                      ? const CustomErrorWidget()
                                      : Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  AppColor.textInvertEmphasis,
                                            ),
                                            child: ListView.separated(
                                                key: const PageStorageKey(
                                                    "page1"),
                                                controller: _scrollController,
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
                                                                id: listTrainingPLanData[
                                                                        index]
                                                                    .id));
                                                      },
                                                      imageHeaderIcon: AppAssets
                                                          .videoPlayIcon,
                                                      imageUrl:
                                                          listTrainingPLanData[
                                                                  index]
                                                              .image
                                                              .toString(),
                                                      subtitle:
                                                          ValueListenableBuilder(
                                                              valueListenable:
                                                                  isSubtitleLoading,
                                                              builder: (_,
                                                                  value,
                                                                  child) {
                                                                return RichText(
                                                                    text: TextSpan(
                                                                        style: AppTypography
                                                                            .paragraph14MD
                                                                            .copyWith(color: AppColor.textPrimaryColor),
                                                                        children: [
                                                                      TextSpan(
                                                                          text:
                                                                              "${listTrainingPLanData[index].daysTotal} workouts"),
                                                                      value ==
                                                                              true
                                                                          ? WidgetSpan(
                                                                              child: BaseHelper.loadingWidget())
                                                                          : TextSpan(text: " • ${fitnessGoalData.entries.toList()[index].value.map((e) => e.name).join(',')}"),
                                                                      TextSpan(
                                                                          text:
                                                                              " • ${listTrainingPLanData[index].level}"),
                                                                    ]));
                                                              }),
                                                      title:
                                                          listTrainingPLanData[
                                                                  index]
                                                              .title
                                                              .toString());
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return CustomDivider(
                                                    endIndent:
                                                        context.dynamicWidth *
                                                            0.02,
                                                    indent:
                                                        context.dynamicWidth *
                                                            0.22,
                                                  );
                                                },
                                                itemCount: listTrainingPLanData
                                                    .length),
                                          ),
                                        ),
                                if (isLoadMore == true)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: BaseHelper.loadingWidget(),
                                    ),
                                  ),
                                if (nextPage == false &&
                                    isLoadingNotifier == false)
                                  noResultFoundWidget(),
                              ]),
                          if (isLoadingNotifier)
                            ModalBarrier(
                                dismissible: false,
                                color: AppColor.surfaceBackgroundColor),
                          if (isLoadingNotifier)
                            Center(child: BaseHelper.loadingWidget()),
                        ],
                      ),
                      if (isFollowed)
                        ValueListenableBuilder(
                            valueListenable: Boxes.getData().listenable(),
                            builder: (_, value, child) {
                              getFollowTrainingData(value.values.toList());
                              return Stack(
                                children: [
                                  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ValueListenableBuilder(
                                          valueListenable: confirmedFilter,
                                          builder: (context, value, child) {
                                            return FilterRowWidget(
                                              confirmedFilter: confirmedFilter,
                                              deleteAFilterOnTap: (e) {
                                                CategoryListController
                                                    .deleteAFilter(
                                                        context,
                                                        e.filter.toString(),
                                                        confirmedFilter);
                                                getData(isFilter: true);
                                              },
                                              hideOnTap: () {
                                                CategoryListController
                                                    .hideAllFilter();
                                                setState(() {});
                                              },
                                              showOnTap: () {
                                                CategoryListController
                                                    .showAllFiltter();
                                                setState(() {});
                                              },
                                              clearOnTap: () {
                                                CategoryListController
                                                    .clearAppliedFilter(
                                                        confirmedFilter);
                                                getData(isFilter: true);
                                              },
                                            );
                                          },
                                        ),
                                        if (nextPage == true &&
                                            isLoadingNotifier == false)
                                          isNodData == true
                                              ? const CustomErrorWidget()
                                              : Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColor
                                                          .textInvertEmphasis,
                                                    ),
                                                    child: ListView.separated(
                                                        key:
                                                            const PageStorageKey(
                                                                "page2"),
                                                        controller:
                                                            _scrollController,
                                                        keyboardDismissBehavior:
                                                            ScrollViewKeyboardDismissBehavior
                                                                .onDrag,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 20,
                                                                left: 20,
                                                                right: 20,
                                                                bottom: 20),
                                                        itemBuilder:
                                                            (context, index) {
                                                          return CustomListtileWidget(
                                                              onTap: () {
                                                                context
                                                                    .hideKeypad();
                                                                context.navigateTo(
                                                                    TrainingPlanDetailView(
                                                                        id: listTrainingPLanData[index]
                                                                            .id));
                                                              },
                                                              imageHeaderIcon:
                                                                  AppAssets
                                                                      .videoPlayIcon,
                                                              imageUrl:
                                                                  listTrainingPLanData[
                                                                          index]
                                                                      .image
                                                                      .toString(),
                                                              subtitle:
                                                                  ValueListenableBuilder(
                                                                      valueListenable:
                                                                          isSubtitleLoading,
                                                                      builder: (_,
                                                                          value,
                                                                          child) {
                                                                        return value ==
                                                                                true
                                                                            ? BaseHelper.loadingWidget()
                                                                            : Text(
                                                                                "${listTrainingPLanData[index].daysTotal} workouts • ${fitnessGoalData.entries.toList()[index].value.map((e) => e.name).join(',')} • ${listTrainingPLanData[index].level}",
                                                                                style: AppTypography.paragraph14MD.copyWith(color: AppColor.textPrimaryColor),
                                                                              );
                                                                      }),
                                                              title: listTrainingPLanData[
                                                                      index]
                                                                  .title
                                                                  .toString());
                                                        },
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return CustomDivider(
                                                            endIndent: context
                                                                    .dynamicWidth *
                                                                0.02,
                                                            indent: context
                                                                    .dynamicWidth *
                                                                0.22,
                                                          );
                                                        },
                                                        itemCount:
                                                            listTrainingPLanData
                                                                .length),
                                                  ),
                                                ),
                                        if (isLoadMore == true)
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: BaseHelper.loadingWidget(),
                                            ),
                                          ),
                                        if (nextPage == false &&
                                            isLoadingNotifier == false)
                                          noResultFoundWidget(),
                                      ]),
                                  if (isLoadingNotifier)
                                    ModalBarrier(
                                        dismissible: false,
                                        color: AppColor.surfaceBackgroundColor),
                                  if (isLoadingNotifier)
                                    Center(child: BaseHelper.loadingWidget()),
                                ],
                              );
                            }),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  noResultFoundWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No Results',
            style: AppTypography.title18LG,
          ),
          5.height(),
          Text(
            "We couldn’t find anything",
            style: AppTypography.paragraph14MD
                .copyWith(color: AppColor.textPrimaryColor),
          )
        ],
      ),
    );
  }

  InkWell iconFilterSheetWidget(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.hideKeypad();
        await showModalBottomSheet(
          useSafeArea: true,
          enableDrag: false,
          isDismissible: false,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: AppColor.surfaceBackgroundBaseColor,
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return WillPopScope(
              child: FilterSheetWidget(
                confirmedFilter: confirmedFilter,
                onDone: (value) {
                  if (value.isNotEmpty ||
                      CategoryListController.restConfirmFilterAlso == true) {
                    CategoryListController.restConfirmFilterAlso = false;
                    CategoryListController.confirmFilter(
                        confirmedFilter: confirmedFilter,
                        selectedFilter: value);

                    getData(isFilter: true);
                  }
                },
                categoryName: widget.categoryName,
              ),
              onWillPop: () async {
                return false;
              },
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
        decoration: BoxDecoration(
            color: confirmedFilter.value.isEmpty
                ? null
                : AppColor.textEmphasisColor,
            borderRadius: BorderRadius.circular(12)),
        child: SvgPicture.asset(AppAssets.iconFilter,
            color: confirmedFilter.value.isEmpty
                ? AppColor.textEmphasisColor
                : AppColor.textInvertEmphasis),
      ),
    );
  }

  Container bottomTitleWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 24, right: 10, bottom: 10),
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: AppColor.surfaceBackgroundSecondaryColor,
          // color: Colors.red,
          borderRadius: BorderRadius.circular(12)),
      child: CustomSearchTextFieldWidget(
          showCloseIcon: showCloseIcon,
          onChange: (value) {
            showCloseIcon = value.isEmpty ? false : true;

            CategoryListController.delayedFunction(fn: () {
              log("value is $value");
              getData(isFilter: true, mainSearch: value.isEmpty ? null : value);
            });
          },
          onIconTap: () {
            context.hideKeypad();
            _searchController.clear();
            showCloseIcon = false;
            getData(isFilter: true);
          },
          searchController: _searchController),
    );
  }

  Text titleWidget() {
    return Text(
      "Training Plans",
      style:
          AppTypography.label18LG.copyWith(color: AppColor.textEmphasisColor),
    );
  }

  void getData({bool? isScroll, bool? isFilter, String? mainSearch}) async {
    setState(() {
      isNodData = false;

      if (isFilter == true) {
        listTrainingPLanData.clear();
        pageNumber = 1;
      }
      isSubtitleLoading.value = isScroll == true ? false : true;
      isLoadingNotifier = isScroll == true ? false : true;
    });

    await CategoryListController.getListTrainingPlanData(
      context,
      confirmedFilter: confirmedFilter,
      mainSearch: mainSearch,
      pageNumber: pageNumber.toString(),
    ).then((value) async {
      if (value != null && value.isNotEmpty) {
        setState(() {
          nextPage = true;
          isLoadMore = false;
          listTrainingPLanData.addAll(value);

          isLoadingNotifier = isScroll == true ? false : false;
        });
        await getGoalData(value);
        isSubtitleLoading.value = isScroll == true ? false : false;
      } else if (value?.isEmpty ?? false) {
        setState(() {
          nextPage = false;
          isSubtitleLoading.value = isScroll == true ? false : false;
          isLoadingNotifier = isScroll == true ? false : false;
        });
      } else if (value == null) {
        setState(() {
          isLoadMore = false;
          isNodData = true;
          nextPage = true;
          isSubtitleLoading.value = isScroll == true ? false : false;
          isLoadingNotifier = isScroll == true ? false : false;
        });
      }
    });
  }

  getGoalData(List<TrainingPlanModel> listTrainingPLanData) async {
    int count = fitnessGoalData.keys.length;

    for (int j = count; j - count < listTrainingPLanData.length; j++) {
      Set<FitnessGoalModel> listOfFitnessGoal = {};
      for (var i = 0; i < listTrainingPLanData[j - count].goals.length; i++) {
        await FitnessGoalRequest.fitnessGoalById(
                id: listTrainingPLanData[j - count].goals[i].toString())
            .then((value) {
          if (value != null) {
            FitnessGoalModel fetchData = FitnessGoalModel.fromJson(value);
            listOfFitnessGoal.add(fetchData);
          }
        });
        if (shouldBreakLoop == true) {
          break;
        }
      }
      if (shouldBreakLoop == true) {
        break;
      }

      fitnessGoalData[j] = listOfFitnessGoal.toList();
    }

    log("$fitnessGoalData");
  }
}
