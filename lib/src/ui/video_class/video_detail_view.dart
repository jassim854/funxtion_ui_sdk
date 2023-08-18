import 'package:flutter/material.dart';

import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoDetailView extends ConsumerWidget {
  static const routeName = '/videoDetailView';
  final OnDemandModel data;
  const VideoDetailView({required this.data, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.dynamicHeight * 0.3,
              child: Stack(fit: StackFit.expand, children: [
                Container(
                  child: cacheNetworkWidget(
                      imageUrl: data.image.toString(), fit: BoxFit.cover),
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
                        data.title.substring(10),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.title24XL
                            .copyWith(color: AppColor.whiteColor),
                      ),
                      5.height(),
                      Text(
                        "${data.duration.substring(3)} min • ${data.type}` • ${data.level} ",
                        style: AppTypography.label16MD
                            .copyWith(color: AppColor.whiteColor),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // ref.read(videoPlayerProvider).init(
                    //       videoUrl: data.video.toString(),
                    //     );
                    context.navigateToNamed(VideoViewPotrait.routeName,
                        arguments: MapEntry(data.video, data.image));
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppAssets.playArrowIcon,
                      height: 38,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 40, top: 20),
                child: data.description == "null"
                    ? Text(
                        data.description.toString(),
                        style: AppTypography.paragraph14MD,
                      )
                    : Center(
                        child: Text(
                          'No description added',
                          style: AppTypography.paragraph14MD,
                        ),
                      )),
            Card(
              elevation: 0.2,
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 40, top: 20),
              color: AppColor.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 20, top: 16),
                child: Column(
                  children: [
                    CustomRowTextChartIcon(
                      data: data,
                      text1: 'Level',
                      text2: data.level,
                      isChartIcon: true,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: CustomDivider(),
                    ),
                    CustomRowTextChartIcon(
                      data: data,
                      text1: 'Instructor',
                      text2: data.type,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: CustomDivider(),
                    ),
                    CustomRowTextChartIcon(
                      data: data,
                      text1: 'Equipment',
                      text2: data.equipment!.map((e) => e).toString(),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              color: AppColor.whiteColor,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 24, top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.title.substring(10),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.label16MD),
                      4.height(),
                      Text(
                        "${data.duration.substring(3)} min",
                        style: AppTypography.paragraph14MD,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    child: CustomElevatedButton(
                        onPressed: () {
                          context.navigateToNamed(VideoViewPotrait.routeName,
                              arguments: MapEntry(data.video, data.image));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.playArrowIcon,
                                color: AppColor.whiteColor,
                              ),
                              5.width(),
                              Text(
                                'Play class',
                                style: AppTypography.label18LG,
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomRowTextChartIcon extends StatelessWidget {
  final String text1, text2;
  final bool? isChartIcon;
  final OnDemandModel data;
  const CustomRowTextChartIcon({
    super.key,
    required this.text1,
    required this.text2,
    this.isChartIcon,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: AppTypography.label16MD,
        ),
        Row(
          children: [
            Text(
              text2,
              style: AppTypography.label14SM,
            ),
            if (isChartIcon == true)
              data.level.contains(RegExp("beginner", caseSensitive: false))
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SvgPicture.asset(
                        AppAssets.chartLowIcon,
                        height: 22,
                      ),
                    )
                  : data.level.contains(
                          RegExp("intermediate", caseSensitive: false))
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: SvgPicture.asset(
                            height: 22,
                            AppAssets.chatMidIcon,
                          ),
                        )
                      : data.level.contains(
                              RegExp("advanced", caseSensitive: false))
                          ? Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: SvgPicture.asset(
                                height: 22,
                                AppAssets.chartFullIcon,
                              ),
                            )
                          : const SizedBox.shrink()
          ],
        )
      ],
    );
  }
}
