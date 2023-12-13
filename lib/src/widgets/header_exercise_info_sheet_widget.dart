import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class HeaderExerciseInfoSheet extends StatelessWidget {
  final String title,infoHeader;
  const HeaderExerciseInfoSheet({super.key, required this.title, required this.infoHeader});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
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
                  margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
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
          const CustomDivider(),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: AppColor.surfaceBackgroundColor,
            ),
            child:   Text(
                    infoHeader,
                    style: AppTypography.paragraph16LG
                        .copyWith(color: AppColor.textPrimaryColor),
                  ),
          )
        ],
      ),
    );
  }
}
