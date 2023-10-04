import 'package:flutter/material.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class CustomSearchTextFieldWidget extends StatelessWidget {
  CustomSearchTextFieldWidget({
    super.key,
    required this.searchController,
    required this.showCloseIcon,
    this.onChange,
    this.onIconTap,
  });
  bool showCloseIcon;
  void Function()? onIconTap;
  void Function(String)? onChange;
  TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      magnifierConfiguration: TextMagnifier.adaptiveMagnifierConfiguration,
      textAlignVertical: TextAlignVertical.center,
      onChanged: onChange,
      controller: searchController,
      style: AppTypography.paragraph14MD
          .copyWith(color: AppColor.textSubTitleColor),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 10),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: 'Yoga, HIIT, cardio',
        constraints: const BoxConstraints(
            maxHeight: 0, maxWidth: 0, minHeight: 0, minWidth: 0),
        prefixIconConstraints: const BoxConstraints(minWidth: 40),
        suffixIcon: showCloseIcon
            ? InkWell(onTap: onIconTap, child: const Icon(Icons.cancel))
            : const SizedBox.shrink(),
        suffixIconColor: AppColor.surfaceBrandDarkColor,
        hintStyle: AppTypography.paragraph14MD
            .copyWith(color: AppColor.textSubTitleColor),
        prefixIcon: Icon(Icons.search, color: AppColor.textSubTitleColor),
      ),
    );
  }
}
