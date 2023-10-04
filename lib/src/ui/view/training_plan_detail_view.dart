import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class TrainingPlanDetailView extends StatefulWidget {
  final String id;
  const TrainingPlanDetailView({
    super.key,
    required this.id,
  });

  @override
  State<TrainingPlanDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<TrainingPlanDetailView> {
  bool isLoadingNotifier = false;
  bool isNodData = false;
  late ScrollController scrollController;

  TrainingPlanModel? trainingPlanData;
  FitnessGoalModel? fitnessGoalData;
  FitnessActivityTypeModel? fitnessActivityTypeData;
  ExerciseModel? exerciseData;
  ExerciseModel? exerciseWorkoutData;

  ValueNotifier<int> weekIndex = ValueNotifier(0);
  ValueNotifier<bool> centerTitle = ValueNotifier(false);
  FitnessActivityTypeModel? workoutType;
  List<WorkoutModel?> listSheduleWorkoutData = [];
  ValueNotifier<bool> shedulePlanLoader = ValueNotifier(false);
  ValueNotifier<bool> fitnessTypeLoader = ValueNotifier(true);
  ValueNotifier<bool> goalLoader = ValueNotifier(true);
  List<WeekName> weekName = [
    WeekName('Monday', false),
    WeekName('Tuesday', false),
    WeekName('Wednesday', false),
    WeekName('Thursday', false),
    WeekName('Friday', false),
    WeekName('Saturday', false),
    WeekName('Sunday', false),
  ];

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

    TrainingPlanDetailController.getTrainingPlanData(context, id: widget.id)
        .then((value) async {
      if (value != null && context.mounted) {
        isLoadingNotifier = false;
        trainingPlanData = value;
        setState(() {});
        if (trainingPlanData?.types.isNotEmpty ?? false) {
          TrainingPlanDetailController.getFitnessType(
                  context, trainingPlanData?.types.first.toString() ?? "")
              .then((value) {
            if (value != null) {
              fitnessActivityTypeData = value;
              fitnessTypeLoader.value = false;
            } else {
              fitnessTypeLoader.value = false;
            }
          });
        }
        TrainingPlanDetailController.getGoal(context,
                trainingPlanData: trainingPlanData)
            .then((value) {
          if (value != null) {
            fitnessGoalData = value;
            goalLoader.value = false;
          } else {
            goalLoader.value = false;
          }
        });

        TrainingPlanDetailController.shedulePlanFn(context,
            listSheduleWorkoutData: listSheduleWorkoutData,
            shedulePlanLoader: shedulePlanLoader,
            trainingPlanData: trainingPlanData,
            weekIndex: weekIndex);

        return;
      } else if (context.mounted) {
        setState(() {
          isLoadingNotifier = false;
          isNodData = true;
        });
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
                                  SliverAppBarWidget(
                                    value: value,
                                    appBarTitle: "${trainingPlanData?.title}",
                                    flexibleTitle: "${trainingPlanData?.title}",
                                    flexibleTitle2:
                                        "${trainingPlanData?.weeksTotal} weeks • ${trainingPlanData?.maxDaysPerWeek} workouts / week",
                                    backGroundImg: trainingPlanData
                                            ?.mapImage?.url
                                            .toString() ??
                                        "",
                                  ),
                                  DescriptionBoxWidget(
                                      text: trainingPlanData?.description
                                              .toString() ??
                                          ""),
                                  cardBoxWidget(),
                                  sheduleCardBoxWidget(context)
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
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${trainingPlanData?.title}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.title14XS
                      .copyWith(color: AppColor.textEmphasisColor),
                ),
                4.height(),
                Text(
                    "${trainingPlanData?.weeksTotal} weeks / ${trainingPlanData?.maxDaysPerWeek} workouts",
                    style: AppTypography.paragraph12SM
                        .copyWith(color: AppColor.textPrimaryColor))
              ],
            ),
          ),
          Expanded(
            child: SheduletButtonWidget(
              onPressed: () {
                showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => ShedulePlanSheet(
                    trainingPlanModel: trainingPlanData,
                    weekName: weekName,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  SliverToBoxAdapter sheduleCardBoxWidget(BuildContext context) {
    return SliverToBoxAdapter(
        child: Card(
            elevation: 0.2,
            margin:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
            color: AppColor.surfaceBackgroundColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 16, top: 16, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Your Schedule',
                      style: AppTypography.title24XL,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: context.dynamicWidth,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: trainingPlanData?.weeks?.length,
                      itemBuilder: (context, index) {
                        return ValueListenableBuilder(
                            valueListenable: weekIndex,
                            builder: (context, value, child) {
                              return InkWell(
                                onTap: () {
                                  weekIndex.value = index;
                                  setState(() {
                                    TrainingPlanDetailController.shedulePlanFn(
                                        context,
                                        listSheduleWorkoutData:
                                            listSheduleWorkoutData,
                                        shedulePlanLoader: shedulePlanLoader,
                                        trainingPlanData: trainingPlanData,
                                        weekIndex: weekIndex);
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.all(6),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: value == index
                                          ? AppColor.surfaceBrandDarkColor
                                          : AppColor
                                              .surfaceBackgroundBaseColor),
                                  child: Text(
                                    'week ${index + 1}',
                                    style: AppTypography.paragraph14MD.copyWith(
                                        color: value == index
                                            ? AppColor.textInvertEmphasis
                                            : AppColor.textEmphasisColor),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: shedulePlanLoader,
                    builder: (_, value, child) {
                      return value == true
                          ? Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Center(
                                child: BaseHelper.loadingWidget(),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: listSheduleWorkoutData.length,
                              itemBuilder: (context, index) {
                                WorkoutModel? data =
                                    listSheduleWorkoutData[index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: CustomTileWidget(
                                      imageUrl: data?.mapImage?.url ?? "",
                                      title: data?.title ?? "",
                                      subtitle:
                                          "${data?.duration} ${data?.level}",
                                      onTap: () {}),
                                );
                              });
                    },
                  )
                ],
              ),
            )));
  }

  SliverToBoxAdapter cardBoxWidget() {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0.2,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        color: AppColor.surfaceBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 16),
          child: Column(
            children: [
              CustomRowTextChartIcon(
                level: trainingPlanData?.level.toString() ?? "",
                text1: 'Level',
                text2: trainingPlanData?.level.toString() ?? "",
                isChartIcon: true,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: CustomDivider(),
              ),
              ValueListenableBuilder(
                valueListenable: fitnessTypeLoader,
                builder: (context, value, child) {
                  return value == true
                      ? Center(
                          child: BaseHelper.loadingWidget(),
                        )
                      : CustomRowTextChartIcon(
                          text1: 'Type',
                          text2: fitnessActivityTypeData?.name ?? "No Data",
                        );
                },
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
                          text2: fitnessGoalData?.name ?? "No Data",
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
