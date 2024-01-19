import 'package:flutter/material.dart';

import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class AuthController {
  static String userName = 'FUNXTION_API_EMAIL';
  static String password = 'FUNXTION_API_PASSWORD';
  static Future<bool> login(BuildContext context) async {
    try {
      await AuthRequest.loginUser(username: userName, password: password)
          .then((value) {
        if (value == true) {
          print(AuthRequest.getToken);
          return true;
          // Navigator.of(context)
        }
      });
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    return false;
  }
}
