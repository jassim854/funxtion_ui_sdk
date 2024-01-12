import 'package:flutter/material.dart';
import 'package:ui_tool_kit/src/utils/utils.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? btnColor;
  final Widget child;
  final double? radius, elevation;
  final EdgeInsetsGeometry? childPadding;
  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.btnColor,
      this.elevation,
      this.radius,
      this.childPadding});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: btnColor ?? AppColor.linkSecondaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 16))),
      child: Padding(
        padding: childPadding ?? EdgeInsets.zero,
        child: Container(child: child),
      ),
    );
  }
}
