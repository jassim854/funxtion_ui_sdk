

import 'package:flutter/material.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class CustomSearchTextFieldWidget extends StatelessWidget {
  CustomSearchTextFieldWidget(
      {super.key,
      this.searchController,
      this.showCloseIcon,
      this.onChange,
      this.onIconTap,
      this.hintText = 'Yoga, HIIT, cardio',
      this.onSubmitted,
      this.margin =
          const EdgeInsets.only(top: 10, left: 20, right: 8, bottom: 12),
      this.onFieldTap,
      this.focusNode});
  bool? showCloseIcon;
  void Function()? onIconTap;
  void Function(String)? onChange;
  TextEditingController? searchController;
  String hintText;
  EdgeInsetsGeometry? margin;
  void Function()? onFieldTap;
  void Function(String)? onSubmitted;
  FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: AppColor.surfaceBackgroundSecondaryColor,
          borderRadius: BorderRadius.circular(12)),
      child: TextField(
        focusNode: focusNode,
        readOnly: onFieldTap != null ? true : false,
        magnifierConfiguration: TextMagnifier.adaptiveMagnifierConfiguration,
        textAlignVertical: TextAlignVertical.center,
        onTap: onFieldTap,
        onChanged: onChange,
        controller: searchController,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          if (onSubmitted != null) {
            onSubmitted!(value);
          }
        },
        style: AppTypography.paragraph14MD
            .copyWith(color: AppColor.textSubTitleColor),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 10),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
          constraints: const BoxConstraints(
              maxHeight: 0, maxWidth: 0, minHeight: 0, minWidth: 0),
          prefixIconConstraints: const BoxConstraints(minWidth: 40),
          suffixIcon: showCloseIcon == true
              ? InkWell(onTap: onIconTap, child: const Icon(Icons.cancel))
              : const SizedBox.shrink(),
          suffixIconColor: AppColor.surfaceBrandDarkColor,
          hintStyle: AppTypography.paragraph14MD
              .copyWith(color: AppColor.textSubTitleColor),
          prefixIcon: Icon(Icons.search, color: AppColor.textSubTitleColor),
        ),
      ),
    );
  }
}
