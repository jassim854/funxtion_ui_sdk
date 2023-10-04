import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideoDetailView extends StatefulWidget {
  final String id;
  const VideoDetailView({
    super.key,
    required this.id,
  });

  @override
  State<VideoDetailView> createState() => _VideoDetailViewState();
}

class _VideoDetailViewState extends State<VideoDetailView> {
  bool isLoadingNotifier = false;
  bool isNodData = false;
  OnDemandModel? onDemamdModelData;
  InstructorModel? instructorModelData;
  EquipmentModel? equipmentModelData;
  @override
  void initState() {
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
       CategoryDetailController.getOnDemandData(context, id: widget.id)
          .then((value) async {
        if (value != null) {
          isLoadingNotifier = false;
          onDemamdModelData = value;
          if (onDemamdModelData?.instructorId.toString() != "null") {
            instructorModelData = await CategoryDetailController.getInstructor(
                context,
                id: onDemamdModelData?.instructorId.toString() ?? "");
          }
          if (onDemamdModelData?.equipment?.isNotEmpty ?? false) {
            equipmentModelData = await CategoryDetailController.getEquipment(
                context,
                id: onDemamdModelData?.equipment?.first.toString() ?? "");
          }
          setState(() {});
          return;
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
                      SizedBox(
                        height: context.dynamicHeight * 0.3,
                        child: Stack(fit: StackFit.expand, children: [
                          Container(
                            child: cacheNetworkWidget(
                                imageUrl: onDemamdModelData?.mapImage?.url
                                        .toString() ??
                                    "",
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
                                  "${onDemamdModelData?.title.substring(10)}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.title24XL.copyWith(
                                      color: AppColor.textInvertEmphasis),
                                ),
                                5.height(),
                                Text(
                                  "${onDemamdModelData?.duration.getTextAfterSymbol()} min • ${onDemamdModelData?.type}` • ${onDemamdModelData?.level}",
                                  style: AppTypography.label16MD.copyWith(
                                      color: AppColor.textInvertPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
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
                        ]),
                      ),
                      descriptionWidget(),
                      cardWidget(),
                      const Spacer(),
                      bottomWidget()
                    ],
                  ),
      ),
    );
  }

  void playOnTap(BuildContext context) {
    return context.navigateTo(CategoryPlayerView(
        videoURL: onDemamdModelData?.mapVideo?.url ?? "",
        thumbNail: onDemamdModelData?.mapImage?.url ?? ""));
  }

  Padding descriptionWidget() {
    return Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 40, top: 20),
        child: Text(onDemamdModelData?.description.toString() ?? "",
            style: AppTypography.paragraph14MD
                .copyWith(color: AppColor.textPrimaryColor)));
  }

  Card cardWidget() {
    return Card(
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
            if (onDemamdModelData?.type != 'audio-workout') ...[
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: CustomDivider(),
              ),
              CustomRowTextChartIcon(
                text1: 'Equipment',
                text2: equipmentModelData?.name ?? "No data",
              )
            ]
          ],
        ),
      ),
    );
  }

  Container bottomWidget() {
    return Container(
      color: AppColor.surfaceBackgroundColor,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${onDemamdModelData?.title.substring(10)}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.title14XS
                      .copyWith(color: AppColor.textEmphasisColor)),
              4.height(),
              Text(
                "${onDemamdModelData?.duration.getTextAfterSymbol()} min",
                style: AppTypography.paragraph12SM
                    .copyWith(color: AppColor.textPrimaryColor),
              ),
            ],
          ),
          PlayButtonWidget(onPressed: () {
            playOnTap(context);
          }),
        ],
      ),
    );
  }
}
