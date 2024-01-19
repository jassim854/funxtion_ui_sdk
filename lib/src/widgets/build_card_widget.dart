import 'package:flutter/material.dart';

import '../../ui_tool_kit.dart';

class BuildCardWidget extends StatelessWidget {
  final String title, subtitle;
  final bool checkNum;
  const BuildCardWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      this.checkNum = true});

  @override
  Widget build(BuildContext context) {
    return Container(
    
        alignment: Alignment.centerLeft,
        padding:
            const EdgeInsets.only(left: 16, top: 20, bottom: 20, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.surfaceBackgroundColor),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.label14SM
                    .copyWith(color: AppColor.textSubTitleColor),
              ),
              15.height(),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: subtitle,
                    style: AppTypography.title24XL
                        .copyWith(color: AppColor.textEmphasisColor)),
                if (checkNum == true
                    ? subtitle.contains(RegExp(r'[0-9]'))
                    : false)
                  TextSpan(
                    text: ' min',
                    style: AppTypography.label14SM
                        .copyWith(color: AppColor.textSubTitleColor),
                  )
              ])),
           
            ]));
  }
}
