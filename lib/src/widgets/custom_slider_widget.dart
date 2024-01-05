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
          // color: AppColor.surfaceBrandDarkColor.withOpacity(0.1),
          backgroundColor: backgroundColor ??
              AppColor.surfaceBrandDarkColor.withOpacity(0.1),
          valueColor: AlwaysStoppedAnimation(
            valueColor ?? AppColor.surfaceBrandDarkColor,
          ),
          value: sliderValue / division),
    );
    // return SliderTheme(
    //   data: SliderThemeData(
    //       trackShape: RoundSliderTrackShape(),
    //       trackHeight: 7,
    //       activeTrackColor: AppColor.surfaceBrandDarkColor,
    //       inactiveTrackColor: AppColor.surfaceBrandDarkColor.withOpacity(0.1),
    //       thumbShape: SliderComponentShape.noThumb),
    //   child: Slider(
    //     min: 0,
    //     max: division.toDouble(),
    //     value: sliderValue,
    //     onChanged: (value) {},
    //   ),
    // );
  }
}

// class RoundSliderTrackShape extends SliderTrackShape {
//   /// Create a slider track that draws 2 rectangles.
//   const RoundSliderTrackShape({ this.disabledThumbGapWidth = 2.0 });

//   /// Horizontal spacing, or gap, between the disabled thumb and the track.
//   ///
//   /// This is only used when the slider is disabled. There is no gap around
//   /// the thumb and any part of the track when the slider is enabled. The
//   /// Material spec defaults this gap width 2, which is half of the disabled
//   /// thumb radius.
//   final double disabledThumbGapWidth;

//   @override
//   Rect getPreferredRect({
//    required RenderBox parentBox,
//     Offset offset = Offset.zero,
//     SliderThemeData? sliderTheme,
//     bool isEnabled=false,
//     bool isDiscrete=false,
//   }) {
//     final double overlayWidth = sliderTheme!.overlayShape!.getPreferredSize(isEnabled, isDiscrete).width;
//     final double trackHeight = sliderTheme.trackHeight!;
//     assert(overlayWidth >= 0);
//     assert(trackHeight >= 0);
//     assert(parentBox.size.width >= overlayWidth);
//     assert(parentBox.size.height >= trackHeight);

//     final double trackLeft = offset.dx + overlayWidth / 2;
//     final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
//     // TODO(clocksmith): Although this works for a material, perhaps the default
//     // rectangular track should be padded not just by the overlay, but by the
//     // max of the thumb and the overlay, in case there is no overlay.
//     final double trackWidth = parentBox.size.width - overlayWidth;
//     return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
//   }

//   @override
//   void paint(
//     PaintingContext context,
//     Offset offset, {
//    required RenderBox parentBox,
//    required SliderThemeData sliderTheme,
//   required  Animation<double> enableAnimation,
//   required  TextDirection textDirection,
//   required  Offset thumbCenter,
//   required  bool isDiscrete,
//   required  bool isEnabled,
//   }) {
//     // If the slider track height is 0, then it makes no difference whether the
//     // track is painted or not, therefore the painting can be a no-op.
//     if (sliderTheme.trackHeight == 0) {
//       return;
//     }

//     // Assign the track segment paints, which are left: active, right: inactive,
//     // but reversed for right to left text.
//     final ColorTween activeTrackColorTween = ColorTween(begin: sliderTheme.disabledActiveTrackColor , end: sliderTheme.activeTrackColor);
//     final ColorTween inactiveTrackColorTween = ColorTween(begin: sliderTheme.disabledInactiveTrackColor , end: sliderTheme.inactiveTrackColor);
//     final Paint activePaint = Paint()..color = activeTrackColorTween.evaluate(enableAnimation)!;
//     final Paint inactivePaint = Paint()..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
//     Paint leftTrackPaint;
//     Paint rightTrackPaint;
//     switch (textDirection) {
//       case TextDirection.ltr:
//         leftTrackPaint = activePaint;
//         rightTrackPaint = inactivePaint;
//         break;
//       case TextDirection.rtl:
//         leftTrackPaint = inactivePaint;
//         rightTrackPaint = activePaint;
//         break;
//     }

