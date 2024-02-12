import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funxtion/funxtion_sdk.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';

class VideoAudioWorkoutListView extends StatefulWidget {
  final CategoryName categoryName;
  const VideoAudioWorkoutListView({super.key, required this.categoryName});

  @override
  State<VideoAudioWorkoutListView> createState() =>
      _VideoAudioWorkoutListViewState();
}

class _VideoAudioWorkoutListViewState extends State<VideoAudioWorkoutListView> {
  late TextEditingController _searchController;
  late ScrollController _scrollController;
  int pageNumber = 0;

  List<OnDemandModel> listOndemandData = [];
  List<WorkoutModel> listWorkoutData = [];

  bool nextPage = true;

  bool isLoadMore = false;
  bool isNodData = false;

  bool isLoadingNotifier = false;
  ValueNotifier<List<TypeFilterModel>> confirmedFilter = ValueNotifier([]);
  // ValueNotifier<bool> typeLoader = ValueNotifier(true);
  Map<int, String> onDemandCategoryVideoData = {};
  Map<int, String> onDemandCategoryAudioData = {};
  Map<int, String> categoryTypeData = {};
  @override
  void initState() {
  
    _searchController = TextEditingController();

    _scrollController = ScrollController();

    getData(categoryName: widget.categoryName, isScroll: false);

    _scrollController.addListener(
      () {
        if (isLoadMore == false &&
            nextPage == true &&
            _scrollController.position.extentAfter < 300 &&
            _scrollController.position.extentAfter != 0.0) {
          isLoadMore = true;

          pageNumber += 10;
          getData(
            categoryName: widget.categoryName,
            isScroll: true,
          );
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    // CategoryListController.filterCategoryTypeData.clear();
    ListController.filterListData.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: AppBar(
                surfaceTintColor: AppColor.surfaceBackgroundColor,
                titleSpacing: 0,
                leadingWidth: 75,
                leading: Navigator.of(context).canPop()
                    ? GestureDetector(
                        onTap: () {
                          context.maybePopPage();
                        },
                        child: Transform.scale(
                          scale: 1.2,
                          child: SvgPicture.asset(
                            AppAssets.backArrowIcon,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                backgroundColor: AppColor.surfaceBackgroundColor,
                elevation: 0.0,
                title: HeaderTitleWIdget(
                  categoryName: widget.categoryName,
                ),
                centerTitle: true,
                bottom: bottomAppBar())),
        backgroundColor: AppColor.borderOutlineColor,
        body: Column(
          children: [
            1.height(),
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
                                ListController.deleteAFilter(context,
                                    e.filter.toString(), confirmedFilter);
                                getData(
                                    categoryName: widget.categoryName,
                                    isScroll: false);
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
                                    confirmedFilter);
                                getData(
                                    categoryName: widget.categoryName,
                                    isScroll: false);
                              },
                            );
                          },
                        ),
                        if (isLoadingNotifier == false)
                          isNodData == true
                              ? const CustomErrorWidget()
                              : ListController.chekList(
                                          categoryName: widget.categoryName,
                                          listOndemandData: listOndemandData,
                                          listWorkoutData: listWorkoutData)!
                                      .isEmpty
                                  ? const NoResultFOundWIdget()
                                  : Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColor.textInvertEmphasis,
                                        ),
                                        child: ListView.separated(
                                            // key: const PageStorageKey("page"),
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
                                              return Column(
                                                children: [
                                                  CustomListtileWidget(
                                                      onTap: () {
                                                        context.hideKeypad();
                                                        checkAndNavigateFn(
                                                            context, index);
                                                      },
                                                      imageHeaderIcon: widget
                                                                  .categoryName ==
                                                              CategoryName
                                                                  .workouts
                                                          ? AppAssets
                                                              .workoutHeaderIcon
                                                          : widget.categoryName ==
                                                                  CategoryName
                                                                      .audioClasses
                                                              ? AppAssets
                                                                  .headPhoneIcon
                                                              : AppAssets
                                                                  .videoPlayIcon,
                                                      imageUrl: ListController
                                                          .imageUrl(
                                                        index: index,
                                                        categoryName:
                                                            widget.categoryName,
                                                        listOndemandData:
                                                            listOndemandData,
                                                        listWorkoutData:
                                                            listWorkoutData,
                                                      ),
                                                      subtitle: ListController
                                                          .subtitle(
                                                        categoryTypeData:
                                                            categoryTypeData,
                                                        onDemandCategoryAudioData:
                                                            onDemandCategoryAudioData,
                                                        onDemandCategoryVideoData:
                                                            onDemandCategoryVideoData,
                                                        index: index,
                                                        categoryName:
                                                            widget.categoryName,
                                                        listOndemandData:
                                                            listOndemandData,
                                                        listWorkoutData:
                                                            listWorkoutData,
                                                      ),
                                                      title:
                                                          ListController.title(
                                                        index: index,
                                                        categoryName:
                                                            widget.categoryName,
                                                        listOndemandData:
                                                            listOndemandData,
                                                        listWorkoutData:
                                                            listWorkoutData,
                                                      )),
                                                  if (index ==
                                                          ListController.chekList(
                                                                      categoryName:
                                                                          widget
                                                                              .categoryName,
                                                                      listOndemandData:
                                                                          listOndemandData,
                                                                      listWorkoutData:
                                                                          listWorkoutData)!
                                                                  .length -
                                                              1 &&
                                                      nextPage == false)
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .all(8.0)
                                                          .copyWith(top: 12),
                                                      child: Text(
                                                        "Nothing to load",
                                                        style: AppTypography
                                                            .label14SM,
                                                      ),
                                                    )
                                                ],
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 12, bottom: 12),
                                                child:
                                                    CustomDivider(indent: 102),
                                              );
                                            },
                                            itemCount: ListController.itemCount(
                                              categoryName: widget.categoryName,
                                              listOndemandData:
                                                  listOndemandData,
                                              listWorkoutData: listWorkoutData,
                                            )),
                                      ),
                                    ),
                        if (isLoadMore == true)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: BaseHelper.loadingWidget(),
                            ),
                          ),
                      ]),
                  if (isLoadingNotifier) ...[
                    ModalBarrier(
                        dismissible: false,
                        color: AppColor.surfaceBackgroundColor),
                    Center(child: BaseHelper.loadingWidget()),
                  ]
                ],
              ),
            ),
          ],
        ));
  }

  bottomAppBar() {
    return AppBar(
      surfaceTintColor: AppColor.surfaceBackgroundColor,
      elevation: 0,
      backgroundColor: AppColor.surfaceBackgroundColor,
      leadingWidth: 0,
      titleSpacing: 0,
      leading: const SizedBox.shrink(),
      title: CustomSearchTextFieldWidget(
          showCloseIcon: _searchController.text.isNotEmpty,
          onChange: (value) {
            ListController.delayedFunction(fn: () {
              getData(
                categoryName: widget.categoryName,
                isScroll: false,
              );
            });
          },
          onIconTap: () {
            _searchController.clear();

            getData(categoryName: widget.categoryName, isScroll: false);
          },
          searchController: _searchController),
      actions: [
        _searchController.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  context.hideKeypad();
                  _searchController.clear();

                  ListController.clearAppliedFilter(confirmedFilter);

                  getData(categoryName: widget.categoryName, isScroll: false);
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
            : iconFilterWidget(context)
      ],
    );
  }

  iconFilterWidget(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.hideKeypad();
        await showModalBottomSheet(
          useSafeArea: true,
          enableDrag: false,
          isDismissible: false,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          backgroundColor: AppColor.surfaceBackgroundBaseColor,
          isScrollControlled: true,
          context: context,
          builder: (_) {
            return PopScope(
              canPop: false,
              child: FilterSheetWidget(
                  confirmedFilter: confirmedFilter,
                  onDone: (value) {
                    if (value.isNotEmpty ||
                        ListController.restConfirmFilterAlso == true) {
                      ListController.restConfirmFilterAlso = false;
                      ListController.confirmFilter(
                          confirmedFilter: confirmedFilter,
                          selectedFilter: value);
                      getData(
                          categoryName: widget.categoryName, isScroll: false);
                    }
                  },
                  categoryName: widget.categoryName),
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

  void checkAndNavigateFn(BuildContext context, int index) {
    if (widget.categoryName == CategoryName.videoClasses) {
      context.navigateTo(VideoAudioDetailView(id: listOndemandData[index].id));
    } else if (widget.categoryName == CategoryName.workouts) {
      context.navigateTo(
          WorkoutDetailView(id: listWorkoutData[index].id.toString()));
    } else if (widget.categoryName == CategoryName.audioClasses) {
      context.navigateTo(VideoAudioDetailView(id: listOndemandData[index].id));
    }
  }

  void getData({
    required CategoryName categoryName,
    required bool isScroll,
  }) async {
    setState(() {
      isNodData = false;

      if (isScroll == false) {
        listOndemandData.clear();
        listWorkoutData.clear();
        onDemandCategoryAudioData.clear();
        onDemandCategoryVideoData.clear();
        categoryTypeData.clear();
        pageNumber = 0;
      }

      isLoadingNotifier = isScroll == true ? false : true;
    });

    categoryName == CategoryName.videoClasses
        ? await ListController.getListOnDemandData(
            context,
            confirmedFilter: confirmedFilter,
            mainSearch:
                _searchController.text == "" ? null : _searchController.text,
            pageNumber: pageNumber,
          ).then((value) {
            if (value != null && value.isNotEmpty) {
              nextPage = true;
              isLoadMore = false;

              listOndemandData.addAll(value);
              int count = onDemandCategoryVideoData.length;
              CommonController.getListFilterOnDemandCategoryTypeFn(
                  count, value, onDemandCategoryVideoData);
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
          })
        : categoryName == CategoryName.workouts
            ? await ListController.getListWorkoutData(
                context,
                confirmedFilter: confirmedFilter,
                mainSearch: _searchController.text == ""
                    ? null
                    : _searchController.text,
                pageNumber: pageNumber,
              ).then((value) {
                if (value != null && value.isNotEmpty) {
                  CommonController.filterCategoryTypeData(
                      value, categoryTypeData);

                  setState(() {
                    nextPage = true;
                    isLoadMore = false;
                    listWorkoutData.addAll(value);
                    isLoadingNotifier = isScroll == true ? false : false;
                  });
                } else if (value?.isEmpty ?? false) {
                  setState(() {
                    nextPage = false;
                    isLoadMore = false;
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
            : ListController.getListOnDemandAudioData(
                context,
                confirmedFilter: confirmedFilter,
                mainSearch: _searchController.text == ""
                    ? null
                    : _searchController.text,
                pageNumber: pageNumber,
              ).then((value) {
                if (value != null && value.isNotEmpty) {
                  int count = onDemandCategoryAudioData.length;
                  CommonController.getListFilterOnDemandCategoryTypeFn(
                      count, value, onDemandCategoryAudioData);
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
                    isLoadMore = false;
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
