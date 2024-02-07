import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hive_flutter/hive_flutter.dart';



import 'package:ui_tool_kit/ui_tool_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashBoardView extends StatefulWidget {
  final List<OnDemandModel> onDemadDataVideo;
  final List<WorkoutModel> workoutData;
  final List<OnDemandModel> onDemadDataAudio;
  final List<TrainingPlanModel> trainingPlanData;
  final Map<int, String> workoutDataType;
  final Map<int, String> videoDataType;
  final Map<int, String> audioDataType;
  final Map<int, String> fitnessGoalData;
  const DashBoardView(
      {super.key,
      required this.onDemadDataVideo,
      required this.workoutData,
      required this.onDemadDataAudio,
      required this.trainingPlanData,
      required this.workoutDataType,
      required this.videoDataType,
      required this.audioDataType,
      required this.fitnessGoalData});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  bool isNodData = false;
  @override
  void initState() {
    checkData();

    super.initState();
  }

  checkData() {
    if (widget.audioDataType.isEmpty &&
        widget.fitnessGoalData.isEmpty &&
        widget.onDemadDataAudio.isEmpty &&
        widget.onDemadDataVideo.isEmpty &&
        widget.trainingPlanData.isEmpty &&
        widget.videoDataType.isEmpty &&
        widget.workoutData.isEmpty &&
        widget.workoutDataType.isEmpty) {
      isNodData == true;
    } else {
      isNodData = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.textInvertPrimaryColor,
      appBar: AppBar(
          surfaceTintColor: AppColor.surfaceBackgroundColor,
          elevation: 0,
          backgroundColor: AppColor.surfaceBackgroundColor,
          leadingWidth: 0,
          titleSpacing: 0,
          leading: const SizedBox.shrink(),
          title: CustomSearchTextFieldWidget(
            onFieldTap: () {
              context.navigateTo(const SearchContentView());

            },
            hintText: 'Workouts, trainers, exercises',
            margin:
                const EdgeInsets.only(top: 10, left: 24, right: 24, bottom: 10),
          )),
      body: isNodData == true
          ? const CustomErrorWidget()
          : ListView(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              children: [
                  ValueListenableBuilder(
                      valueListenable: Boxes.getTrainingPlanBox().listenable(),
                      builder: (_, value, child) {
                        return value.isNotEmpty
                            ? Column(
                                children: [
                                  RowEndToEndTextWidget(
                                    columnText1: value.values.length > 1
                                        ? "Your Training Plans"
                                        : "Your Training Plan",
                                    rowText1: 'See all',
                                    columnText2: "Sweet sweet plans",
                                    seeOnTap: () {
                                      context.navigateTo(
                                          const TrainingPlanListView(
                                        initialIndex: 1,
                                      ));
                                    },
                                  ),
                                  20.height(),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      // color: Colors.green,
                                      alignment: Alignment.centerLeft,
                                      child: Transform.scale(
                                        scale: 1.2,
                                        child: CarouselSlider(
                                            items: value.values
                                                .toList()
                                                .sublist(
                                                    0,
                                                    value.values.length > 4
                                                        ? 4
                                                        : null)
                                                .map((e) => Container(
                                                      width: double.infinity,
                                                      margin: EdgeInsets.only(
                                                          left: value.values
                                                                      .first ==
                                                                  e
                                                              ? 10
                                                              : 10,
                                                          right: 10,
                                                          top: 20),
                                                      decoration: BoxDecoration(
                                                          color: AppColor
                                                              .surfaceBrandSecondaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16)),
                                                      child: Column(
                                                        children: [
                                                          GestureDetector(
                                                            behavior:
                                                                HitTestBehavior
                                                                    .deferToChild,
                                                            onTap: () {
                                                              context.navigateTo(
                                                                  TrainingPlanDetailView(
                                                                id: e
                                                                    .trainingplanId,
                                                              ));
                                                            },
                                                            child: Stack(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              children: [
                                                                SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 190,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius: const BorderRadius
                                                                        .only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                16),
                                                                        topRight:
                                                                            Radius.circular(16)),
                                                                    child: cacheNetworkWidget(
                                                                        height: 190,
                                                                        width: context.dynamicWidth.toInt(),
                                                                        context,
                                                                        // fit: BoxFit.fill,
                                                                        imageUrl: e.trainingPlanImg),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomLeft,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            12,
                                                                        right:
                                                                            12,
                                                                        bottom:
                                                                            8),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            e.trainingPlanTitle,
                                                                            style: AppTypography.title18LG.copyWith(color: AppColor.textInvertEmphasis)),
                                                                        4.height(),
                                                                        FollowedBorderWidget(
                                                                            followTrainingData:
                                                                                e),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          if (e.workoutCount !=
                                                              e.totalWorkoutLength)
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 12,
                                                                      right: 12,
                                                                      top: 4),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'Next up',
                                                                    style: AppTypography
                                                                        .label12XSM
                                                                        .copyWith(
                                                                            color:
                                                                                AppColor.textInvertSubtitle),
                                                                  ),
                                                                  4.height(),
                                                                  CustomListtileWidget(
                                                                      titleColor: AppColor
                                                                          .textInvertEmphasis,
                                                                      subtitleColor:
                                                                          AppColor
                                                                              .textInvertPrimaryColor,
                                                                      imageUrl: e
                                                                          .workoutData[e.workoutCount == e.totalWorkoutLength ? e.workoutCount - 1 : e.workoutCount]
                                                                              [
                                                                              'workoutImg']
                                                                          .toString(),
                                                                      title: e.workoutData[e.workoutCount == e.totalWorkoutLength ? e.workoutCount - 1 : e.workoutCount]['workoutTitle']
                                                                          .toString(),
                                                                      subtitle: e
                                                                          .workoutData[e.workoutCount == e.totalWorkoutLength ? e.workoutCount - 1 : e.workoutCount][
                                                                              'workoutSubtitle']
                                                                          .toString(),
                                                                      onTap:
                                                                          () {
                                                                        context.navigateTo(
                                                                            WorkoutDetailView(
                                                                          id: e
                                                                              .workoutData[e.workoutCount == e.totalWorkoutLength ? e.workoutCount - 1 : e.workoutCount]["workoutId"]
                                                                              .toString(),
                                                                          followTrainingplanModel: FollowTrainingplanModel(
                                                                              trainingplanId: e.trainingplanId,
                                                                              workoutData: e.workoutData,
                                                                              workoutCount: e.workoutCount == e.totalWorkoutLength ? e.workoutCount : e.workoutCount + 1,
                                                                              totalWorkoutLength: e.totalWorkoutLength,
                                                                              outOfSequence: false,
                                                                              trainingPlanImg: e.trainingPlanImg,
                                                                              trainingPlanTitle: e.trainingPlanTitle,
                                                                              daysPerWeek: e.daysPerWeek,
                                                                              goalsId: e.goalsId,
                                                                              levelName: e.levelName,
                                                                              location: e.location),
                                                                        ));
                                                                      },
                                                                      imageHeaderIcon:
                                                                          AppAssets.workoutHeaderIcon)
                                                                ],
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    ))
                                                .toList(),
                                            options: CarouselOptions(
                                              // aspectRatio: 4 / 3,
                                              height: 330,
                                              pageSnapping: true,
                                              // viewportFraction: 0.8,
                                              autoPlay: false,
                                              enableInfiniteScroll: false,
                                              // enlargeCenterPage: true
                                              // pauseAutoPlayInFiniteScroll: true,
                                            )),
                                      ),
                                    ),
                                  ),
                                  50.height(),
                                  const CustomDivider(
                                    endIndent: 30,
                                    indent: 30,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink();
                      }),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                    ),
                    child: RowEndToEndTextWidget(
                        seeOnTap: () {
                          context.navigateTo(const VideoAudioWorkoutListView(
                              categoryName: CategoryName.videoClasses));
                        },
                        columnText1: "Recent Video Classes",
                        rowText1: "See all"),
                  ),
                  Transform.scale(
                    scale: 1.2,
                    child: CarouselSlider(
                        items: widget.onDemadDataVideo
                            .toList()
                            .asMap()
                            .entries
                            .map((e) => Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                      left: widget.onDemadDataVideo.first ==
                                              e.value
                                          ? 10
                                          : 10,
                                      right: 10,
                                      top: 20),
                                  // decoration: BoxDecoration(
                                  //     // color: AppColor.surfaceBrandSecondaryColor,
                                  //     borderRadius: BorderRadius.circular(16)),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.deferToChild,
                                    onTap: () {
                                      context.navigateTo(
                                          VideoAudioDetailView(id: e.value.id));
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      clipBehavior: Clip.antiAlias,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          height: 190,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(16)),
                                            child: cacheNetworkWidget(
                                                height: 190,
                                                width: context.dynamicWidth
                                                    .toInt(),
                                                context,
                                                // fit: BoxFit.fill,
                                                imageUrl: e.value.image),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                          alignment: Alignment.bottomLeft,
                                          // color: Colors.red,
                                          child: Wrap(
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.start,
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                e.value.title,
                                                style: AppTypography.title18LG
                                                    .copyWith(
                                                        color: AppColor
                                                            .textInvertEmphasis),
                                              ),
                                              Text(
                                                "${e.value.duration.toString()} min • ${widget.videoDataType[e.key].toString()} • ${e.value.level}",
                                                style: AppTypography
                                                    .paragraph14MD
                                                    .copyWith(
                                                        color: AppColor
                                                            .textInvertPrimaryColor),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          enlargeFactor: 1.1,
                          // aspectRatio: 4 / 3,
                          height: 220,
                          pageSnapping: true,
                          // viewportFraction: 0.8,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          // enlargeCenterPage: true
                          // pauseAutoPlayInFiniteScroll: true,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 45,
                    ),
                    child: RowEndToEndTextWidget(
                        columnText1: "Recent Training Plan",
                        seeOnTap: () {
                          context.navigateTo(const TrainingPlanListView(
                            initialIndex: 0,
                          ));
                        },
                        columnText2: "Sweet sweet plans",
                        rowText1: "See all"),
                  ),
                  Transform.scale(
                    scale: 1.2,
                    child: CarouselSlider(
                        items: widget.trainingPlanData
                            .asMap()
                            .entries
                            .map((e) => Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, top: 20),
                                  // decoration: BoxDecoration(
                                  //     // color: AppColor.surfaceBrandSecondaryColor,
                                  //     borderRadius: BorderRadius.circular(16)),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.deferToChild,
                                    onTap: () {
                                      context.navigateTo(TrainingPlanDetailView(
                                        id: e.value.id,
                                      ));
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      clipBehavior: Clip.antiAlias,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          height: 190,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(16)),
                                            child: cacheNetworkWidget(
                                                height: 190,
                                                width: context.dynamicWidth
                                                    .toInt(),
                                                context,
                                                // fit: BoxFit.fill,
                                                imageUrl:
                                                    e.value.image.toString()),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                          alignment: Alignment.bottomLeft,
                                          child: Wrap(
                                            children: [
                                              Text(
                                                e.value.title,
                                                style: AppTypography.title18LG
                                                    .copyWith(
                                                        color: AppColor
                                                            .textInvertEmphasis),
                                              ),
                                              Text(
                                                "${e.value.daysTotal} workouts • ${widget.fitnessGoalData.entries.toList()[e.key].value} • ${e.value.level}",
                                                style: AppTypography
                                                    .paragraph14MD
                                                    .copyWith(
                                                        color: AppColor
                                                            .textInvertPrimaryColor),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          enlargeFactor: 1.1,
                          // aspectRatio: 4 / 3,
                          height: 220,
                          pageSnapping: true,
                          // viewportFraction: 0.8,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          // enlargeCenterPage: true
                          // pauseAutoPlayInFiniteScroll: true,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 40,
                    ),
                    child: RowEndToEndTextWidget(
                        columnText1: "What Are You Looking For?",
                        rowText1: "See all"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const DashBoardButtonWidget(text: 'Video Classes'),
                            16.width(),
                            const DashBoardButtonWidget(text: 'Workouts')
                          ],
                        ),
                        16.height(),
                        Row(
                          children: [
                            const DashBoardButtonWidget(text: 'Training Plans'),
                            16.width(),
                            const DashBoardButtonWidget(text: 'Audio Classes')
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                    ),
                    child: RowEndToEndTextWidget(
                      seeOnTap: () {
                        context.navigateTo(const VideoAudioWorkoutListView(
                            categoryName: CategoryName.workouts));
                      },
                      columnText1: "Recent Workouts",
                      rowText1: "See all",
                      columnText2: "Some fresh content for you.",
                    ),
                  ),
                  20.height(),
                  SizedBox(
                    height: 260,
                    child: Transform.scale(
                        scale: 1.0,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.workoutData.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 20),
                              width: 170,
                              // height: 200,

                              child: InkWell(
                                onTap: () {
                                  context.navigateTo(WorkoutDetailView(
                                      id: widget.workoutData[index].id
                                          .toString()));
                                },
                                child: Stack(
                                  clipBehavior: Clip.antiAlias,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: cachedNetworkImageProvider(
                                                  imageUrl: widget
                                                      .workoutData[index].image
                                                      .toString()))),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      alignment: Alignment.bottomLeft,
                                      child: Wrap(
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            widget.workoutData[index].title
                                                .toString(),
                                            style: AppTypography.title18LG
                                                .copyWith(
                                                    color: AppColor
                                                        .textInvertEmphasis),
                                          ),
                                          Wrap(
                                            children: [
                                              Text(
                                                "${widget.workoutData[index].duration.toString()} min",
                                                style: AppTypography
                                                    .paragraph14MD
                                                    .copyWith(
                                                        color: AppColor
                                                            .textInvertPrimaryColor),
                                              ),
                                              Text(
                                                " • ${widget.workoutDataType[index].toString()}",
                                                style: AppTypography
                                                    .paragraph14MD
                                                    .copyWith(
                                                        color: AppColor
                                                            .textInvertPrimaryColor),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                    ),
                    child: RowEndToEndTextWidget(
                      seeOnTap: () {
                        context.navigateTo(const VideoAudioWorkoutListView(
                            categoryName: CategoryName.audioClasses));
                      },
                      columnText1: "Audio Classes",
                      rowText1: "See all",
                    ),
                  ),
                  20.height(),
                  SizedBox(
                    height: 260,
                    child: Transform.scale(
                        scale: 1.0,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.onDemadDataAudio.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 20),
                              width: 170,
                              // height: 200,

                              child: InkWell(
                                onTap: () {
                                  context.navigateTo(VideoAudioDetailView(
                                      id: widget.onDemadDataAudio[index].id));
                                },
                                child: Stack(
                                  clipBehavior: Clip.antiAlias,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: cachedNetworkImageProvider(
                                                  imageUrl: widget
                                                      .onDemadDataAudio[index]
                                                      .image
                                                      .toString()))),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      // color: Colors.red,
                                      alignment: Alignment.bottomLeft,
                                      child: Wrap(
                                        children: [
                                          Text(
                                            widget.onDemadDataAudio[index].title
                                                .toString(),
                                            style: AppTypography.title18LG
                                                .copyWith(
                                                    color: AppColor
                                                        .textInvertEmphasis),
                                          ),
                                          Wrap(
                                            children: [
                                              Text(
                                                "${widget.onDemadDataAudio[index].duration.toString()} min",
                                                style: AppTypography
                                                    .paragraph14MD
                                                    .copyWith(
                                                        color: AppColor
                                                            .textInvertPrimaryColor),
                                              ),
                                              Text(
                                                " • ${widget.audioDataType[index].toString()}",
                                                style: AppTypography
                                                    .paragraph14MD
                                                    .copyWith(
                                                        color: AppColor
                                                            .textInvertPrimaryColor),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                  ),
                ]),
    );
  }
}

class DashBoardButtonWidget extends StatelessWidget {
  final String text;
  const DashBoardButtonWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
          childPadding: const EdgeInsets.symmetric(vertical: 12),
          elevation: 0,
          btnColor: AppColor.buttonTertiaryColor,
          onPressed: () {
            text.contains('Video')
                ? context.navigateTo(const VideoAudioWorkoutListView(
                    categoryName: CategoryName.videoClasses))
                : text.contains('Workout')
                    ? context.navigateTo(const VideoAudioWorkoutListView(
                        categoryName: CategoryName.workouts))
                    : text.contains('Training')
                        ? context.navigateTo(const TrainingPlanListView(
                            initialIndex: 0,
                          ))
                        : context.navigateTo(const VideoAudioWorkoutListView(
                            categoryName: CategoryName.audioClasses));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                text.contains('Video')
                    ? AppAssets.videoPlayIcon
                    : text.contains('Workout')
                        ? AppAssets.workoutHeaderIcon
                        : text.contains('Training')
                            ? AppAssets.calendarIcon
                            : AppAssets.headPhoneIcon,
                color: AppColor.buttonSecondaryColor,
              ),
              4.width(),
              Flexible(
                child: FittedBox(
                  child: Text(
                    text,
                    style: AppTypography.label14SM
                        .copyWith(color: AppColor.buttonSecondaryColor),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
