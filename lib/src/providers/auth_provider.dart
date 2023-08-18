import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

final authProvider = ChangeNotifierProvider<AuthProviderNotifier>((ref) {
  return AuthProviderNotifier();
});

class AuthProviderNotifier extends ChangeNotifier {
  login(BuildContext context) async {
    try {
      EasyLoading.show();
      await AuthRequest.loginUser(
              username: 'nasir@evolverstech.com', password: 'P@ss.1122')
          .then((value) {
        if (value == true) {
          print(AuthRequest.getToken);
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]).then((_) =>
              context.navigateToRemoveUntil(VideoCategoriesView.routeName));

          // Navigator.of(context)
        }
      });
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
    EasyLoading.dismiss();
    return;
  }
}
