import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class CustomListtileWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Color? titleColor;
  final Color? subtitleColor;
  final Widget? onSubtitleWidget;
  final String? subtitle;
  final String imageHeaderIcon;
  final VoidCallback onTap;
  // final double width;
  const CustomListtileWidget({
    super.key,
    required this.imageUrl,
    this.subtitleColor,
    this.titleColor,
    required this.title,
    this.subtitle,
    required this.onTap,
    required this.imageHeaderIcon,
    this.onSubtitleWidget,
    // required this.width
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                // height: context.dynamicHeight * 0.09,
                // width: context.dynamicWidth * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: cacheNetworkWidget(context,
                  height: 80,
                width: 80,
                      imageUrl: imageUrl, fit: BoxFit.fill),
                ),
              ),
              Container(
                height: 80,
                width: 80,
                // height: context.dynamicHeight * 0.09,
                // width: context.dynamicWidth * 0.2,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(4),
                child: SvgPicture.asset(
                  imageHeaderIcon,
                  color: AppColor.textInvertEmphasis,
                ),
              ),
            ],
          ),
          16.width(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.label16MD.copyWith(
                      color: titleColor ?? AppColor.textEmphasisColor,
                    )),
                5.height(),
                Container(
                  // width: context.dynamicWidth * 0.2,
                  child: onSubtitleWidget ??
                      Text(
                        subtitle.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.paragraph14MD.copyWith(
                            color: subtitleColor ?? AppColor.textPrimaryColor),
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomTileTrainingPlanWidget extends StatelessWidget {
  const CustomTileTrainingPlanWidget(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.subtitle,
      required this.onTap});

  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                // height: context.dynamicHeight * 0.09,
                // width: context.dynamicWidth * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: cacheNetworkWidget(context,
                     height: 80,
                width: 80,
                      imageUrl: imageUrl, fit: BoxFit.fill),
                ),
              ),
              // Container(
              //   height: 80,
              //   width: 80,
              //   // height: context.dynamicHeight * 0.09,
              //   // width: context.dynamicWidth * 0.2,
              //   decoration: BoxDecoration(
              //     color: Colors.black.withOpacity(0.3),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.all(4),
                child: SvgPicture.asset(
                  AppAssets.workoutHeaderIcon,
                  color: AppColor.textInvertEmphasis,
                ),
              ),
            ],
          ),
          16.width(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.label16MD.copyWith(
                      color: AppColor.textEmphasisColor,
                    )),
                5.height(),
                Text(
                  subtitle,
                  style: AppTypography.paragraph14MD
                      .copyWith(color: AppColor.textPrimaryColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
