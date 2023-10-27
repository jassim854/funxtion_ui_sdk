import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class CustomListtileWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String imageHeaderIcon;
  final VoidCallback onTap;

  const CustomListtileWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.onTap, required this.imageHeaderIcon,
  });

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
                height: context.dynamicHeight * 0.09,
                width: context.dynamicWidth * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child:
                      cacheNetworkWidget(imageUrl: imageUrl, fit: BoxFit.cover),
                ),
              ),
              Container(
                height: context.dynamicHeight * 0.09,
                width: context.dynamicWidth * 0.2,
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
          SizedBox(
            width: context.dynamicWidth * 0.65,
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

class CustomTileWidget extends StatelessWidget {
  const CustomTileWidget(
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
                height: context.dynamicHeight * 0.09,
                width: context.dynamicWidth * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child:
                      cacheNetworkWidget(imageUrl: imageUrl, fit: BoxFit.cover),
                ),
              ),
              Container(
                height: context.dynamicHeight * 0.09,
                width: context.dynamicWidth * 0.2,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
          16.width(),
          SizedBox(
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
