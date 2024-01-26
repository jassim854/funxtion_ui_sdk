import 'package:flutter/material.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';

class HeaderExerciseInfoSheet extends StatelessWidget {
  final String title, infoHeader;
  const HeaderExerciseInfoSheet(
      {super.key, required this.title, required this.infoHeader});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 16,
              ),
              Text(
                title,
                style: AppTypography.title18LG
                    .copyWith(color: AppColor.textEmphasisColor),
              ),
              InkWell(
                onTap: () {
                  context.popPage();
                },
                child: Container(
                  // margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      color: AppColor.textInvertSubtitle,
                      shape: BoxShape.circle),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.close,
                    size: 16,
                  ),
                ),
              )
            ],
          ),
        ),
        const CustomDivider(),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.surfaceBackgroundColor,
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            infoHeader,
            style: AppTypography.paragraph16LG
                .copyWith(color: AppColor.textPrimaryColor),
          ),
        )
      ],
    );
  }
}
