import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ui_tool_kit.dart';

final appProvider = ChangeNotifierProvider<AppProvider>((ref) {
  return AppProvider();
});

class AppProvider extends ChangeNotifier {
  late StreamSubscription _streamSubscription;
  void connectivity(context) {
    Connectivity().checkConnectivity().then((value) {
      log("connectivity pluss value $value");
      if (value == ConnectivityResult.none) {
        BaseHelper.showSnackBar(context, 'No internet',
            duration: const Duration(days: 1));
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
      _streamSubscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          log("connectivity pluss $result");

          if (result == ConnectivityResult.none) {
            BaseHelper.showSnackBar(context, 'No internet',
                duration: const Duration(days: 1));
          } else {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
        },
      );
    });
  }
}
