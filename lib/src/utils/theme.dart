import 'package:flutter/material.dart';

import 'utils.dart';

ThemeData appThemes() {
  return ThemeData(
      scaffoldBackgroundColor: AppColor.scaffoldBackgroundColor,
      appBarTheme: const AppBarTheme(
          elevation: 0, backgroundColor: AppColor.appBarColor));
}
