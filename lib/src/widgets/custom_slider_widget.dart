import 'package:flutter/material.dart';

import '../../ui_tool_kit.dart';

class CustomSLiderWidget extends StatelessWidget {
  CustomSLiderWidget({
    super.key,
    required this.sliderValue,
    required this.division,
  });
  int division;
  double sliderValue;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
          trackShape: CustomTrackShape(),
          trackHeight: 7,
          activeTrackColor: AppColor.surfaceBrandDarkColor,
          inactiveTrackColor: AppColor.surfaceBrandDarkColor.withOpacity(0.1),
          thumbShape: SliderComponentShape.noThumb),
      child: Slider(
        min: 0,
        max: division.toDouble(),
        divisions: division,
        value: sliderValue,
        onChanged: (value) {},
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight!);
  }
}
