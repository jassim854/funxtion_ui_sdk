import 'package:flutter/material.dart';
import 'package:ui_tool_kit/src/utils/utils.dart';

class CustomDivider extends StatelessWidget {
  final double? endIndent, indent;

  const CustomDivider({
    super.key,
    this.endIndent,
    this.indent,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
        color: AppColor.dividerColor,
        thickness: 1,
        endIndent: endIndent,
        height: 20,
        indent: indent);
  }
}