//     // Used to create a gap around the thumb iff the slider is disabled.
//     // If the slider is enabled, the track can be drawn beneath the thumb
//     // without a gap. But when the slider is disabled, the track is shortened
//     // and this gap helps determine how much shorter it should be.
//     // TODO(clocksmith): The new Material spec has a gray circle in place of this gap.
//     double horizontalAdjustment = 0.0;
//     if (!isEnabled) {
//       final double disabledThumbRadius = sliderTheme.thumbShape!.getPreferredSize(false, isDiscrete).width / 2.0;
//       final double gap = disabledThumbGapWidth * (1.0 - enableAnimation.value);
//       horizontalAdjustment = disabledThumbRadius + gap;
//     }

//     final Rect trackRect = getPreferredRect(
//         parentBox: parentBox,
//         offset: offset,
//         sliderTheme: sliderTheme,
//         isEnabled: isEnabled,
//         isDiscrete: isDiscrete,
//     );
//     final Rect leftTrackSegment = Rect.fromLTRB(trackRect.left, trackRect.top, thumbCenter.dx - horizontalAdjustment, trackRect.bottom);

//     // Left Arc
//     context.canvas.drawArc(
//       Rect.fromCircle(center: Offset(trackRect.left, trackRect.top + 11.0), radius: 11.0),
//       -pi * 3 / 2, // -270 degrees
//       pi, // 180 degrees
//       false,
//       trackRect.left - thumbCenter.dx == 0.0 ? rightTrackPaint : leftTrackPaint
//     );

//     // Right Arc
//     context.canvas.drawArc(
//       Rect.fromCircle(center: Offset(trackRect.right, trackRect.top + 11.0), radius: 11.0),
//       -pi / 2, // -90 degrees
//       pi, // 180 degrees
//       false,
//       trackRect.right - thumbCenter.dx == 0.0 ? leftTrackPaint : rightTrackPaint
//     );

//     context.canvas.drawRect(leftTrackSegment, leftTrackPaint);
//     final Rect rightTrackSegment = Rect.fromLTRB(thumbCenter.dx + horizontalAdjustment, trackRect.top, trackRect.right, trackRect.bottom);
//     context.canvas.drawRect(rightTrackSegment, rightTrackPaint);
//   }
// }

// class RoundSliderTrackShape extends SliderTrackShape {
//   /// Create a slider track that draws 2 rectangles.
//   const RoundSliderTrackShape({this.disabledThumbGapWidth = 2.0});

//   /// Horizontal spacing, or gap, between the disabled thumb and the track.
//   ///
//   /// This is only used when the slider is disabled. There is no gap around
//   /// the thumb and any part of the track when the slider is enabled. The
//   /// Material spec defaults this gap width 2, which is half of the disabled
//   /// thumb radius.
//   final double disabledThumbGapWidth;

//   @override
//   Rect getPreferredRect({
//     required RenderBox parentBox,
//     Offset offset = Offset.zero,
//     required SliderThemeData sliderTheme,
//     bool isEnabled = false,
//     bool isDiscrete = false,
//   }) {
//     final overlayWidth =
//         sliderTheme.overlayShape!.getPreferredSize(isEnabled, isDiscrete).width;
//     final trackHeight = sliderTheme.trackHeight;
//     assert(overlayWidth >= 0);
//     assert(trackHeight! >= 0);
//     assert(parentBox.size.width >= overlayWidth);
//     assert(parentBox.size.height >= trackHeight!);

//     final double trackLeft = offset.dx + overlayWidth / 2;
//     final double trackTop =
//         offset.dy + (parentBox.size.height - trackHeight!) / 2;
//     // TODO(clocksmith): Although this works for a material, perhaps the default
//     // rectangular track should be padded not just by the overlay, but by the
//     // max of the thumb and the overlay, in case there is no overlay.
//     final double trackWidth = parentBox.size.width - overlayWidth;
//     return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
//   }

//   @override
//   void paint(PaintingContext context, Offset offset,
//       {required RenderBox parentBox,
//       required SliderThemeData sliderTheme,
//       required Animation<double> enableAnimation,
//       required Offset thumbCenter,
//       Offset? secondaryOffset,
//       bool isEnabled = false,
//       bool isDiscrete = false,
//       required TextDirection textDirection}) {
//     // If the slider track height is 0, then it makes no difference whether the
//     // track is painted or not, therefore the painting can be a no-op.
//     if (sliderTheme.trackHeight == 0) {
//       return;
//     }

