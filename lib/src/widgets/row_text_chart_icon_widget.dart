import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../ui_tool_kit.dart';

class CustomRowTextChartIcon extends StatelessWidget {
  final String text1;
  final String? text2;
  final bool? isChartIcon;
  final String? level;
  final Widget? secondWidget;
  const CustomRowTextChartIcon(
      {super.key,
      required this.text1,
      this.text2,
      this.isChartIcon,
      this.level,
      this.secondWidget});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: AppTypography.label16MD
              .copyWith(color: AppColor.textEmphasisColor),
        ),
        secondWidget != null
            ? secondWidget!
            : Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Transform.translate(
                    offset: const Offset(0, 0),
                    child: Text(
                      text2.toString(),
                      style: AppTypography.label14SM
                          .copyWith(color: AppColor.textPrimaryColor),
                    ),
                  ),
                  if (isChartIcon == true)
                    level?.contains(RegExp("beginner", caseSensitive: false)) ??
                            false
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 8, bottom: 0.5),
                            child: SvgPicture.asset(
                              AppAssets.chartLowIcon,
                              
                              color: AppColor.textPrimaryColor,
                              height: 22,
                            ),
                          )
                        : level?.contains(RegExp("intermediate",
                                    caseSensitive: false)) ??
                                false
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 0.5),
                                child: SvgPicture.asset(
                                  height: 22,
                                  color: AppColor.textPrimaryColor,
                                  AppAssets.chatMidIcon,
                                ),
                              )
                            : level?.contains(RegExp("advanced",
                                        caseSensitive: false)) ??
                                    false
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 0.5),
                                    child: SvgPicture.asset(
                                      height: 22,
                                      color: AppColor.textPrimaryColor,
                                      AppAssets.chartFullIcon,
                                    ),
                                  )
                                : const SizedBox.shrink()
                ],
              ),
      ],
    );
  }
}
