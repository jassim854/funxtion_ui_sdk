import 'dart:developer';

import 'package:flutter/material.dart';

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
        if (scrollController.offset > 155) {
          centerTitle.value = true;
        } else if (scrollController.offset < 160) {
          centerTitle.value = false;
        }
      });
    fetchData();

    super.initState();
  }

  fetchData() async {
    setState(() {
      isLoadingNotifier = true;
      isNodData = false;
    });
    try {
      await VideoDetailController.getOnDemandData(context, id: widget.id)
          .then((value) async {
        if (value != null) {
          isLoadingNotifier = false;
          onDemamdModelData = value;
          onDemandCategoryFilterData =
              VideoDetailController.getOnDemandCategoryData(value);

          if (onDemamdModelData?.instructorId.toString() != "null") {
            instructorModelData = await VideoDetailController.getInstructor(
                context,
                id: onDemamdModelData?.instructorId.toString() ?? "");
          }
          if (onDemamdModelData?.equipment?.isNotEmpty ?? false) {
            for (var i = 0; i < onDemamdModelData!.equipment!.length; i++) {
              if (context.mounted) {
                await VideoDetailController.getEquipment(context,
                        id: onDemamdModelData?.equipment?[i].toString() ?? "")
                    .then((value) {
                  equipmentData.add(value as EquipmentModel);
                });
              }
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
      if (context.mounted) {
        BaseHelper.showSnackBar(context, e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoadingNotifier == true
          ? const LoaderStackWidget()
          : isNodData == true
              ? const CustomErrorWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  appBarTitle:
                                      "${onDemamdModelData?.title.trim()}",
                                  backGroundImg: onDemamdModelData
                                          ?.mapImage?.url
                                          .toString() ??
                                      "",
                                  flexibleTitle:
                                      "${onDemamdModelData?.title.trim()}",

                                  flexibleSubtitleWidget: Text(
                                    "${onDemamdModelData?.duration} ${context.loc.minText} • $onDemandCategoryFilterData",
                                    style: AppTypography.label16MD.copyWith(
                                        color: AppColor.textInvertPrimaryColor),
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
    );
  }

  void playOnTap(BuildContext context) {
    if (EveentTriggered.video_class_cta_pressed != null) {
      EveentTriggered.video_class_cta_pressed!(
          onDemamdModelData?.title.toString() ?? "",
          onDemamdModelData?.mapVideo?.url ?? "");
    }
    return context.navigateTo(VideoPlayerView(
        title: onDemamdModelData?.title.toString() ?? "",
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
              if (onDemamdModelData?.level.toString() != "")
                CustomRowTextChartIcon(
                  level: onDemamdModelData?.level.toString(),
                  text1: context.loc.levelText,
                  text2: onDemamdModelData?.level.toString(),
                  isChartIcon: true,
                ),
              if (instructorModelData?.name.toString() != "") ...[
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: CustomDivider(),
                ),
                CustomRowTextChartIcon(
                    text1: context.loc.instructorText,
                    text2: instructorModelData?.name.toString()),
              ],
              if (onDemamdModelData?.type != 'audio-workout' &&
                  onDemamdModelData!.equipment?.isNotEmpty == true) ...[
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: CustomDivider(),
                ),
                CustomRowTextChartIcon(
                    text1: context.loc.equipmentText,
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
                  "${onDemamdModelData?.duration} ${context.loc.minText}",
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
