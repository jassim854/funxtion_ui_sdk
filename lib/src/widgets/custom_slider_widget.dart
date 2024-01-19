import 'package:flutter/material.dart';

import '../../ui_tool_kit.dart';

class CustomSLiderWidget extends StatelessWidget {
  CustomSLiderWidget(
      {super.key,
      required this.sliderValue,
      required this.division,
      this.backgroundColor,
      this.valueColor});
  int division;
  double sliderValue;
  Color? backgroundColor, valueColor;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: LinearProgressIndicator(
          minHeight: 8,
       
          backgroundColor: backgroundColor ??
              AppColor.surfaceBrandDarkColor.withOpacity(0.1),
          valueColor: AlwaysStoppedAnimation(
            valueColor ?? AppColor.surfaceBrandDarkColor,
          ),
          value: sliderValue / division),
    );
   
  }
}
