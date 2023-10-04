import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:funxtion/funxtion_sdk.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';
import 'package:sliver_tools/sliver_tools.dart';

class WorkoutDetailView extends StatefulWidget {
  final String id;
  const WorkoutDetailView({
    super.key,
    required this.id,
  });

  @override
  State<WorkoutDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<WorkoutDetailView> {
  bool isLoadingNotifier = false;
  bool isNodData = false;
  late ScrollController scrollController;
  WorkoutModel? workoutData;
  FitnessGoalModel? fitnessGoalData;
  BodyPartModel? bodyPartData;
  List<ExerciseModel> exerciseData = [];
  List<ExerciseModel> exerciseWorkoutData = [];
  ValueNotifier<bool> centerTitle = ValueNotifier(false);
  ValueNotifier<bool> warmUpLoader = ValueNotifier(true);
  ValueNotifier<bool> trainingLoader = ValueNotifier(true);
  ValueNotifier<bool> goalLoader = ValueNotifier(true);
  ValueNotifier<bool> bodyPartLoader = ValueNotifier(true);

  ValueNotifier<bool> warmUpExpand = ValueNotifier(true);
  ValueNotifier<bool> trainingExpand = ValueNotifier(true);
  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        print(scrollController.offset);
        if (scrollController.offset > 155) {
          centerTitle.value = true;
        } else if (scrollController.offset < 160) {
          centerTitle.value = false;
        }
      });

    fetchData();
    // TODO: implement initState
    super.initState();
  }

  fetchData() async {
    isLoadingNotifier = true;
    isNodData = false;

    WorkoutDetailController.getworkoutData(context, id: widget.id)
        .then((value) async {
      if (value != null) {
        isLoadingNotifier = false;
        workoutData = value;

        setState(() {});
        // await Future.wait([
        //   if (workoutData?.goals.isNotEmpty ?? false)
        //     WorkoutDetailController.getGoal(
        //             context, workoutData?.goals.first.toString() ?? '')
        //         .then((value) {
        //       if (value != null) {
        //         fitnessGoalData = value;
        //         goalLoader.value = false;
        //       } else {
        //         goalLoader.value = false;
        //       }
        //     }),
        //   if (workoutData?.bodyParts.isNotEmpty ?? false)
        //     WorkoutDetailController.getBodyPart(
        //             context, workoutData?.bodyParts.first.toString() ?? "")
        //         .then((value) {
        //       if (value != null) {
        //         bodyPartData = value;
        //         bodyPartLoader.value = false;
        //       } else {
        //         bodyPartLoader.value = false;
        //       }
        //     }),
        //   if (workoutData!.phases![0].items.isNotEmpty)
        //     Future.value(WorkoutDetailController.getWarmUpData(context,
        //         warmUpLoader: warmUpLoader,
        //         workoutData: workoutData,
        //         exerciseData: exerciseData)),
        //   if (workoutData!.phases![1].items.isNotEmpty) ...[
        //     Future.delayed(
        //       Duration.zero,
        //       () {
        //         if (workoutData!.phases![0].items.isEmpty) {
        //           warmUpLoader.value = false;
        //         }
        //       },
        //     ),
        //     workoutData!.phases![1].items.first.ctRounds!.isNotEmpty
        //         ? Future.value(WorkoutDetailController.getTrainingData(context,
        //             trainingLoader: trainingLoader,
        //             workoutData: workoutData,
        //             exerciseWorkoutData: exerciseWorkoutData))
        //         : Future.value(WorkoutDetailController.getTrainingData2(context,
        //             trainingLoader: trainingLoader,
        //             workoutData: workoutData,
        //             exerciseWorkoutData: exerciseWorkoutData))
        //   ]
        // ]);

        if (workoutData?.goals.isNotEmpty ?? false) {
          WorkoutDetailController.getGoal(
                  context, workoutData?.goals.first.toString() ?? '')
              .then((value) {
            if (value != null) {
              fitnessGoalData = value;
              goalLoader.value = false;
            } else {
              goalLoader.value = false;
            }
          });
        }
        if (workoutData?.bodyParts.isNotEmpty ?? false) {
          if (workoutData?.goals.isEmpty ?? false) goalLoader.value = false;
          bodyPartLoader.value = true;
          WorkoutDetailController.getBodyPart(
                  context, workoutData?.bodyParts.first.toString() ?? "")
              .then((value) {
            if (value != null) {
              bodyPartData = value;
              bodyPartLoader.value = false;
            } else {
              bodyPartLoader.value = false;
            }
          });
        }
        if (workoutData!.phases![0].items.isNotEmpty) {
          WorkoutDetailController.getWarmUpData(context,
              warmUpLoader: warmUpLoader,
              workoutData: workoutData,
              exerciseData: exerciseData);
        }
        if (workoutData!.phases![1].items.isNotEmpty) {
          if (workoutData?.bodyParts.isEmpty ?? false)
            warmUpLoader.value = false;
          if (workoutData!.phases![1].items.first.ctRounds!.isNotEmpty) {
            WorkoutDetailController.getTrainingData(context,
                trainingLoader: trainingLoader,
                workoutData: workoutData,
                exerciseWorkoutData: exerciseWorkoutData);
          } else {
            WorkoutDetailController.getTrainingData2(context,
                trainingLoader: trainingLoader,
                workoutData: workoutData,
                exerciseWorkoutData: exerciseWorkoutData);
          }
        }

        return;
      } else {
        isLoadingNotifier = false;
        isNodData = true;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoadingNotifier == true
            ? const LoaderStackWidget()
            : isNodData == true
                ? const CustomErrorWidget()
                : Column(
                    children: [
                      Expanded(
                        child: ValueListenableBuilder(
                            valueListenable: centerTitle,
                            builder: (_, value, child) {
                              return CustomScrollView(
                                physics: const BouncingScrollPhysics(),
                                controller: scrollController,
                                slivers: [
                                  // SliverPersistentHeader(
                                  //     pinned: true, delegate: CustomDelegate()),

                                  SliverAppBarWidget(
                                    appBarTitle: "${workoutData?.title}",
                                    backGroundImg:
                                        workoutData?.mapImage?.url.toString() ??
                                            "",
                                    flexibleTitle: "${workoutData?.title}",
                                    flexibleTitle2:
                                        "${workoutData?.duration.getTextAfterSymbol()} min • ${workoutData?.types.toString()}` • ${workoutData?.level}",
                                    value: value,
                                  ),
                                  if (workoutData?.description?.isNotEmpty ??
                                      true)
                                    DescriptionBoxWidget(
                                      text:
                                          workoutData?.description.toString() ??
                                              "",
                                    ),

                                  cardBoxWidget(context),
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Workout Overview',
                                        style: AppTypography.title24XL.copyWith(
                                            color: AppColor.textEmphasisColor),
                                      ),
                                    ),
                                  ),
                                  warmUpSliverWidget(),
                                  SliverPadding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 20),
                                    sliver: trainingSliverWidget(),
                                  ),
                                ],
                              );
                            }),
                      ),
                      bottomWidget()
                    ],
                  ));
  }

  Container bottomWidget() {
    return Container(
      color: AppColor.surfaceBackgroundColor,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24, top: 24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${workoutData?.title}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.title14XS
                      .copyWith(color: AppColor.textEmphasisColor),
                ),
                4.height(),
                Text(
                    "${workoutData?.duration.getTextAfterSymbol()} min • ${workoutData?.types.toString()}` • ${workoutData?.level}",
                    style: AppTypography.paragraph12SM
                        .copyWith(color: AppColor.textPrimaryColor))
              ],
            ),
          ),
          Expanded(
            child: StartButtonWidget(
              onPressed: () {
                showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => StartWorkoutSheet(
                          fitnessGoalModel: fitnessGoalData,
                          exerciseData: exerciseData,
                          exerciseWorkoutData: exerciseWorkoutData,
                          workoutModel: workoutData as WorkoutModel,
                        ));
              },
            ),
          ),
        ],
      ),
    );
  }

  MultiSliver trainingSliverWidget() {
    return MultiSliver(pushPinnedChildren: true, children: [
      SliverPinnedHeader(
          child: BuildHeader(
        title: 'Training',
        valueListenable: trainingExpand,
        onTap: () {
          trainingExpand.value = !trainingExpand.value;
        },
      )),
      SliverToBoxAdapter(
          child: BuildBody(
              dataList: exerciseWorkoutData,
              valueListenable: trainingExpand,
              valueListenable1: trainingLoader))
    ]);
  }

  MultiSliver warmUpSliverWidget() {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPinnedHeader(
          //   child: ColoredBox(
          // color: Colors.white,
          //   child: ExpansionTile(
          //     textColor: Colors.black,
          //     title: Text('Warm Up'),
          //     children: [
          //       ValueListenableBuilder(
          //         valueListenable: warmUpLoader,
          //         builder: (context, value, child) {
          //           return value == true
          //               ? Center(
          //                   child: BaseHelper.loadingWidget(),
          //                 )
          //               : exerciseData.isEmpty
          //                   ? Center(
          //                       child: Text('No Data'),
          //                     )
          //                   : Column(
          //                       children: exerciseData
          //                           .map((e) => ListTile(
          //                                 leading: SizedBox(
          //                                   height: 40,
          //                                   width: 60,
          //                                   child: cacheNetworkWidget(
          //                                       imageUrl: e.mapGif?.url ?? ""),
          //                                 ),
          //                                 title: Text(e.name ?? ""),
          //                               ))
          //                           .toList());
          //         },
          //       ),
          //     ],
          //   ),
          // )),
          child: BuildHeader(
            title: 'Warm Up',
            valueListenable: warmUpExpand,
            onTap: () {
              warmUpExpand.value = !trainingExpand.value;
            },
          ),
        ),
        SliverToBoxAdapter(
            child: BuildBody(
          dataList: exerciseData,
          valueListenable: warmUpExpand,
          valueListenable1: warmUpLoader,
        ))
      ],
    );
  }

  SliverToBoxAdapter cardBoxWidget(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0.2,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
        color: AppColor.surfaceBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 16),
          child: Column(
            children: [
              CustomRowTextChartIcon(
                level: workoutData?.level.toString() ?? "",
                text1: 'Level',
                text2: workoutData?.level.toString() ?? "",
                isChartIcon: true,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: CustomDivider(),
              ),
              CustomRowTextChartIcon(
                text1: 'Instructor',
                text2: workoutData?.gender.toString() ?? "",
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: CustomDivider(),
              ),
              ValueListenableBuilder(
                valueListenable: goalLoader,
                builder: (context, value, child) {
                  return value == true
                      ? Center(
                          child: BaseHelper.loadingWidget(),
                        )
                      : CustomRowTextChartIcon(
                          text1: 'Goal',
                          text2: fitnessGoalData?.name ?? "",
                        );
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: CustomDivider(),
              ),
              ValueListenableBuilder(
                valueListenable: bodyPartLoader,
                builder: (context, value, child) {
                  return value == true
                      ? Center(
                          child: BaseHelper.loadingWidget(),
                        )
                      : CustomRowTextChartIcon(
                          text1: 'Bodyparts',
                          text2: bodyPartData?.name ?? "",
                        );
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: CustomDivider(),
              ),
              CustomRowTextChartIcon(
                  text1: 'Equipment',
                  text2: workoutData?.bodyParts.map((e) => e).toString() ?? "")
            ],
          ),
        ),
      ),
    );
  }
}

