

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


import '../../../ui_tool_kit.dart';

class SearchContentView extends StatefulWidget {
  const SearchContentView({super.key});

  @override
  State<SearchContentView> createState() => _SearchContentViewState();
}

class _SearchContentViewState extends State<SearchContentView> {
  // final bool isSubmit
  late TextEditingController _searchController;
  late ScrollController _scrollController;
  late FocusNode _focusNode;
  SearchContentModel? searchContentData;
  List<Result> resultData = [];
  int pageNumber = 0;

  bool nextPage = true;

  bool isLoadMore = false;
  bool isNodData = false;

  bool isLoadingNotifier = false;

  @override
  void initState() {
    _searchController = TextEditingController();
    _scrollController = ScrollController();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    _scrollController.addListener(
      () {
        if (isLoadMore == false &&
            nextPage == true &&
            _scrollController.position.extentAfter < 300 &&
            _scrollController.position.extentAfter != 0.0) {
          isLoadMore = true;

          pageNumber += 10;
          getdata(isScroll: true, text: _searchController.text);
             
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  List<String> topMatches = [];
  List<String> suggestions = [
    "Aerobics",
    "Anaerobic Exercise",
    "Body Mass Index (BMI)",
    "Cardiovascular Exercise",
    "Cool Down",
    "CrossFit",
    "Dumbbell",
    "Endurance",
    "Flexibility",
    "Interval Training",
    "Kettlebell",
    "Pilates",
    "Rep (Repetition)",
    "Resistance Training",
    "Set",
    "Spinning",
    "Strength Training",
    "Stretching",
    "Superset",
    "Tabata",
    "Treadmill",
    "Warm-Up",
    "Weightlifting",
    "Yoga",
    "Zumba",
    "Balance",
    "Calisthenics",
    "Circuit Training",
    "Deadlift",
    "Elliptical Trainer",
    "Fartlek",
    "Functional Fitness",
    "High-Intensity Interval Training (HIIT)",
    "Incline",
    "Jogging",
    "Kinesiology",
    "Lunges",
    "Metabolism",
    "Nutrition",
    "Obliques",
    "Pedometer",
    "Quads (Quadriceps)",
    "Rowing Machine",
    "Stability Ball",
    "Target Heart Rate",
    "Upright Row",
    "Vinyasa",
    "Wellness",
    "X-trainer",
    "Youth Fitness",
    "Zone Training",
  ];

  void updateSuggestions(String input) {
    // Filter suggestions based on user input
    List<String> filteredSuggestions = suggestions
        .where((e) =>
            e.toLowerCase().trim().startsWith(input.toLowerCase().trim()))
        .toList();
    topMatches = filteredSuggestions.length > 4
        ? filteredSuggestions.sublist(0, 4)
        : filteredSuggestions;

    // Update the state with filtered suggestions
    setState(() {});
  }

  getdata({required bool isScroll, required text}) async {
    isLoadingNotifier = isScroll == true ? false : true;
    isNodData = false;
    if (isScroll == false) {
      resultData.clear();
      pageNumber = 0;
    }
    setState(() {});

    await SearchContentController.fetchData(data: {
      "q": text,
      "cursors": [
        {"collection": "workouts", "offset": pageNumber, "limit": 10},
        {"collection": "video", "offset": pageNumber, "limit": 10},
        {"collection": "audio", "offset": pageNumber, "limit": 10},
        {"collection": "training-plans", "offset": pageNumber, "limit": 10}
      ],
    }, searchContentData: searchContentData, resultData: resultData)
        .then((data) {
      if (data != null) {
        nextPage = true;
        isLoadMore = false;
        searchContentData = data;
        if (data.results?.isNotEmpty ?? false) {
          resultData.addAll(data.results as List<Result>);
        } else if (data.results?.isEmpty ?? false) {
          nextPage = false;
        }
      } else if (data == null) {
        isLoadMore = false;
        isNodData = true;
        nextPage = true;
        isLoadingNotifier = isScroll == true ? false : false;
        setState(() {});
      }
    });
    setState(() {
      isLoadingNotifier = false;
    });
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
          onSubmitted: (p0) {

            // context.navigatepushReplacement(SearchResultView(
            //   resultData: resultData,
            //   text: p0,
            // ));
          },
          onChange: (p0) {
            if (p0 == "") {
              topMatches.clear();
              resultData.clear();
              setState(() {});
            } else {
              updateSuggestions(p0);
              getdata(isScroll: false, text: _searchController.text);
            }
          },
          onIconTap: () {
            _searchController.clear();
            topMatches.clear();
            resultData.clear();
            setState(() {});
          },
          showCloseIcon: _searchController.text.isNotEmpty,
          focusNode: _focusNode,
          searchController: _searchController,
          hintText: 'Workouts, trainers, exercises',
        ),
        actions: [
          GestureDetector(
            onTap: () {
              context.hideKeypad();
              _searchController.clear();

              topMatches.clear();
              resultData.clear();
              setState(() {});
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
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          1.height(),
          buildSuggestions(),
          Flexible(
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (isLoadingNotifier == false &&
                    _searchController.text.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: topMatches.isNotEmpty
                            ? BorderRadius.circular(20)
                            : null,
                        color: AppColor.textInvertEmphasis),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isNodData == true
                            ? const CustomErrorWidget()
                            : resultData.isEmpty &&
                                    _searchController.text.isNotEmpty
                                ? const NoResultFOundWIdget()
                                : Expanded(
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
                                                    if (resultData[index]
                                                            .collection ==
                                                        CategoryName.workouts) {
                                                      context.navigateTo(
                                                          WorkoutDetailView(
                                                              id: resultData[
                                                                      index]
                                                                  .entityId
                                                                  .toString()));
                                                    } else if (resultData[index]
                                                            .collection ==
                                                        CategoryName
                                                            .videoClasses) {
                                                      context.navigateTo(
                                                          VideoAudioDetailView(
                                                              id: resultData[
                                                                      index]
                                                                  .entityId
                                                                  .toString()));
                                                    } else if (resultData[index]
                                                            .collection ==
                                                        CategoryName
                                                            .audioClasses) {
                                                      context.navigateTo(
                                                          VideoAudioDetailView(
                                                              id: resultData[
                                                                      index]
                                                                  .entityId
                                                                  .toString()));
                                                    } else if (resultData[index]
                                                            .collection ==
                                                        CategoryName
                                                            .trainingPlans) {
                                                      context.navigateTo(
                                                          TrainingPlanDetailView(
                                                        id: resultData[index]
                                                            .entityId
                                                            .toString(),
                                                      ));
                                                    }
                                                  },
                                                  imageHeaderIcon: resultData[
                                                                  index]
                                                              .collection ==
                                                          CategoryName.workouts
                                                      ? AppAssets
                                                          .workoutHeaderIcon
                                                      : resultData[index]
                                                                  .collection ==
                                                              CategoryName
                                                                  .audioClasses
                                                          ? AppAssets
                                                              .headPhoneIcon
                                                          : resultData[index]
                                                                      .collection ==
                                                                  CategoryName
                                                                      .trainingPlans
                                                              ? AppAssets
                                                                  .calendarIcon
                                                              : AppAssets
                                                                  .videoPlayIcon,
                                                  imageUrl: resultData[index]
                                                      .image
                                                      .toString(),
                                                  subtitle:
                                                      '${resultData[index].duration} min • ${resultData[index].categories?.map((e) => e.label).join(',')} • ${resultData[index].level}',
                                                  title: resultData[index]
                                                      .title
                                                      .toString()),
                                              if (index ==
                                                      resultData.length - 1 &&
                                                  nextPage == false)
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
                                        itemCount: resultData.length),
                                  ),
                        if (isLoadMore == true)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: BaseHelper.loadingWidget(),
                            ),
                          ),
                      ],
                    ),
                  ),
                if (isLoadingNotifier) ...[
                  ModalBarrier(
                      dismissible: false,
                      color: AppColor.surfaceBackgroundColor),
                  Center(child: BaseHelper.loadingWidget()),
                ]
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildSuggestions() {
    if (topMatches.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StringComparator(
            string1: topMatches,
            string2: _searchController,
            onTap: (p0) {
              _searchController.text = p0;
              getdata(isScroll: false, text: _searchController.text);
            },
          )
        ],
      ),
    );
  }
}

