import 'package:flutter/material.dart';

import '../../ui_tool_kit.dart';

class EquipmentExtendedSheet extends StatelessWidget {
  const EquipmentExtendedSheet({
    super.key,
    required this.title,
    required this.equipmentData,
  });
  final String title;
  final List<EquipmentModel> equipmentData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 25,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.transparent, shape: BoxShape.circle),
                child: Icon(
                  Icons.close,
                  size: 19,
                  color: Colors.transparent,
                  // size: 30,
                ),
              ),
              Text(
                title,
                style: AppTypography.title18LG
                    .copyWith(color: AppColor.textEmphasisColor),
              ),
              InkWell(
                  onTap: () {
                    context.popPage();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: AppColor.borderSecondaryColor,
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.close,
                      size: 22,
                      color: AppColor.textPrimaryColor,
                      // size: 30,
                    ),
                  )),
            ],
          ),
        ),
        const CustomDivider(),
        Card(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
          color: AppColor.surfaceBackgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
                child: Text("Equipment",
                    style: AppTypography.label14SM
                        .copyWith(color: AppColor.textPrimaryColor)),
              ),
              const CustomDivider(),
              SizedBox(
                width: double.infinity,
                child: ListView.separated(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        child: Row(
                          children: [
                            Text(
                              equipmentData[index].name,
                              style: AppTypography.label16MD
                                  .copyWith(color: AppColor.textEmphasisColor),
                            ),
                            12.width(),
                            Text(
                              " ",
                              style: AppTypography.paragraph14MD
                                  .copyWith(color: AppColor.textPrimaryColor),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const CustomDivider();
                    },
                    itemCount: equipmentData.length),
              )
            ],
          ),
        ),
      ],
    );
  }
}