//     // Assign the track segment paints, which are left: active, right: inactive,
//     // but reversed for right to left text.
//     final ColorTween activeTrackColorTween = ColorTween(
//         begin: sliderTheme.disabledActiveTrackColor,
//         end: sliderTheme.activeTrackColor);
//     final ColorTween inactiveTrackColorTween = ColorTween(
//         begin: sliderTheme.disabledInactiveTrackColor,
//         end: sliderTheme.inactiveTrackColor);
//     final Paint activePaint = Paint()
//       ..color = activeTrackColorTween.evaluate(enableAnimation)!;
//     final Paint inactivePaint = Paint()
//       ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
//     Paint leftTrackPaint;
//     Paint rightTrackPaint;
//     switch (textDirection) {
//       case TextDirection.ltr:
//         leftTrackPaint = activePaint;
//         rightTrackPaint = inactivePaint;
//         break;
//       case TextDirection.rtl:
//         leftTrackPaint = inactivePaint;
//         rightTrackPaint = activePaint;
//         break;
//     }

//     // Used to create a gap around the thumb iff the slider is disabled.
//     // If the slider is enabled, the track can be drawn beneath the thumb
//     // without a gap. But when the slider is disabled, the track is shortened
//     // and this gap helps determine how much shorter it should be.
//     // TODO(clocksmith): The new Material spec has a gray circle in place of this gap.
//     double horizontalAdjustment = 0.0;
//     if (!isEnabled) {
//       final double disabledThumbRadius =
//           sliderTheme.thumbShape!.getPreferredSize(false, isDiscrete).width /
//               2.0;
//       final double gap = disabledThumbGapWidth * (1.0 - enableAnimation.value);
//       horizontalAdjustment = disabledThumbRadius + gap;
//     }

//     final Rect trackRect = getPreferredRect(
//       parentBox: parentBox,
//       offset: Offset(0, 0),
//       sliderTheme: sliderTheme,
//       isEnabled: isEnabled,
//       isDiscrete: isDiscrete,
//     );
//     final Rect leftTrackSegment = Rect.fromLTRB(trackRect.left, trackRect.top,
//         offset.dx - horizontalAdjustment, trackRect.bottom);

//     // Left Arc
//     context.canvas.drawArc(
//         Rect.fromCircle(
//             center: Offset(trackRect.left, trackRect.top + 11.0), radius: 11.0),
//         -pi * 3 / 2, // -270 degrees
//         pi, // 180 degrees
//         false,
//         trackRect.left - offset.dx == 0.0 ? rightTrackPaint : leftTrackPaint);

//     // Right Arc
//     context.canvas.drawArc(
//         Rect.fromCircle(
//             center: Offset(trackRect.right, trackRect.top + 11.0),
//             radius: 11.0),
//         -pi / 2, // -90 degrees
//         pi, // 180 degrees
//         false,
//         trackRect.right - offset.dx == 0.0 ? leftTrackPaint : rightTrackPaint);

//     context.canvas.drawRect(leftTrackSegment, leftTrackPaint);
//     final Rect rightTrackSegment = Rect.fromLTRB(
//         offset.dx + horizontalAdjustment,
//         trackRect.top,
//         trackRect.right,
//         trackRect.bottom);
//     context.canvas.drawRect(rightTrackSegment, rightTrackPaint);
//   }
// }

// class CustomTrackShape extends SliderTrackShape {
//   @override
//   Rect getPreferredRect({
//     required RenderBox parentBox,
//     Offset offset = Offset.zero,
//     required SliderThemeData sliderTheme,
//     bool isEnabled = false,
//     bool isDiscrete = false,
//   }) {
//     final trackHeight = sliderTheme.trackHeight;
//     final trackLeft = offset.dx;
//     final trackTop = offset.dy;
//     final trackWidth = parentBox.size.width;

//     return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight!);
//   }

//   @override
//   void paint(PaintingContext context, Offset offset,
//       {required RenderBox parentBox,
//       required SliderThemeData sliderTheme,
//       required Animation<double> enableAnimation,
//       required Offset thumbCenter,
//       Offset? secondaryOffset,
//       bool isEnabled = false,
//       bool isDiscrete = false,
//       required TextDirection textDirection}) {
//     final Rect trackRect = getPreferredRect(
//         parentBox: parentBox,
//         sliderTheme: sliderTheme,
//         isEnabled: isEnabled,
//         isDiscrete: isDiscrete);
//     final ColorTween activeTrackColorTween = ColorTween(
//         begin: sliderTheme.disabledActiveTrackColor,
//         end: sliderTheme.activeTrackColor);
//     final ColorTween inactiveTrackColorTween = ColorTween(
//         begin: sliderTheme.disabledInactiveTrackColor,
//         end: sliderTheme.inactiveTrackColor);
//     final Paint activePaint = Paint()
//       ..color = activeTrackColorTween.evaluate(enableAnimation)!;
//     final Paint inactivePaint = Paint()
//       ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
//     Paint leftTrackPaint;
//     Paint rightTrackPaint;
//     switch (textDirection) {
//       case TextDirection.ltr:
//         leftTrackPaint = activePaint;
//         rightTrackPaint = inactivePaint;
//         break;
//       case TextDirection.rtl:
//         leftTrackPaint = inactivePaint;
//         rightTrackPaint = activePaint;
//         break;
//     }

