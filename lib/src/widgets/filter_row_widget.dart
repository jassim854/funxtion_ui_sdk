import 'package:flutter/material.dart';

import '../../ui_tool_kit.dart';

class FilterContainer extends StatelessWidget {
  final String e;
  final VoidCallback onTap;
  const FilterContainer({super.key, required this.onTap, required this.e});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.linkTeritaryCOlor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              e.toString(),
              style: AppTypography.label14SM
                  .copyWith(color: AppColor.textInvertEmphasis),
            ),
            InkWell(
              onTap: onTap,
              child: Icon(
                Icons.close,
                color: AppColor.textInvertEmphasis,
              ),
            )
          ]),
    );
  }
}

class FilterRowWidget extends StatelessWidget {
  ValueNotifier<List<TypeFilterModel>> confirmedFilter;
  Function(TypeFilterModel value) deleteAFilterOnTap;
  VoidCallback hideOnTap;
  VoidCallback showOnTap;
  VoidCallback clearOnTap;
  FilterRowWidget(
      {super.key,
      required this.confirmedFilter,
      required this.deleteAFilterOnTap,
      required this.hideOnTap,
      required this.showOnTap,
      required this.clearOnTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: confirmedFilter.value.isEmpty
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: confirmedFilter.value.isEmpty
            ? []
            : [
                Expanded(
                  child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: confirmedFilter.value.length >= 2
                          ? [
                              Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: CategoryListController
                                              .isShowFilter ==
                                          false
                                      ? confirmedFilter.value
                                          .sublist(0, 2)
                                          .map((e) => FilterContainer(
                                              e: e.filter.toString(),
                                              onTap: () {
                                                deleteAFilterOnTap(e);
                                              }))
                                          .toList()
                                      : [
                                          for (int i = 0;
                                              i < confirmedFilter.value.length;
                                              i++)
                                            FilterContainer(
                                                e: confirmedFilter
                                                    .value[i].filter,
                                                onTap: () {
                                                  deleteAFilterOnTap(
                                                      confirmedFilter.value[i]);
                                                }),
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 9),
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColor.linkTeritaryCOlor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: InkWell(
                                                  onTap: hideOnTap,
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 18,
                                                    color: AppColor
                                                        .textInvertEmphasis,
                                                  )))
                                        ]),
                              confirmedFilter.value.length > 2 &&
                                      CategoryListController.isShowFilter ==
                                          false
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 9),
                                      decoration: BoxDecoration(
                                        color: AppColor.linkTeritaryCOlor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: InkWell(
                                        onTap: showOnTap,
                                        child: Text(
                                            "+${confirmedFilter.value.length - 2}",
                                            style: AppTypography.label14SM
                                                .copyWith(
                                                    color: AppColor
                                                        .textInvertEmphasis)),
                                      ),
                                    )
                                  : const SizedBox.shrink()
                            ]
                          : confirmedFilter.value
                              .map((e) => FilterContainer(
                                  e: e.filter.toString(),
                                  onTap: () {
                                    deleteAFilterOnTap(e);
                                  }))
                              .toList()),
                ),
                // if (confirmedFilter.value.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(),
                  child: InkWell(
                    onTap: clearOnTap,
                    child: Text(
                      'Clear',
                      style: AppTypography.label14SM.copyWith(
                          color: AppColor.linkTeritaryCOlor,
                          decorationStyle: TextDecorationStyle.solid,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                )
              ],
      ),
    );
  }
}
