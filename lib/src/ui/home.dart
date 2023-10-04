import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_tool_kit/src/utils/enums.dart';

import '../../ui_tool_kit.dart';

class UiToolKitSDK extends StatefulWidget {
  final CategoryName categoryName;
  const UiToolKitSDK({
    super.key,
    required this.categoryName,
  });

  @override
  State<UiToolKitSDK> createState() => _UiToolKitSDKState();
}

class _UiToolKitSDKState extends State<UiToolKitSDK> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    AuthController.login(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: AuthController.login(context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: BaseHelper.loadingWidget(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        if (snapshot.hasData == false) {
          return Center(
            child: InkWell(
                onTap: () {
                  // AuthController.login(context);
                  AuthController.login(context);
                },
                child: Text(
                  'Login',
                  style: AppTypography.label18LG,
                )),
          );
        }
        if (snapshot.hasData == true &&
            snapshot.connectionState == ConnectionState.done) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            return context.navigatepushReplacement(CategoryListView(
              categoryName: widget.categoryName,
            ));
          });
        }
        return Center(
          child: BaseHelper.loadingWidget(),
        );
      },
    ));
  }
}
