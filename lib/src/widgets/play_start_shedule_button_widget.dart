import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            child: FittedBox(
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
            ),
          )),
    );
  }
}

class StartButtonWidget extends StatelessWidget {
  const StartButtonWidget(
      {super.key,
      required this.onPressed,
      required this.btnChild,
      this.btnColor});

  final VoidCallback? onPressed;
  final Widget btnChild;
  final Color? btnColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: CustomElevatedButton(
          elevation: 0,
          btnColor: btnColor ?? AppColor.buttonTertiaryColor,
          onPressed: onPressed,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: btnChild)),
    );
  }
}

class SheduletButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Widget? child;
  const SheduletButtonWidget(
      {super.key, this.onPressed, required this.text, this.child});

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
        elevation: 0,
        btnColor: AppColor.buttonPrimaryColor,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: child ??
              Text(
                text.toString(),
                style: AppTypography.label16MD
                    .copyWith(color: AppColor.textInvertEmphasis),
              ),
        ));
  }
}
