import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';

class FilterSheetWidget extends ConsumerWidget {
  const FilterSheetWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: ref.watch(videoProvider).selectedFilter.isNotEmpty
                    ? () {
                        ref.read(videoProvider).resetFilter();
                      }
                    : null,
                child: Text('Reset',
                    style: ref.watch(videoProvider).selectedFilter.isNotEmpty
                        ? AppTypography.label14SM
                            .copyWith(color: AppColor.lightBlueHeaderColor)
                        : AppTypography.label14SM
                            .copyWith(color: AppColor.lightGreydColor)),
              ),
              Text(
                'Filter',
                style: AppTypography.label18LG
                    .copyWith(color: AppColor.blackColor),
              ),
              InkWell(
                onTap: () {
                  if (ref.watch(videoProvider).selectedFilter.isNotEmpty) {
                    ref.read(videoProvider).confirmFilter(context);
                  }

                  // print(ref.read(videoProvider).confirmedFilter);
                  context.popPage;
                },
                child: Text('Done',
                    style: AppTypography.label14SM
                        .copyWith(color: AppColor.lightBlueHeaderColor)),
              ),
            ],
          ),
        ),
        const CustomDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Level',
                style: AppTypography.title18LG
                    .copyWith(color: AppColor.blackColor)),
            12.height(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ref
                    .read(videoProvider)
                    .level
                    .map((e) => InkWell(
                        onTap: () {
                          ref.read(videoProvider).addFilter(
                              TypeFilterModel(type: "level", filter: e.text));
                          print(ref.read(videoProvider).selectedFilter);
                        },
                        child: levelContainer(context, e: e, ref: ref)))
                    .toList()),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 12),
              child: Text('Duration',
                  style: AppTypography.title18LG
                      .copyWith(color: AppColor.blackColor)),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ref
                    .read(videoProvider)
                    .duration
                    .map((e) => InkWell(
                        onTap: () {
                          ref.read(videoProvider).addFilter(TypeFilterModel(
                              type: "duration", filter: e.text));
                          print(ref.read(videoProvider).selectedFilter);
                        },
                        child: levelContainer(context, e: e, ref: ref)))
                    .toList()),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 12),
              child: Text('Location',
                  style: AppTypography.title18LG
                      .copyWith(color: AppColor.blackColor)),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ref
                    .read(videoProvider)
                    .location
                    .map((e) => InkWell(
                        onTap: () {
                          ref.read(videoProvider).addFilter(TypeFilterModel(
                              type: "location", filter: e.text));
                          print(ref.read(videoProvider).selectedFilter);
                        },
                        child: levelContainer(context, e: e, ref: ref)))
                    .toList()),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 12),
              child: Text('Type',
                  style: AppTypography.title18LG
                      .copyWith(color: AppColor.blackColor)),
            ),
            Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ref
                    .read(videoProvider)
                    .type
                    .map((e) => InkWell(
                        onTap: () {
                          ref.read(videoProvider).addFilter(
                              TypeFilterModel(type: "type", filter: e.text));
                          print(ref.read(videoProvider).selectedFilter);
                        },
                        child: levelContainer(context, e: e, ref: ref)))
                    .toList())
          ]),
        )
      ],
    );
  }

  Widget levelContainer(BuildContext context,
      {required IconTextModel e, required WidgetRef ref}) {
    return Container(
      padding: const EdgeInsets.all(16).copyWith(top: 18),
      width: e.imageName != null ? context.dynamicWidth * 0.28 : null,
      decoration: BoxDecoration(
          border: ref.watch(videoProvider).selectedFilter.any((element) {
            return element.filter == e.text;
          })
              ? Border.all(color: AppColor.blueBorderColor, width: 2)
              : null,
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          e.imageName != null
              ? SvgPicture.asset(
                  e.imageName.toString(),
                  color: ref.watch(videoProvider).selectedFilter.any((element) {
                    return element.filter == e.text;
                  })
                      ? AppColor.blueBorderColor
                      : AppColor.blackColor,
                )
              : const SizedBox.shrink(),
          4.height(),
          Text(
            e.text,
            style: AppTypography.label14SM.copyWith(
                color: ref.watch(videoProvider).selectedFilter.any((element) {
              return element.filter == e.text;
            })
                    ? AppColor.blueBorderColor
                    : AppColor.blackColor),
          )
        ],
      ),
    );
  }
}
