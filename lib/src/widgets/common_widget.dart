import 'package:flutter/material.dart';

import '../../ui_tool_kit.dart';

class LoaderStackWidget extends StatelessWidget {
  const LoaderStackWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ModalBarrier(
            dismissible: false, color: AppColor.surfaceBackgroundColor),
        Center(
          child: BaseHelper.loadingWidget(),
        )
      ],
    );
  }
}

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Error',
            style: AppTypography.title18LG,
          ),
          5.height(),
          Text(
            "Something went wrong",
            style: AppTypography.paragraph14MD
                .copyWith(color: AppColor.textPrimaryColor),
          )
        ],
      ),
    );
  }
}

class SliverAppBarWidget extends StatelessWidget {
  final bool value;
  bool isFollowingPlan;
  final Widget? widgetChild;
  final String appBarTitle, flexibleTitle, flexibleTitle2, backGroundImg;

  SliverAppBarWidget(
      {super.key,
      required this.value,
      required this.appBarTitle,
      required this.flexibleTitle,
      required this.flexibleTitle2,
      required this.backGroundImg,
      this.isFollowingPlan = false,
      this.widgetChild});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      stretch: true,
      backgroundColor: AppColor.surfaceBrandDarkColor,
      title: Visibility(
        visible: value == true ? true : false,
        child: Text(
          appBarTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.title24XL
              .copyWith(color: AppColor.textInvertEmphasis),
        ),
      ),
      leading: Transform.scale(
        scale: 0.6,
        child: InkWell(
          onTap: () {
            context.maybePopPage();
          },
          child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: AppColor.surfaceBrandDarkColor,
                  shape: BoxShape.circle),
              child: Transform.scale(
                  scale: 1.75,
                  child: const Icon(Icons.keyboard_arrow_left_sharp))),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          stretchModes: const [
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
            StretchMode.fadeTitle,
          ],
          expandedTitleScale: 1,
          titlePadding: const EdgeInsets.only(left: 30, bottom: 16),
          title: Visibility(
            visible: value == false ? true : false,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isFollowingPlan)
                    Container(
                      padding: const EdgeInsets.only(
                          top: 4, bottom: 4, right: 16, left: 6),
                      decoration: BoxDecoration(
                          color: AppColor.buttonTertiaryColor,
                          borderRadius: BorderRadius.circular(26)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: AppColor.buttonPrimaryColor,
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.check,
                              color: AppColor.surfaceBackgroundColor,
                              size: 16,
                            ),
                          ),
                          8.width(),
                          Text(
                            "Following",
                            style: AppTypography.label14SM
                                .copyWith(color: AppColor.buttonPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  Text(
                    flexibleTitle,
                    style: AppTypography.title24XL
                        .copyWith(color: AppColor.textInvertEmphasis),
                  ),
                  isFollowingPlan == true
                      ? widgetChild ?? Container()
                      : Text(
                          flexibleTitle2,
                          style: AppTypography.label16MD
                              .copyWith(color: AppColor.textInvertPrimaryColor),
                        ),
                ],
              ),
            ),
          ),
          background: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                child: cacheNetworkWidget(
                    imageUrl: backGroundImg, fit: BoxFit.cover),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ],
          )),
    );
  }
}

class DescriptionBoxWidget extends StatelessWidget {
  final String text;
  const DescriptionBoxWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
          child: Text(text,
              style: AppTypography.paragraph14MD
                  .copyWith(color: AppColor.textPrimaryColor))),
    );
  }
}
/// no data widget in video detail 
/*Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Error',
                            style: AppTypography.title18LG,
                          ),
                          5.height(),
                          Text(
                            "Something went wrong",
                            style: AppTypography.paragraph14MD
                                .copyWith(color: AppColor.textPrimaryColor),
                          )
                        ],
                      ),
                    ) */