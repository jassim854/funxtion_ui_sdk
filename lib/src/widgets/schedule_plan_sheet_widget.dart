import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

class ShedulePlanSheet extends StatefulWidget {
  final List<WeekName> weekName;
  final TrainingPlanModel? trainingPlanModel;
  const ShedulePlanSheet({
    super.key,
    required this.weekName,
    this.trainingPlanModel,
  });

  @override
  State<ShedulePlanSheet> createState() => _ShedulePlanSheetState();
}

class _ShedulePlanSheetState extends State<ShedulePlanSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      color: AppColor.surfaceBackgroundBaseColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    context.popPage();
                  },
                  child: const Icon(Icons.close)),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Schedule Training Plan",
                    style: AppTypography.label16MD,
                  )),
              Container()
            ],
          ),
          20.height(),
          Text(
            widget.trainingPlanModel?.title ?? '',
            style: AppTypography.title28_2XL,
          ),
          20.height(),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColor.surfaceBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Set your schedule',
                      style: AppTypography.paragraph14MD,
                    ),
                    Text(
                      '3/3 days',
                      style: AppTypography.label14SM,
                    ),
                  ],
                ),
                const Divider(),
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.weekName[index].name,
                            style: AppTypography.label16MD,
                          ),
                          Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              side: BorderSide(
                                  color: AppColor.linkPrimaryColor, width: 1.3),
                              activeColor: AppColor.buttonPrimaryColor,
                              value: widget.weekName[index].isChecked,
                              onChanged: (value) {
                                for (var element in widget.weekName) {
                                  if (element.name ==
                                      widget.weekName[index].name) {
                                    element.isChecked = value as bool;
                                    setState(() {});
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: widget.weekName.length)
              ],
            ),
          ),
          const Spacer(),
          Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: CustomElevatedButton(
                  elevation: 0,
                  btnColor: const Color(0xffE6EDFD),
                  padding: const EdgeInsets.all(8),
                  onPressed: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Text(
                      'Schedule Plan',
                      style: AppTypography.label18LG
                          .copyWith(color: const Color(0xff5A7DCE)),
                    ),
                  )))
        ],
      ),
    );
  }
}
