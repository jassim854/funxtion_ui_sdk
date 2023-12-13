import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../ui_tool_kit.dart';

class CustomRowTextChartIcon extends StatefulWidget {
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
  State<CustomRowTextChartIcon> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CustomRowTextChartIcon> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.text1,
          style: AppTypography.label16MD
              .copyWith(color: AppColor.textEmphasisColor),
        ),
        widget.secondWidget != null
            ? widget.secondWidget!
            : Row(
                children: [
                  Text(
                    widget.text2.toString(),
                    style: AppTypography.label14SM
                        .copyWith(color: AppColor.textPrimaryColor),
                  ),
                  if (widget.isChartIcon == true)
                    widget.level?.contains(
                                RegExp("beginner", caseSensitive: false)) ??
                            false
                        ? Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: SvgPicture.asset(
                              AppAssets.chartLowIcon,
                              height: 22,
                            ),
                          )
                        : widget.level?.contains(RegExp("intermediate",
                                    caseSensitive: false)) ??
                                false
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: SvgPicture.asset(
                                  height: 22,
                                  AppAssets.chatMidIcon,
                                ),
                              )
                            : widget.level?.contains(RegExp("advanced",
                                        caseSensitive: false)) ??
                                    false
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: SvgPicture.asset(
                                      height: 22,
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
