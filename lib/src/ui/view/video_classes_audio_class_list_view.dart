import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/src/ui/view/training_plan_detail_view.dart';
import 'package:ui_tool_kit/src/ui/view/workout_detail_view.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideoAudioClassesListView extends StatefulWidget {
  final CategoryName categoryName;
  const VideoAudioClassesListView({super.key, required this.categoryName});

  @override
  State<VideoAudioClassesListView> createState() =>
      _VideoAudioClassesListViewState();
}

class _VideoAudioClassesListViewState extends State<VideoAudioClassesListView> {
  late TextEditingController _searchController;
  late ScrollController _scrollController;
  int pageNumber = 0;

  List<OnDemandModel> listOndemandData = [];
  List<WorkoutModel> listWorkoutData = [];

  bool nextPage = true;
  bool showCloseIcon = false;
  bool isLoadMore = false;
  bool isNodData = false;

  bool isLoadingNotifier = false;
  ValueNotifier<List<TypeFilterModel>> confirmedFilter = ValueNotifier([]);

  @override
  void initState() {
    _searchController = TextEditingController();

    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        getData(categoryName: widget.categoryName);
        _scrollController.addListener(
          () {
            if (isLoadMore == false &&
                nextPage == true &&
                _scrollController.position.extentAfter < 300) {
              isLoadMore = true;

              pageNumber += 1;
              getData(isScroll: true, categoryName: widget.categoryName);
            }
          },
        );
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    CategoryListController.onDemandfiltersData.clear();
    super.dispose();
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
          body: Column(
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
                      Row(
                        children: [
                          Expanded(
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
                                    getData(
                                        categoryName: widget.categoryName,
                                        isFilter: true);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(right: 20),
                                    child: Text('Cancel',
                                        style: AppTypography.label14SM.copyWith(
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
                child: Stack(
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
                                  CategoryListController.deleteAFilter(context,
                                      e.filter.toString(), confirmedFilter);
                                  getData(
                                      categoryName: widget.categoryName,
                                      isFilter: true);
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
                                      confirmedFilter);
                                  getData(
                                      categoryName: widget.categoryName,
                                      isFilter: true);
                                },
                              );
                            },
                          ),
                          if (nextPage == true && isLoadingNotifier == false)
                            isNodData == true
                                ? const CustomErrorWidget()
                                : Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.textInvertEmphasis,
                                      ),
                                      child: ListView.separated(
                                          key: const PageStorageKey("page1"),
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
                                                  widget.categoryName ==
                                                          CategoryName
                                                              .videoClasses
                                                      ? context.navigateTo(
                                                          VideoDetailView(
                                                              id: listOndemandData[
                                                                      index]
                                                                  .id))
                                                      : widget.categoryName ==
                                                              CategoryName
                                                                  .workouts
                                                          ? context.navigateTo(
                                                              WorkoutDetailView(
                                                                  id: listWorkoutData[
                                                                          index]
                                                                      .id
                                                                      .toString()))
                                                          : context.navigateTo(
                                                              VideoDetailView(
                                                                  id: listOndemandData[
                                                                          index]
                                                                      .id));
                                                  // context.navigateToNamed(routeName, arguments: argument);
                                                },
                                                imageHeaderIcon: widget
                                                            .categoryName ==
                                                        CategoryName.workouts
                                                    ? AppAssets
                                                        .workoutHeaderIcon
                                                    : AppAssets.videoPlayIcon,
                                                imageUrl: CategoryListController
                                                    .imageUrl(
                                                  index: index,
                                                  categoryName:
                                                      widget.categoryName,
                                                  listOndemandData:
                                                      listOndemandData,
                                                  listWorkoutData:
                                                      listWorkoutData,
                                                ),
                                                subtitle: Text(
                                                  CategoryListController
                                                      .subtitle(
                                                    index: index,
                                                    categoryName:
                                                        widget.categoryName,
                                                    listOndemandData:
                                                        listOndemandData,
                                                    listWorkoutData:
                                                        listWorkoutData,
                                                  ),
                                                  style: AppTypography
                                                      .paragraph14MD
                                                      .copyWith(
                                                          color: AppColor
                                                              .textPrimaryColor),
                                                ),
                                                title: CategoryListController
                                                    .title(
                                                  index: index,
                                                  categoryName:
                                                      widget.categoryName,
                                                  listOndemandData:
                                                      listOndemandData,
                                                  listWorkoutData:
                                                      listWorkoutData,
                                                ));
                                          },
                                          separatorBuilder: (context, index) {
                                            return CustomDivider(
                                              endIndent:
                                                  context.dynamicWidth * 0.02,
                                              indent:
                                                  context.dynamicWidth * 0.22,
                                            );
                                          },
                                          itemCount:
                                              CategoryListController.itemCount(
                                            categoryName: widget.categoryName,
                                            listOndemandData: listOndemandData,
                                            listWorkoutData: listWorkoutData,
                                          )),
                                    ),
                                  ),
                          if (isLoadMore == true)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: BaseHelper.loadingWidget(),
                              ),
                            ),
                          if (nextPage == false && isLoadingNotifier == false)
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
              ),
            ],
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

                    getData(categoryName: widget.categoryName, isFilter: true);
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
              getData(
                  categoryName: widget.categoryName,
                  isFilter: true,
                  mainSearch: value.isEmpty ? null : value);
            });
          },
          onIconTap: () {
            context.hideKeypad();
            _searchController.clear();
            showCloseIcon = false;
            getData(categoryName: widget.categoryName, isFilter: true);
          },
          searchController: _searchController),
    );
  }

  Text titleWidget() {
    return Text(
      widget.categoryName == CategoryName.videoClasses
          ? "Video Classes"
          : widget.categoryName == CategoryName.workouts
              ? "Workouts"
              : widget.categoryName == CategoryName.trainingPLans
                  ? "Training Plans"
                  : widget.categoryName == CategoryName.audioClasses
                      ? "Audio Classes"
                      : '',
      style:
          AppTypography.label18LG.copyWith(color: AppColor.textEmphasisColor),
    );
  }

  void getData(
      {required CategoryName categoryName,
      bool? isScroll,
      bool? isFilter,
      String? mainSearch}) async {
    setState(() {
      isNodData = false;

      if (isFilter == true) {
        listOndemandData.clear();
        listWorkoutData.clear();

        pageNumber = 0;
      }

      isLoadingNotifier = isScroll == true ? false : true;
    });

    categoryName == CategoryName.videoClasses
        ? await CategoryListController.getListOnDemandData(
            context,
            confirmedFilter: confirmedFilter,
            mainSearch: mainSearch,
            pageNumber: pageNumber.toString(),
          ).then((value) {
            if (value != null && value.isNotEmpty) {
              setState(() {
                nextPage = true;
                isLoadMore = false;

                listOndemandData.addAll(value);
                isLoadingNotifier = isScroll == true ? false : false;
              });
            } else if (value?.isEmpty ?? false) {
              setState(() {
                nextPage = false;

                isLoadingNotifier = isScroll == true ? false : false;
              });
            } else if (value == null) {
              setState(() {
                isLoadMore = false;
                isNodData = true;
                nextPage = true;
                isLoadingNotifier = isScroll == true ? false : false;
              });
            }
          })
        : categoryName == CategoryName.workouts
            ? await CategoryListController.getListWorkoutData(
                context,
                confirmedFilter: confirmedFilter,
                mainSearch: mainSearch,
                pageNumber: pageNumber.toString(),
              ).then((value) {
                if (value != null && value.isNotEmpty) {
                  setState(() {
                    nextPage = true;
                    isLoadMore = false;
                    listWorkoutData.addAll(value);
                    isLoadingNotifier = isScroll == true ? false : false;
                  });
                } else if (value?.isEmpty ?? false) {
                  setState(() {
                    nextPage = false;

                    isLoadingNotifier = isScroll == true ? false : false;
                  });
                } else if (value == null) {
                  setState(() {
                    isLoadMore = false;
                    isNodData = true;
                    nextPage = true;
                    isLoadingNotifier = isScroll == true ? false : false;
                  });
                }
              })
            : CategoryListController.getListOnDemandAudioData(
                context,
                confirmedFilter: confirmedFilter,
                mainSearch: mainSearch,
                pageNumber: pageNumber.toString(),
              ).then((value) {
                if (value != null && value.isNotEmpty) {
                  setState(() {
                    nextPage = true;
                    isLoadMore = false;

                    listOndemandData.addAll(value);
                    isLoadingNotifier = isScroll == true ? false : false;
                  });
                }
                if (value?.isEmpty ?? false) {
                  setState(() {
                    nextPage = false;

                    isLoadingNotifier = isScroll == true ? false : false;
                  });
                }
                if (value == null) {
                  setState(() {
                    isLoadMore = false;
                    isNodData = true;
                    nextPage = true;
                    isLoadingNotifier = isScroll == true ? false : false;
                  });
                }
              });
  }
}
