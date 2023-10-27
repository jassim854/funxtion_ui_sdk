import 'package:flutter/material.dart';
import 'package:ui_tool_kit/src/utils/utils.dart';

class CustomDivider extends StatelessWidget {
  final double? endIndent, indent, thickness;

  const CustomDivider({super.key, this.endIndent, this.indent, this.thickness});

  @override
  Widget build(BuildContext context) {
    return Divider(
        color: AppColor.borderSecondaryColor,
        thickness: thickness ?? 1.5,
        endIndent: endIndent,
        height: 20,
        indent: indent);
  }
}
