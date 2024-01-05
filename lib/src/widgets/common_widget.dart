import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

class NoResultFOundWIdget extends StatelessWidget {
  const NoResultFOundWIdget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No Results',
            style: AppTypography.title18LG,
          ),
          5.height(),
          Text(
            "We couldn’t find anything",
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
  final Widget? bottomWidget;
  final String appBarTitle, flexibleTitle, backGroundImg;
  final Widget flexibleSubtitleWidget;
  SliverAppBarWidget(
      {super.key,
      required this.value,
      required this.appBarTitle,
      required this.flexibleTitle,
      required this.flexibleSubtitleWidget,
      required this.backGroundImg,
      this.isFollowingPlan = false,
      this.bottomWidget});

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
      // leadingWidth: 50,
      leading: InkWell(
        onTap: () {
          context.maybePopPage();
        },
        child: Container(
            margin: const EdgeInsets.only(
              left: 19,
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: AppColor.surfaceBrandDarkColor, shape: BoxShape.circle),
            child: Transform.scale(
              scale: 1.05,
              child: SvgPicture.asset(
                AppAssets.backArrowIcon,
                color: AppColor.textInvertEmphasis,
              ),
            )),
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
                      ? bottomWidget ?? Container()
                      : flexibleSubtitleWidget
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
              style: AppTypography.paragraph16LG
                  .copyWith(color: AppColor.textPrimaryColor))),
    );
  }
}

class HeaderTitleWIdget extends StatelessWidget {
  final CategoryName categoryName;
  const HeaderTitleWIdget({
    super.key,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      categoryName == CategoryName.videoClasses
          ? "Video Classes"
          : categoryName == CategoryName.workouts
              ? "Workouts"
              :categoryName == CategoryName.audioClasses
                      ? "Audio Classes"
                      : '',
      style:
          AppTypography.label18LG.copyWith(color: AppColor.textEmphasisColor),
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