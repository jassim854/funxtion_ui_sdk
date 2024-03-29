import 'package:flutter/material.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';

class HeaderExerciseInfoSheet extends StatelessWidget {
  final String title;
  const HeaderExerciseInfoSheet({
    super.key,
    required this.title,
  });

  String headerInfo(BuildContext context) {
    return title == "Single Exercise"
        ? context.loc.itemTypeInfo("single")
        : title == "Circuit Time"
            ? context.loc.itemTypeInfo("circuit")
            : title == "RFT Exercises"
                ? context.loc.itemTypeInfo("rft")
                : title == "Super Set"
                    ? context.loc.itemTypeInfo("ss")
                    : title == "Circuit Repetition"
                        ? context.loc.itemTypeInfo("reps")
                        : title == "AmRap"
                            ? context.loc.itemTypeInfo("amrap")
                            : title == "Enom"
                                ? context.loc.itemTypeInfo("enom")
                                : '';
  }

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
            headerInfo(context),
            style: AppTypography.paragraph16LG
                .copyWith(color: AppColor.textPrimaryColor),
          ),
        )
      ],
    );
  }
}
