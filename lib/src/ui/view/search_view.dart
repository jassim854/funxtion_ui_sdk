import 'package:flutter/material.dart';

import '../../../ui_tool_kit.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController _searchController;
  late FocusNode focusNode;
  @override
  void initState() {
    _searchController = TextEditingController();
    focusNode = FocusNode();
    focusNode.requestFocus();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.textInvertPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.surfaceBackgroundColor,
        // toolbarHeight: 80,
        leadingWidth: 0,
        titleSpacing: 0,
        leading: const SizedBox.shrink(),
        title: CustomSearchTextFieldWidget(
          onIconTap: () {
            _searchController.clear();
          },
          showCloseIcon: true,
          focusNode: focusNode,
          searchController: _searchController,
          hintText: 'Workouts, trainers, exercises',
        ),
        actions: [
          GestureDetector(
            onTap: () {
              context.hideKeypad();
              _searchController.clear();
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 20),
              child: Text('Cancel',
                  style: AppTypography.label14SM.copyWith(
                    color: AppColor.textEmphasisColor,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
