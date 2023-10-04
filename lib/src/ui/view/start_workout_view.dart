import 'dart:async';

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/src/ui/view/workout_detail_view.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class StartWorkoutView extends StatefulWidget {
  final WorkoutModel workoutModel;
  final List<ExerciseModel> exerciseData;
  final List<ExerciseModel> exerciseWorkoutData;
  final FitnessGoalModel? fitnessGoalModel;
  const StartWorkoutView(
      {super.key,
      required this.workoutModel,
      required this.exerciseData,
      required this.exerciseWorkoutData,
      required this.fitnessGoalModel});

  @override
  State<StartWorkoutView> createState() => _StartWorkoutViewState();
}

class _StartWorkoutViewState extends State<StartWorkoutView> {
  late PageController pageController;
  ValueNotifier<double> sliderWarmUp = ValueNotifier(0);
  ValueNotifier<double> sliderExercise = ValueNotifier(0);
  ValueNotifier<double> sliderCoolDown = ValueNotifier(0);
  int lengthPhases = 0;
  ExerciseModel? data;
  Future<ExerciseModel?> getExercise(String id) async {
    ExerciseModel exerciseModel =
        await ExerciseRequest.exerciseById(id: id) as ExerciseModel;
    return exerciseModel;
  }

  int warmUpLength = 0;
  int workoutLength = 0;
  int coolDOwnnLength = 0;
  listWarmUpFn() {
    if (widget.workoutModel.phases!.first.items.isNotEmpty) {
      warmUpLength =
          widget.workoutModel.phases!.first.items.first.seExercises!.length;
    }
    if (widget.workoutModel.phases![1].items.isNotEmpty) {
      if (widget.workoutModel.phases![1].items.first.ctRounds!.isNotEmpty) {
        workoutLength = widget.workoutModel.phases![1].items.first.ctRounds!
            .first.exercises.length;
      } else {
        workoutLength =
            widget.workoutModel.phases![1].items.first.rftExercises?.length ??
                0;
      }
    }
    if (widget.workoutModel.phases![2].items.isNotEmpty) {
      coolDOwnnLength = widget.workoutModel.phases![2].items.length;
    }

    lengthPhases = warmUpLength + workoutLength + coolDOwnnLength;
  }

