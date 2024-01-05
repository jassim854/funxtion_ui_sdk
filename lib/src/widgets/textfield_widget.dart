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
      this.margin =
          const EdgeInsets.only(top: 10, left: 24, right: 10, bottom: 10),
      this.onFieldTap});
  bool? showCloseIcon;
  void Function()? onIconTap;
  void Function(String)? onChange;
  TextEditingController? searchController;
  String hintText;
  EdgeInsetsGeometry? margin;
  void Function()? onFieldTap;
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
        // enabled: onFieldTap != null ? false : true,
        magnifierConfiguration: TextMagnifier.adaptiveMagnifierConfiguration,
        textAlignVertical: TextAlignVertical.center,
        onTap: onFieldTap,
        onChanged: onChange,
        controller: searchController,
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
