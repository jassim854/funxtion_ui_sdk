
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:ui_tool_kit/src/utils/utils.dart';

class BaseHelper {
  static showSnackBar(context, msg, {Duration? duration,Color? backgroundColor,Color? textColor}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          msg,
          style: AppTypography.title14XS
              .copyWith(color:textColor?? AppColor.textEmphasisColor),
        ),
        backgroundColor:backgroundColor?? Colors.white,
        margin: const EdgeInsets.all(5),
        duration: duration ?? const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        action: duration != null
            ? SnackBarAction(
                label: 'CLOSE',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                })
            : null));
  }

  static CircularProgressIndicator loadingWidget(
      {double? value,
      double? strokeWidth,
      Color? valueColor,
      Color? backgroundColor}) {
    return CircularProgressIndicator.adaptive(
      value: value,
      strokeWidth:
          strokeWidth ?? const CircularProgressIndicator.adaptive().strokeWidth,
      backgroundColor: Platform.isIOS
          ? null
          : backgroundColor ?? AppColor.textInvertSubtitle,
      valueColor:
          AlwaysStoppedAnimation(valueColor ?? AppColor.linkTeritaryCOlor),
    );
  }
}
