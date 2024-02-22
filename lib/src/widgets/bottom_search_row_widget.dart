import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../ui_tool_kit.dart';

class BottomSearchWIdget extends StatefulWidget {
  final TextEditingController searchController;
  final void Function(String) searchDelayFn;
  final void Function() requestCall;

  final ValueNotifier<List<SelectedFilterModel>> confirmedFilter;
  final CategoryName categoryName;
  const BottomSearchWIdget({
    super.key,
    required this.searchController,
    required this.searchDelayFn,
    required this.confirmedFilter,
    required this.categoryName,
    required this.requestCall,
  });

  @override
  State<BottomSearchWIdget> createState() => _BottomSearchWIdgetState();
}

class _BottomSearchWIdgetState extends State<BottomSearchWIdget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomSearchTextFieldWidget(
                hintText: context.loc.hintSearchText2,
                showCloseIcon: widget.searchController.text.isNotEmpty,
                onChange: (value) {
                  widget.searchDelayFn(value);
                },
                onIconTap: () {
                  context.hideKeypad();
                  widget.searchController.clear();

                  widget.requestCall();
                },
                searchController: widget.searchController)),
        widget.searchController.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  widget.searchController.clear();

                  ListController.clearAppliedFilter(widget.confirmedFilter);

                  widget.requestCall();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 20),
                  child: Text('Cancel',
                      style: AppTypography.label14SM.copyWith(
                        color: AppColor.textEmphasisColor,
                      )),
                ),
              )
            : iconFilterWidget(context)
      ],
    );
  }

  iconFilterWidget(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.hideKeypad();
        await showModalBottomSheet(
          useSafeArea: true,
          enableDrag: false,
          isDismissible: false,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          backgroundColor: AppColor.surfaceBackgroundBaseColor,
          isScrollControlled: true,
          context: context,
          builder: (_) {
            return PopScope(
              canPop: false,
              child: FilterSheetWidget(
                confirmedFilter: widget.confirmedFilter,
                onDone: (value) {
                  if (value.isNotEmpty ||
                      ListController.restConfirmFilterAlso == true) {
                    ListController.restConfirmFilterAlso = false;
                    ListController.confirmFilter(
                        confirmedFilter: widget.confirmedFilter,
                        selectedFilter: value);
                    widget.requestCall();
                  }
                },
                categoryName: widget.categoryName,
              ),
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
        decoration: BoxDecoration(
            color: widget.confirmedFilter.value.isEmpty
                ? null
                : AppColor.textEmphasisColor,
            borderRadius: BorderRadius.circular(12)),
        child: SvgPicture.asset(AppAssets.iconFilter,
            color: widget.confirmedFilter.value.isEmpty
                ? AppColor.textEmphasisColor
                : AppColor.textInvertEmphasis),
      ),
    );
  }
}
