import 'package:flutter/material.dart';

extension SpaceExtension on num {
  height() {
    return SizedBox(
      height: toDouble(),
    );
  }

  width() {
    return SizedBox(
      width: toDouble(),
    );
  }
}

extension NavigationExtensions on BuildContext {
  void popPage({Object? result}) {
    Navigator.of(this).pop(result);
  }

  void maybePopPage() {
    Navigator.of(this).maybePop();
  }

  void navigateTo(
    Widget screen,
  ) {
    Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  void navigatepushReplacement(Widget screen) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(
      builder: (context) => screen,
    ));
  }
}

extension DynanicSizeExtension on BuildContext {
  double get dynamicHeight => MediaQuery.of(this).size.height;

  double get dynamicWidth => MediaQuery.of(this).size.width;
  Size get dynamicSize => MediaQuery.of(this).size;
}

extension HideKeypad on BuildContext {
  void hideKeypad() => FocusScope.of(this).unfocus();
}

extension OmitSymbolText on String {
  getTextAfterSymbol() {
    int atIndex = indexOf('-');
    int lastAtIndex = lastIndexOf('-');

    if (atIndex != -1 && atIndex == lastAtIndex) {
      return substring(atIndex + 1);
    } else {
      return "";
    }
  }
}