class StringComparator extends StatefulWidget {
  const StringComparator(
      {super.key,
      required this.string1,
      required this.string2,
      required this.onTap});
  final List<String> string1;
  final TextEditingController string2;
  final Function(String) onTap;

  @override
  State<StringComparator> createState() => _StringComparatorState();
}

class _StringComparatorState extends State<StringComparator> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: widget.string1.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: AppColor.linkPrimaryColor,
                size: 20,
              ),
              8.width(),
              RichText(
                text: TextSpan(
                  style: AppTypography.label16MD,
                  children: _compareWords(
                      widget.string1[index], widget.string2.text, widget.onTap),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<TextSpan> _compareWords(
      String text1, String text2, void Function(String) onTap) {
    List<TextSpan> spans = [];

    for (int j = 0; j < text1.length; j++) {
      bool isMatched = j < text2.length &&
          text1[j].toLowerCase().trim().replaceAll(RegExp(r'[^\w\s]+'), '') ==
              text2[j].toLowerCase().trim().replaceAll(RegExp(r'[^\w\s]+'), '');

      spans.add(
        TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              onTap(text1);
            },
          text: text1[j],
          style: TextStyle(
            color: isMatched
                ? AppColor.linkPrimaryColor
                : AppColor.linkSecondaryColor,
          ),
        ),
      );
    }

    return spans;
  }
}

/*
       int newIndex = 0;
        for (var k = 0; k < text2.length; k++) {
          for (var j = 0; j < text1[index].toLowerCase().length; j++) {
            newIndex = text1[index]
                .toLowerCase()
                .trim()[j]
                .indexOf(text2.toLowerCase().trim());
          }
        }
        if (te.isNotEmpty) {
          List<TextSpan> textSpans = [];

          textSpans.add(
            TextSpan(
              text: topMatches[index].substring(0, newIndex),
              style: TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          );

          textSpans.add(
            TextSpan(
              text: topMatches[index].substring(newIndex),
              style: TextStyle(color: Colors.black),
            ),
          );

          return RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: textSpans,
            ),
          );
        }
      },
*/

/*Autocomplete(
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            } else {
              return const Iterable<String>.empty();
            }
          },
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            focusNode.requestFocus();
            return CustomSearchTextFieldWidget(
              onChange: (p0) {
                setState(() {});
              },
              searchController: textEditingController,
              focusNode: focusNode,
              hintText: 'Workouts, trainers, exercises',
              onIconTap: () {
                textEditingController.clear();
                setState(() {});
              },
              showCloseIcon: textEditingController.text.isNotEmpty,
            );
          },
        ), */