  ValueNotifier<int> workoutSeconds = ValueNotifier(5);
  timer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (workoutSeconds.value > 0) {
        workoutSeconds.value -= 1;
        print(workoutSeconds);
      } else {
        return;
      }
    });
  }

  @override
  void initState() {
    listWarmUpFn();
    pageController = PageController(initialPage: 0);

    timer();
    // TODO: implement initState
    super.initState();
  }

  Future<ExerciseModel?> futureFn(int index) async {
    try {
      if (index < warmUpLength) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          sliderWarmUp.value = index + 1.toDouble();
          sliderExercise.value = 0;
        });

        return await getExercise(widget.workoutModel.phases?.first.items.first
                .seExercises?[index].exerciseId ??
            "");
      } else if (index >= warmUpLength &&
          index - warmUpLength < workoutLength) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          sliderExercise.value = index + 1 - warmUpLength.toDouble();
        });
        if (widget.workoutModel.phases![1].items.first.ctRounds!.isNotEmpty) {
          return await getExercise(widget.workoutModel.phases![1].items.first
              .ctRounds!.first.exercises[index - warmUpLength].exerciseId);
        } else {
          return await getExercise(widget.workoutModel.phases![1].items.first
              .rftExercises![index - warmUpLength].exerciseId);
        }
      } else if (index >= workoutLength && index < coolDOwnnLength) {
        // return future = getExercise(widget.workoutModel.phases![2].items[i] ??
        //         "");
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surfaceBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.surfaceBrandDarkColor),
        elevation: 0,
        backgroundColor: AppColor.surfaceBackgroundColor,
        leading: InkWell(
            onTap: () {
              context.popPage();
            },
            child: const Icon(Icons.close)),
        leadingWidth: 30,
        title: Row(children: [
          if (warmUpLength != 0)
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: sliderWarmUp,
                  builder: (context, value, child) {
                    return SizedBox(
                      height: 7,
                      // width: 45,
                      child: CustomSLiderWidget(
                        sliderValue: value,
                        division: warmUpLength,
                      ),
                    );
                  }),
            ),
          6.width(),
          if (workoutLength != 0)
            Expanded(
              flex: 4,
              child: ValueListenableBuilder(
                  valueListenable: sliderExercise,
                  builder: (context, value, child) {
                    return SizedBox(
                      height: 7,
                      // width: 190,
                      child: CustomSLiderWidget(
                        sliderValue: value,
                        division: workoutLength,
                      ),
                    );
                  }),
            ),
          6.width(),
          if (coolDOwnnLength != 0)
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: sliderCoolDown,
                  builder: (context, value, child) {
                    return SizedBox(
                      height: 7,
                      // width: 45,
                      child: CustomSLiderWidget(
                        sliderValue: value,
                        division: 1,
                      ),
                    );
                  }),
            )
        ]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => OverviewBottomSheet(
                      fitnessGoalModel: widget.fitnessGoalModel,
                      workoutModel: widget.workoutModel,
                      exerciseData: widget.exerciseData,
                      exerciseWorkoutData: widget.exerciseWorkoutData,
                    ),
                  );
                },
                child: const Icon(Icons.interests_outlined)),
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            itemCount: lengthPhases,
            itemBuilder: (context, index) {
              return FutureBuilder(
                  future: futureFn(index),
                  builder: (context, snapshot) {
                    data = snapshot.data;
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                                child: cacheNetworkWidget(
                                    imageUrl: data?.mapGif?.url ?? '')),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data?.name ?? "",
                                style: AppTypography.title18LG,
                              ),
                              8.width(),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    useSafeArea: true,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) =>
                                        DetailExerciseBottomSheet(
                                            exerciseModel:
                                                data as ExerciseModel),
                                  );
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 2,
                                            color: AppColor.linkDisableColor)),
                                    child: Icon(
                                      Icons.question_mark_outlined,
                                      color: AppColor.linkDisableColor,
                                      size: 12,
                                    )),
                              )
                            ],
                          ),
                          if (index < warmUpLength)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: context.dynamicHeight * 0.03),
                              child: Column(
                                children: [
                                  const Text('seconds'),
                                  Text(
                                    'seconds',
                                    style: AppTypography.title28_2XL,
                                  )
                                ],
                              ),
                            ),
                          if (index >= warmUpLength)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: context.dynamicHeight * 0.03,
                                  horizontal: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Set',
                                        style: AppTypography.label12XSM,
                                      ),
                                      Text(
                                        "1/2",
                                        style: AppTypography.title24XL,
                                      )
                                    ],
                                  ),
                                  // 50.width(),
                                  Column(
                                    children: [
                                      Text(
                                        'Reps',
                                        style: AppTypography.label12XSM,
                                      ),
                                      Text(
                                        '5',
                                        style: AppTypography.title40_4XL,
                                      )
                                    ],
                                  ),
                                  Container()
                                ],
                              ),
                            ),
                          if (index < warmUpLength)
                            Divider(
                              endIndent: 50,
                              indent: 50,
                              thickness: 5,
                              color: AppColor.linkPrimaryColor,
                            ),
                          if (index >= warmUpLength)
                            Container(
                              width: double.infinity,
                              height: 50,
                              margin: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: 10,
                              ),
                              child: CustomElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Set Done')),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await pageController.animateToPage(
                                        pageController.page!.toInt() - 1,
                                        duration:
                                            const Duration(milliseconds: 100),
                                        curve: Curves.easeOut);
                                  },
                                  child: Container(
                                    color: AppColor.surfaceBackgroundBaseColor,
                                    padding: const EdgeInsets.all(10),
                                    child: const Icon(
                                      Icons.keyboard_arrow_left,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.navigateTo(CategoryPlayerView(
                                        videoURL:
                                            data?.mapVideo?.url.toString() ??
                                                '',
                                        thumbNail:
                                            data?.mapImage?.url.toString() ??
                                                ''));
                                  },
                                  child: Container(
                                    color: AppColor.surfaceBackgroundBaseColor,
                                    padding: const EdgeInsets.all(10),
                                    child: const Icon(
                                      Icons.pause,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await pageController.animateToPage(
                                        pageController.page!.toInt() + 1,
                                        duration:
                                            const Duration(milliseconds: 100),
                                        curve: Curves.easeIn);
                                  },
                                  child: Container(
                                    color: AppColor.surfaceBackgroundBaseColor,
                                    padding: const EdgeInsets.all(10),
                                    child: const Icon(
                                      Icons.keyboard_arrow_right,
                                      size: 35,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ModalBarrier(
                              dismissible: false,
                              color: Colors.black.withOpacity(0.1)),
                          Center(child: BaseHelper.loadingWidget()),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something went Wrong'),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: Text('No Data'),
                      );
                    }
                    return Container();
                  });
            },
          ),
          ValueListenableBuilder(
              valueListenable: workoutSeconds,
              builder: (context, value, child) {
                return value > 0
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                            child: ModalBarrier(
                                dismissible: false,
                                color: Colors.black.withOpacity(0.5)),
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Get Ready!',
                                style: AppTypography.title40_4XL.copyWith(
                                    color: AppColor.textInvertEmphasis),
                              ),
                              SizedBox(
                                height: context.dynamicHeight * 0.1,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: BaseHelper.loadingWidget(
                                        strokeWidth: 6,
                                        value: value.toDouble() / 5),
                                  ),
                                  Text(
                                    value.toString(),
                                    style: AppTypography.title40_4XL.copyWith(
                                        color: AppColor.textInvertEmphasis),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    : Container();
              }),
        ],
      ),
    );
  }
}


