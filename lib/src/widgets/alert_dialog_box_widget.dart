import 'package:flutter/material.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class ShowAlertDialogWidget extends StatelessWidget {
  final String title, body, btnText1, btnText2;

  const ShowAlertDialogWidget({
    super.key,
    required this.title,
    required this.body,
    required this.btnText1,
    required this.btnText2,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      backgroundColor: AppColor.surfaceBackgroundColor,
      elevation: 10,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: AppTypography.label18LG
          .copyWith(fontSize: 17, color: AppColor.textEmphasisColor),
      title: Text(title),
      content: Text(
        body,
        style: AppTypography.paragraph12SM
            .copyWith(fontSize: 13)
            .copyWith(color: AppColor.textEmphasisColor),
      ),
      actionsPadding: const EdgeInsets.only(right: 10, bottom: 10),
      // buttonPadding: EdgeInsets.zero,
      actions: [
        TextButton(
          child: Text(
            btnText1,
            style: AppTypography.paragraph18XL
                .copyWith(fontSize: 17, color: AppColor.linkPrimaryColor),
          ),
          onPressed: () {
            context.popPage(result: false);
          },
        ),
        TextButton(
          child: Text(btnText2,
              style: AppTypography.label18LG
                  .copyWith(fontSize: 17, color: AppColor.redColor)),
          onPressed: () {
            context.popPage(result: true);
          },
        ),
      ],
    );
  }
}