//     // Calculate the radius for rounded edges
//     final double radius = trackRect.height / 0.1;

//     // Create a rounded rectangle path for the track

//     double horizontalAdjustment = 0.0;
//     final RRect trackRRect = RRect.fromRectAndCorners(
//       trackRect,
//       topLeft: Radius.circular(radius),
//       topRight: Radius.circular(radius),
//       bottomLeft: Radius.circular(radius),
//       bottomRight: Radius.circular(radius),
//     );
//     final Rect leftTrackSegment = Rect.fromLTRB(trackRect.left, trackRect.top,
//         thumbCenter.dx - horizontalAdjustment, trackRect.bottom);

//     // context.canvas.drawRRect(trackRRect, paint);
//     context.canvas.drawArc(
//         Rect.fromCircle(
//             center: Offset(trackRect.left, trackRect.top + 11.0), radius: 11.0),
//         -pi * 3 / 2, // -270 degrees
//         pi, // 180 degrees
//         false,
//         trackRect.left - thumbCenter.dx == 0.0
//             ? rightTrackPaint
//             : leftTrackPaint);

//     // Right Arc
//     context.canvas.drawArc(
//         Rect.fromCircle(
//             center: Offset(trackRect.right, trackRect.top + 11.0),
//             radius: 11.0),
//         -pi / 2, // -90 degrees
//         pi, // 180 degrees
//         false,
//         trackRect.right - thumbCenter.dx == 0.0
//             ? leftTrackPaint
//             : rightTrackPaint);

//     context.canvas.drawRect(leftTrackSegment, leftTrackPaint);
//     final Rect rightTrackSegment = Rect.fromLTRB(
//         thumbCenter.dx + horizontalAdjustment,
//         trackRect.top,
//         trackRect.right,
//         trackRect.bottom);
//     context.canvas.drawRect(rightTrackSegment, rightTrackPaint);
//   }
// }

// class CustomTrackShape extends RoundedRectSliderTrackShape {
//   @override
//   Rect getPreferredRect({
//     required RenderBox parentBox,
//     Offset offset = Offset.zero,
//     required SliderThemeData sliderTheme,
//     bool isEnabled = false,
//     bool isDiscrete = false,
//   }) {
//     final trackHeight = sliderTheme.trackHeight;
//     final trackLeft = offset.dx;
//     final trackTop = offset.dy;
//     final trackWidth = parentBox.size.width;
//     final borderRadius = BorderRadius.circular(trackHeight! / 2);
//     return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight!);
//   }
// }
// class CustomThumbShape extends SliderComponentShape {
//   final double thumbRadius;

//   CustomThumbShape({this.thumbRadius = 8.0});

//   @override
//   Size getPreferredSize(bool isEnabled, bool isDiscrete) {
//     return Size.fromRadius(thumbRadius);
//   }

//   @override
//   void paint(
//  PaintingContext context,
//   Offset center, {
//   required Animation<double> activationAnimation,
//   required Animation<double> enableAnimation,
//   required bool isDiscrete,
//   required TextPainter labelPainter,
//   required RenderBox parentBox,
//   required SliderThemeData sliderTheme,
//   required TextDirection textDirection,
//   required double value,
//   required bool isEnabled,
//   }) {
//     final canvas = context.canvas;
//     final radius = thumbRadius;

//     final paint = Paint()
//       ..color = isEnabled
//           ? sliderTheme.thumbColor ?? Colors.blue
//           : sliderTheme.disabledThumbColor ?? Colors.grey
//       ..style = PaintingStyle.fill;

//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromCircle(center: center, radius: radius),
//         Radius.circular(radius),
//       ),
//       paint,
//     );
//   }
// }