class BuildBody extends StatelessWidget {
  BuildBody(
      {super.key,
      required this.dataList,
      required this.valueListenable,
      required this.valueListenable1});
  final List<ExerciseModel> dataList;
  ValueListenable valueListenable;
  ValueListenable valueListenable1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
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
                          : ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: dataList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: SizedBox(
                                    height: 40,
                                    width: 60,
                                    child: cacheNetworkWidget(
                                        imageUrl:
                                            dataList[index].mapGif?.url ?? ""),
                                  ),
                                  title: Text(dataList[index].name ?? ""),
                                );
                              },
                            );
                },
              ),
            );
          }),
    );
  }
}

class BuildHeader extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  ValueListenable valueListenable;
  BuildHeader(
      {super.key,
      this.onTap,
      required this.title,
      required this.valueListenable});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColor.surfaceBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: ListTile(
          leading: Text(
            title,
            style: AppTypography.title18LG
                .copyWith(color: AppColor.textEmphasisColor),
          ),
          trailing: InkWell(
              onTap: onTap,
              child: ValueListenableBuilder(
                  valueListenable: valueListenable,
                  builder: (_, value, child) {
                    return value == true
                        ? const Icon(Icons.keyboard_arrow_up)
                        : const Icon(Icons.keyboard_arrow_down);
                  })),
        ),
      ),
    );
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AppBar();
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 57.0;

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    throw UnimplementedError();
  }
}

