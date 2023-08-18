import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:ui_tool_kit/src/utils/utils.dart';

class BaseHelper {
  static showSnackBar(context, msg, {Duration? duration}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          msg,
          style: AppTypography.title14XS.copyWith(color: AppColor.appBarColor),
        ),
        backgroundColor: Colors.white,
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

  static Future<bool> isInternetAvailable() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}
