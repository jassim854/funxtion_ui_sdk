import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class CustomListtileWidget extends StatelessWidget {
  final int index;
  final WidgetRef ref;
  final String routeName;
  final Object? argument;
  const CustomListtileWidget(this.ref, this.index,
      {super.key, required this.routeName, this.argument});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.hideKeypad();

        context.navigateToNamed(routeName, arguments: argument);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                height: context.dynamicHeight * 0.09,
                width: context.dynamicWidth * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: cacheNetworkWidget(
                      imageUrl:
                          ref.watch(videoProvider).data[index].image.toString(),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                height: context.dynamicHeight * 0.09,
                width: context.dynamicWidth * 0.2,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(4),
                child: SvgPicture.asset(
                  AppAssets.videoPlayIcon,
                  color: AppColor.whiteColor,
                ),
              ),
            ],
          ),
          16.width(),
          SizedBox(
            width: context.dynamicWidth * 0.65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ref.watch(videoProvider).data[index].title.substring(10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.label16MD,
                ),
                5.height(),
                Text(
                  "${ref.watch(videoProvider).data[index].duration.substring(3)} min • ${ref.watch(videoProvider).data[index].type}` • ${ref.watch(videoProvider).data[index].level} ",
                  style: AppTypography.paragraph14MD,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
