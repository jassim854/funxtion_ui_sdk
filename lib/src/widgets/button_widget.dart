import 'package:flutter/material.dart';
import 'package:ui_tool_kit/src/utils/utils.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? btnColor;
  final Widget child;
  final double? radius;
  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.btnColor,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: btnColor ?? AppColor.buttonLightBlueColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 12))),
      child: child,
    );
  }
}