class OverviewBottomSheet extends StatelessWidget {
  final WorkoutModel workoutModel;
  final List<ExerciseModel> exerciseData;
  final List<ExerciseModel> exerciseWorkoutData;
  final FitnessGoalModel? fitnessGoalModel;
  OverviewBottomSheet(
      {super.key,
      required this.workoutModel,
      required this.exerciseData,
      required this.exerciseWorkoutData,
      required this.fitnessGoalModel});
  ValueNotifier<bool> warmUpExpand = ValueNotifier(true);
  ValueNotifier<bool> trainingExpand = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text(
                'Overview',
                style: AppTypography.title18LG,
              ),
              InkWell(
                onTap: () {
                  context.popPage();
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      color: AppColor.textInvertSubtitle,
                      shape: BoxShape.circle),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                  ),
                ),
              )
            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Double the Fun',
              style: AppTypography.title28_2XL,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: BuildCardWidget(
                      subtitle: workoutModel.duration, title: 'Duration'),
                ),
                20.width(),
                Expanded(
                    child: BuildCardWidget(
                        title: 'Goal', subtitle: fitnessGoalModel?.name ?? ""))
              ],
            ),
          ),
          BuildHeader(
            title: 'Warm Up',
            valueListenable: warmUpExpand,
            onTap: () {
              warmUpExpand.value = !warmUpExpand.value;
            },
          ),
          ValueListenableBuilder(
            valueListenable: warmUpExpand,
            builder: (context, value, child) {
              return ExpandedSection(
                expand: value,
                child: exerciseData.isEmpty
                    ? Center(
                        child: Text('No Data'),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: exerciseData.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 60,
                            child: ListTile(
                              leading: SizedBox(
                                  height: 40,
                                  width: 60,
                                  child: cacheNetworkWidget(
                                      imageUrl:
                                          exerciseData[index].mapImage?.url ??
                                              '')),
                              title: Text(exerciseData[index].name),
                              subtitle: Text(workoutModel
                                      .phases?[0]
                                      .items
                                      .first
                                      .seExercises?[index]
                                      .sets
                                      .first
                                      .goalTargets
                                      .first
                                      .value
                                      .toString() ??
                                  ""),
                            ),
                          );
                        },
                      ),
              );
            },
          ),
          BuildHeader(
            title: 'Training',
            valueListenable: trainingExpand,
            onTap: () {
              trainingExpand.value = !trainingExpand.value;
            },
          ),
          ValueListenableBuilder(
            valueListenable: trainingExpand,
            builder: (context, value, child) {
              return ExpandedSection(
                expand: value,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: exerciseWorkoutData.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 60,
                      child: ListTile(
                        leading: SizedBox(
                          height: 40,
                          width: 60,
                          child: cacheNetworkWidget(
                              imageUrl:
                                  exerciseWorkoutData[index].mapImage?.url ??
                                      ''),
                        ),
                        title: Text(exerciseWorkoutData[index].name),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class DetailExerciseBottomSheet extends StatelessWidget {
  final ExerciseModel exerciseModel;
  const DetailExerciseBottomSheet({super.key, required this.exerciseModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Text(
              exerciseModel.name,
              style: AppTypography.label14SM,
            ),
            InkWell(
              onTap: () {
                context.popPage();
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: AppColor.textInvertSubtitle, shape: BoxShape.circle),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.close,
                  size: 18,
                ),
              ),
            )
          ],
        ),
        const Divider(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 26),
          color: AppColor.surfaceBackgroundColor,
          child: cacheNetworkWidget(imageUrl: exerciseModel.mapGif?.url ?? ""),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 26),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.surfaceBackgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Instructor',
                style: AppTypography.title14XS,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: exerciseModel.steps?.length ?? 0,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 60,
                    child: ListTile(
                      leading: Container(
                        margin:
                            const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        decoration: BoxDecoration(
                            color: AppColor.textInvertSubtitle,
                            shape: BoxShape.circle),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "${index + 1}",
                          style: AppTypography.label16MD,
                        ),
                      ),
                      title: Text(exerciseModel.steps?[index]),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
