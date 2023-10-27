import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class DetailWorkoutBottomSheet extends StatelessWidget {
  final ExerciseModel exerciseModel;
  const DetailWorkoutBottomSheet({super.key, required this.exerciseModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text(
                exerciseModel.name,
                style: AppTypography.title18LG
                    .copyWith(color: AppColor.textEmphasisColor),
              ),
              InkWell(
                onTap: () {
                  context.popPage();
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      color: AppColor.textInvertSubtitle,
                      shape: BoxShape.circle),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.close,
                    size: 16,
                  ),
                ),
              )
            ],
          ),
          const CustomDivider(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 40),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child:
                  cacheNetworkWidget(imageUrl: exerciseModel.mapGif?.url ?? ""),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: AppColor.surfaceBackgroundColor,
            ),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: exerciseModel.steps?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          color: AppColor.surfaceBackgroundBaseColor,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Text(
                        "${index + 1}",
                        style: AppTypography.label18LG
                            .copyWith(color: AppColor.textEmphasisColor),
                      ),
                    ),
                    title: Text(exerciseModel.steps?[index],
                        style: AppTypography.paragraph14MD.copyWith(
                          color: AppColor.textPrimaryColor,
                        )));
              },
              separatorBuilder: (context, index) {
                return const CustomDivider(
                  indent: 70,
                  endIndent: 30,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
