import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideoAudioDetailView extends StatefulWidget {
  final String id;
  const VideoAudioDetailView({
    super.key,
    required this.id,
  });

  @override
  State<VideoAudioDetailView> createState() => _VideoAudioDetailViewState();
}

class _VideoAudioDetailViewState extends State<VideoAudioDetailView> {
  bool isLoadingNotifier = false;
  bool isNodData = false;
  OnDemandModel? onDemamdModelData;
  InstructorModel? instructorModelData;
  late ScrollController scrollController;
  List<EquipmentModel> equipmentData = [];
  ValueNotifier<bool> centerTitle = ValueNotifier(false);
  String onDemandCategoryFilterData = "";
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
    setState(() {
      isLoadingNotifier = true;
      isNodData = false;
    });
    try {
      await CategoryDetailController.getOnDemandData(context, id: widget.id)
          .then((value) async {
        if (value != null) {
          isLoadingNotifier = false;
          onDemamdModelData = value;
          onDemandCategoryFilterData =
              CategoryDetailController.getOnDemandCategoryData(value);

          if (onDemamdModelData?.instructorId.toString() != "null") {
            instructorModelData = await CategoryDetailController.getInstructor(
                context,
                id: onDemamdModelData?.instructorId.toString() ?? "");
          }
          if (onDemamdModelData?.equipment?.isNotEmpty ?? false) {
            for (var i = 0; i < onDemamdModelData!.equipment!.length; i++) {
              await CategoryDetailController.getEquipment(context,
                      id: onDemamdModelData?.equipment?[i].toString() ?? "")
                  .then((value) {
                equipmentData.add(value as EquipmentModel);
              });
            }
          }

          setState(() {});
        } else {
          isLoadingNotifier = false;
          isNodData = true;
          setState(() {});
        }
      });
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoadingNotifier == true
            ? const LoaderStackWidget()
            : isNodData == true
                ? const CustomErrorWidget()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: context.dynamicHeight * 0.32,
                      //   child: Stack(fit: StackFit.expand, children: [
                      //     Container(
                      //       child: cacheNetworkWidget(
                      //           imageUrl: onDemamdModelData?.mapImage?.url
                      //                   .toString() ??
                      //               "",
                      //           fit: BoxFit.cover),
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         color: Colors.black.withOpacity(0.3),
                      //       ),
                      //     ),
                      //     Positioned(
                      //       bottom: 17,
                      //       left: 20,
                      //       right: 20,
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             "${onDemamdModelData?.title}",
                      //             maxLines: 1,
                      //             overflow: TextOverflow.ellipsis,
                      //             style: AppTypography.title24XL.copyWith(
                      //                 color: AppColor.textInvertEmphasis),
                      //           ),
                      //           5.height(),
                      //           Text(
                      //             "${onDemamdModelData?.duration.getTextAfterSymbol()} min • ${onDemamdModelData?.type.toString().removeSymbolGetText()}",
                      //             style: AppTypography.label16MD.copyWith(
                      //                 color: AppColor.textInvertPrimaryColor),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Align(
                      //       alignment: Alignment.center,
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           playOnTap(context);
                      //         },
                      //         child: SvgPicture.asset(
                      //           AppAssets.playArrowIcon,
                      //           height: 38,
                      //           color: AppColor.textInvertEmphasis,
                      //         ),
                      //       ),
                      //     ),
                      //     Positioned(
                      //       left: 19,
                      //       top: 23,
                      //       child: Transform.scale(
                      //         scale: 0.85,
                      //         child: InkWell(
                      //           onTap: () {
                      //             context.maybePopPage();
                      //           },
                      //           child: Container(
                      //             alignment: Alignment.center,
                      //             padding: const EdgeInsets.all(2),
                      //             decoration: BoxDecoration(
                      //                 color: AppColor.surfaceBrandDarkColor,
                      //                 shape: BoxShape.circle),
                      //             child: SvgPicture.asset(
                      //               AppAssets.backArrowIcon,
                      //               color: AppColor.textInvertEmphasis,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     )
                      //   ]),
                      // ),
                      // descriptionWidget(),
                      // cardWidget(),
                      Expanded(
                        child: ValueListenableBuilder(
                            valueListenable: centerTitle,
                            builder: (_, value, child) {
                              return CustomScrollView(
                                physics: const BouncingScrollPhysics(),
                                controller: scrollController,
                                slivers: [
                                  SliverAppBarWidget(
                                    appBarTitle:
                                        "${onDemamdModelData?.title.trim()}",
                                    backGroundImg: onDemamdModelData
                                            ?.mapImage?.url
                                            .toString() ??
                                        "",
                                    flexibleTitle:
                                        "${onDemamdModelData?.title.trim()}",

                                    flexibleSubtitleWidget: Text(
                                      "${onDemamdModelData?.duration} min • $onDemandCategoryFilterData",
                                      style: AppTypography.label16MD.copyWith(
                                          color:
                                              AppColor.textInvertPrimaryColor),
                                    ),
                                    onStackChild: Align(
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        onTap: () {
                                          playOnTap(context);
                                        },
                                        child: SvgPicture.asset(
                                          AppAssets.playArrowIcon,
                                          height: 38,
                                          color: AppColor.textInvertEmphasis,
                                        ),
                                      ),
                                    ),
                                    // flexibleTitle2:
                                    //     "${workoutData?.duration?.getTextAfterSymbol()} min • ${workoutData!.types!.isNotEmpty ? data.map((e) => e.name).join(',') : ''}",
                                    value: value,
                                  ),
                                  descriptionWidget(),
                                  cardWidget(),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
        bottomNavigationBar: isLoadingNotifier == true && isNodData == false
            ? null
            : bottomWidget(),
      ),
    );
  }

  void playOnTap(BuildContext context) {
    return context.navigateTo(CategoryPlayerView(
        videoURL: onDemamdModelData?.mapVideo?.url ?? "",
        thumbNail: onDemamdModelData?.mapImage?.url ?? ""));
  }

  descriptionWidget() {
    return SliverToBoxAdapter(
      child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 40, top: 20),
          child: Text(onDemamdModelData?.description.toString() ?? "",
              style: AppTypography.paragraph16LG
                  .copyWith(color: AppColor.textPrimaryColor))),
    );
  }

