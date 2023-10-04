import 'package:flutter/material.dart';

import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class AuthController {
  
  static Future<bool> login(BuildContext context) async {
    try {
      await AuthRequest.loginUser(
              username: 'nasir@evolverstech.com', password: 'P@ss.1122')
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
