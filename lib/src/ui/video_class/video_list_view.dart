import 'dart:async';


import 'package:flutter/material.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';


class VideoCategoriesView extends ConsumerStatefulWidget {
  static const routeName='/videoListView';
  const VideoCategoriesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoCategoriesViewState();
}

class _VideoCategoriesViewState extends ConsumerState<VideoCategoriesView> {
  late TextEditingController _searchController;
  late ScrollController _scrollController;

  StreamController<String> streamController = StreamController();
  @override
  void initState() {
    _searchController = TextEditingController();

    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (ref.read(videoProvider).isLoadMore == false &&
            ref.read(videoProvider).nextPage == true &&
            _scrollController.position.extentAfter < 300) {
          ref.read(videoProvider.notifier).isLoadMore = true;

          ref.read(videoProvider.notifier).pageNumber += 1;

          ref.read(videoProvider).getData(context);
        }
      },
    );
    ref.read(videoProvider).getData(context);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(140),
                child: AppBar(
                  title: const Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: Text("Video Classes"),
                  ),
                  centerTitle: true,
                  bottom: AppBar(
                    toolbarHeight: 90,
                    title: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xff34424B),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: CustomSearchTextFieldWidget(
                            ref: ref, searchController: _searchController),
                      ),
                    ),
                    actions: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            backgroundColor: AppColor.scaffoldBackgroundColor,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return const FilterSheetWidget();
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          child: SvgPicture.asset(AppAssets.iconFilter,
                              color: AppColor.whiteColor),
                        ),
                      )
                    ],
                  ),
                )),
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              FilterRowWidget(ref: ref),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.whiteColor,
                  ),
                  child: ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 20),
                      itemBuilder: (context, index) {
                        return CustomListtileWidget(
                          ref,
                          index,
                          routeName:VideoDetailView.routeName,
                          argument: ref.read(videoProvider).data[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return CustomDivider(
                          endIndent: context.dynamicWidth * 0.02,
                          indent: context.dynamicWidth * 0.22,
                        );
                      },
                      itemCount: ref.watch(videoProvider).data.length),
                ),
              )
            ])),
      ],
    ));
  }
}

class CustomSearchTextFieldWidget extends StatelessWidget {
  const CustomSearchTextFieldWidget({
    super.key,
    required this.ref,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final WidgetRef ref;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        ref.read(videoProvider).delayedFunction(context, value: value);
        // streamController.add(value);
      },
      controller: _searchController,
      style: AppTypography.paragraph14MD.copyWith(color: AppColor.whiteColor),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 40, top: 15),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: 'Yoga, HIIT, cardio',
        hintStyle: AppTypography.paragraph14MD
            .copyWith(color: AppColor.lightGreyTextFieldColor),
        prefixIcon:
            const Icon(Icons.search, color: AppColor.lightGreyTextFieldColor),
      ),
    );
  }
}
