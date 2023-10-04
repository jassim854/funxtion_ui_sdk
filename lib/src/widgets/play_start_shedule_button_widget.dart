import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/src/ui/view/start_workout_view.dart';

import '../../ui_tool_kit.dart';

class PlayButtonWidget extends StatelessWidget {
  const PlayButtonWidget({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: CustomElevatedButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppAssets.playArrowIcon,
                  color: AppColor.textInvertEmphasis,
                ),
                5.width(),
                Text(
                  'Play class',
                  style: AppTypography.label18LG
                      .copyWith(color: AppColor.textInvertEmphasis),
                )
              ],
            ),
          )),
    );
  }
}

class StartButtonWidget extends StatelessWidget {
  const StartButtonWidget({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: CustomElevatedButton(
          elevation: 0,
          btnColor: const Color(0xffE6EDFD),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              'Start Workout',
              style: AppTypography.label18LG
                  .copyWith(color: const Color(0xff5A7DCE)),
            ),
          )),
    );
  }
}



class SheduletButtonWidget extends StatelessWidget {
final VoidCallback? onPressed;
  const SheduletButtonWidget({
    super.key, this.onPressed,

  });

  

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
        elevation: 0,
        btnColor: const Color(0xffE6EDFD),
        padding: const EdgeInsets.all(8),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Text(
            'Schedule Plan',
            style: AppTypography.label18LG
                .copyWith(color: const Color(0xff5A7DCE)),
          ),
        ));
  }
}