  cardWidget() {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0.2,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 40, top: 20),
        color: AppColor.surfaceBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 16),
          child: Column(
            children: [
              CustomRowTextChartIcon(
                level: onDemamdModelData?.level.toString() ?? "No data",
                text1: 'Level',
                text2: onDemamdModelData?.level.toString() ?? "No data",
                isChartIcon: true,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: CustomDivider(),
              ),
              CustomRowTextChartIcon(
                  text1: 'Instructor',
                  text2: instructorModelData?.name.toString() ?? "No data"),
              if (onDemamdModelData?.type != 'audio-workout' &&
                  onDemamdModelData!.equipment?.isNotEmpty == true) ...[
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: CustomDivider(),
                ),
                CustomRowTextChartIcon(
                    text1: 'Equipment',
                    secondWidget: SizedBox(
                      height: 20,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: equipmentData.length,
                        itemBuilder: (context, index) {
                          if (index == 2) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("+${equipmentData.length - 2}",
                                    style: AppTypography.label14SM.copyWith(
                                      color: AppColor.textPrimaryColor,
                                    )),
                                2.width(),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor:
                                          AppColor.surfaceBackgroundBaseColor,
                                      useSafeArea: true,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) =>
                                          EquipmentExtendedSheet(
                                              title: onDemamdModelData?.title
                                                      .toString() ??
                                                  "",
                                              equipmentData: equipmentData),
                                    );
                                  },
                                  child: Transform.translate(
                                    offset: const Offset(0, -4),
                                    child: Icon(
                                      Icons.more_horiz,
                                      color: AppColor.textPrimaryColor,
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                          if (index == 1) {
                            return Text(",${equipmentData[index].name}",
                                style: AppTypography.label14SM.copyWith(
                                  color: AppColor.textPrimaryColor,
                                ));
                          }
                          if (index == 0) {
                            return Text(equipmentData[index].name,
                                style: AppTypography.label14SM.copyWith(
                                  color: AppColor.textPrimaryColor,
                                ));
                          }
                          return Container();
                        },
                      ),
                    ))
              ]
            ],
          ),
        ),
      ),
    );
  }

  Container bottomWidget() {
    return Container(
      color: AppColor.surfaceBackgroundColor,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24, top: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text("${onDemamdModelData?.title}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.title14XS
                            .copyWith(color: AppColor.textEmphasisColor)),
                  ],
                ),
                4.height(),
                Text(
                  "${onDemamdModelData?.duration} min",
                  style: AppTypography.paragraph12SM
                      .copyWith(color: AppColor.textPrimaryColor),
                ),
              ],
            ),
          ),
          Expanded(
            child: PlayButtonWidget(onPressed: () {
              playOnTap(context);
            }),
          ),
        ],
      ),
    );
  }
}
