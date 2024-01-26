import 'package:flutter/material.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class RowEndToEndTextWidget extends StatelessWidget {
  const RowEndToEndTextWidget({
    super.key,
    required this.columnText1,
    required this.rowText1,
    this. columnText2,
    this.seeOnTap
  });
  final String columnText1, rowText1;
  final String? columnText2;
  final VoidCallback? seeOnTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                columnText1,
                style: AppTypography.title18LG
                    .copyWith(color: AppColor.textEmphasisColor),
              ),
              if (columnText2 != null)
                Text(
                  columnText2.toString(),
                  style: AppTypography.paragraph14MD
                      .copyWith(color: AppColor.textPrimaryColor),
                ),
            ],
          ),
          InkWell(
            onTap: seeOnTap,
            child: Text(
              rowText1,
              style: AppTypography.label12XSM
                  .copyWith(color: AppColor.linkPrimaryColor),
            ),
          )
        ],
      ),
    );
  }
}