/*  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: context.dynamicHeight * 0.3,
                        child: Stack(fit: StackFit.expand, children: [
                          Container(
                            child: cacheNetworkWidget(
                                imageUrl: CategoryDetailController.imageUrl(
                                    categoryName: widget.categoryName,
                                    onDemandModel: onDemamdModelData,
                                    workoutModel: workoutData,
                                    trainingPlanModel: traningPlanData),
                                fit: BoxFit.cover),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                          Positioned(
                            bottom: 17,
                            left: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  CategoryDetailController.title(
                                      categoryName: widget.categoryName,
                                      onDemandModel: onDemamdModelData,
                                      workoutModel: workoutData,
                                      trainingPlanModel: traningPlanData),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.title24XL.copyWith(
                                      color: AppColor.textInvertEmphasis),
                                ),
                                5.height(),
                                Text(
                                  CategoryDetailController.subTitle(
                                      categoryName: widget.categoryName,
                                      onDemandModel: onDemamdModelData,
                                      workoutModel: workoutData,
                                      trainingPlanModel: traningPlanData),
                                  style: AppTypography.label16MD.copyWith(
                                      color: AppColor.textInvertPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                          if (widget.categoryName == CategoryName.videoClasses)
                            InkWell(
                              onTap: () {
                                context.navigateTo(CategoryPlayerView(
                                    videoURL:
                                        onDemamdModelData?.mapVideo?.url ?? "",
                                    thumbNail:
                                        onDemamdModelData?.mapImage?.url ??
                                            ""));
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  AppAssets.playArrowIcon,
                                  height: 38,
                                  color: AppColor.textInvertEmphasis,
                                ),
                              ),
                            ),
                        ]),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 40, top: 20),
                          child: Text(
                              CategoryDetailController.discription(
                                  categoryName: widget.categoryName,
                                  onDemandModel: onDemamdModelData,
                                  workoutModel: workoutData,
                                  trainingPlanModel: traningPlanData),
                              style: AppTypography.paragraph14MD
                                  .copyWith(color: AppColor.textPrimaryColor))),
                      Card(
                        elevation: 0.2,
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 40, top: 20),
                        color: AppColor.surfaceBackgroundColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 20, top: 16),
                          child: Column(
                            children: [
                              CustomRowTextChartIcon(
                                level: CategoryDetailController.level(
                                    categoryName: widget.categoryName,
                                    onDemandModel: onDemamdModelData,
                                    workoutModel: workoutData,
                                    trainingPlanModel: traningPlanData),
                                text1: 'Level',
                                text2: CategoryDetailController.level(
                                    categoryName: widget.categoryName,
                                    onDemandModel: onDemamdModelData,
                                    workoutModel: workoutData,
                                    trainingPlanModel: traningPlanData),
                                isChartIcon: true,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16, bottom: 16),
                                child: CustomDivider(),
                              ),
                              CustomRowTextChartIcon(
                                text1: 'Instructor',
                                text2: CategoryDetailController.type(
                                    categoryName: widget.categoryName,
                                    onDemandModel: onDemamdModelData,
                                    workoutModel: workoutData,
                                    trainingPlanModel: traningPlanData),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16, bottom: 16),
                                child: CustomDivider(),
                              ),
                              CustomRowTextChartIcon(
                                text1: 'Equipment',
                                text2: CategoryDetailController.equipment(
                                    categoryName: widget.categoryName,
                                    onDemandModel: onDemamdModelData,
                                    workoutModel: workoutData,
                                    trainingPlanModel: traningPlanData),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        color: AppColor.surfaceBackgroundColor,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 24, top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    CategoryDetailController.title(
                                        categoryName: widget.categoryName,
                                        onDemandModel: onDemamdModelData,
                                        workoutModel: workoutData,
                                        trainingPlanModel: traningPlanData),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.title14XS.copyWith(
                                        color: AppColor.textEmphasisColor)),
                                4.height(),
                                Text(
                                  CategoryDetailController.duration(
                                      categoryName: widget.categoryName,
                                      onDemandModel: onDemamdModelData,
                                      workoutModel: workoutData,
                                      trainingPlanModel: traningPlanData),
                                  style: AppTypography.paragraph12SM.copyWith(
                                      color: AppColor.textPrimaryColor),
                                ),
                              ],
                            ),
                            if (widget.categoryName ==
                                CategoryName.videoClasses)
                              PlayButtonWidget(
                                  onDemamdModelData: onDemamdModelData),
                            if (widget.categoryName == CategoryName.workouts)
                              StartButtonWidget(workoutModel: workoutData),
                            if (widget.categoryName ==
                                CategoryName.trainingPLans)
                              SheduletButtonWidget(
                                  trainingPlanModel: traningPlanData)
                          ],
                        ),
                      )
                    ],
                  ),  */

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;
  ExpandedSection({this.expand = false, required this.child});

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}
