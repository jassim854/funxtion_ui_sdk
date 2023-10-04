import 'package:flutter/material.dart';

import '../../ui_tool_kit.dart';

class BuildCardWidget extends StatelessWidget {
  final String title, subtitle;
  const BuildCardWidget(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 80),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.surfaceBackgroundColor),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            title,
            style: AppTypography.paragraph14MD
                .copyWith(color: AppColor.textSubTitleColor),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                subtitle,
                style: AppTypography.label16MD,
              ),
              if (subtitle.contains(RegExp(r'[0-9]')))
                Text(
                  ' min',
                  style: AppTypography.paragraph14MD
                      .copyWith(color: AppColor.textSubTitleColor),
                )
            ],
          )
        ]));
  }
}
