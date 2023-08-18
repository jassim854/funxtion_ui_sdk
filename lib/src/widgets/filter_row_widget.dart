import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ui_tool_kit.dart';

class FilterRowWidget extends StatelessWidget {
  final WidgetRef ref;
  const FilterRowWidget({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: ref.watch(videoProvider).confirmedFilter == null ||
              ref.watch(videoProvider).confirmedFilter?.length == 0
          ? []
          : [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0).copyWith(right: 0),
                  child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ref
                                  .watch(videoProvider)
                                  .confirmedFilter!
                                  .length >=
                              3
                          ? [
                              Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: ref
                                              .watch(videoProvider)
                                              .isShowFilter ==
                                          false
                                      ? ref
                                          .watch(videoProvider)
                                          .confirmedFilter!
                                          .sublist(0, 3)
                                          .map((e) => filterCntainer(context,
                                              e: e.filter.toString(), ref: ref))
                                          .toList()
                                      : ref
                                          .watch(videoProvider)
                                          .confirmedFilter!
                                          .map((e) => filterCntainer(context,
                                              e: e.filter.toString(), ref: ref))
                                          .toList()),
                              ref.watch(videoProvider).confirmedFilter!.length >
                                          3 &&
                                      ref.watch(videoProvider).isShowFilter ==
                                          false
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 9),
                                      decoration: BoxDecoration(
                                        color: AppColor.appBarColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          ref
                                              .read(videoProvider)
                                              .showAllFiltter();
                                        },
                                        child: Text(
                                            "+${ref.watch(videoProvider).confirmedFilter!.length - 3}",
                                            style: AppTypography.label14SM
                                                .copyWith(
                                                    color:
                                                        AppColor.whiteColor)),
                                      ),
                                    )
                                  : ref
                                              .watch(videoProvider)
                                              .confirmedFilter!
                                              .length >
                                          3
                                      ? Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 9),
                                          decoration: BoxDecoration(
                                            color: AppColor.appBarColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: InkWell(
                                              onTap: () {
                                                ref
                                                    .read(
                                                        videoProvider.notifier)
                                                    .hideAllFilter();
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                size: 18,
                                                color: AppColor.whiteColor,
                                              )))
                                      : const SizedBox.shrink()
                            ]
                          : ref
                              .watch(videoProvider)
                              .confirmedFilter!
                              .map((e) => filterCntainer(context,
                                  e: e.filter.toString(), ref: ref))
                              .toList()),
                ),
              ),
              if (ref.watch(videoProvider).confirmedFilter != null)
                Padding(
                  padding: const EdgeInsets.only(
                      left: 6, top: 16, bottom: 16, right: 16),
                  child: InkWell(
                    onTap: () {
                      ref.read(videoProvider).resetFilter();
                    },
                    child: Text(
                      'Clear',
                      style: AppTypography.label14SM.copyWith(
                          color: AppColor.appBarColor,
                          decorationStyle: TextDecorationStyle.solid,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                )
            ],
    );
  }
}

Widget filterCntainer(context, {required String e, required WidgetRef ref}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: AppColor.appBarColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            e.toString(),
            style: AppTypography.label14SM.copyWith(color: AppColor.whiteColor),
          ),
          InkWell(
            onTap: () {
              ref.read(videoProvider).deleteAFilter(context, e);
            },
            child: const Icon(
              Icons.close,
              color: AppColor.whiteColor,
            ),
          )
        ]),
  );
}
