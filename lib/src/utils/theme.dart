import 'package:flutter/material.dart';

import 'utils.dart';

ThemeData appThemes() {
  return ThemeData(
      scaffoldBackgroundColor: AppColor.surfaceBackgroundBaseColor,
      appBarTheme:  AppBarTheme(
          elevation: 0, backgroundColor: AppColor.surfaceBrandDarkColor));
}
