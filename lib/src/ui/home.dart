import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_tool_kit/src/ui/view/dashboard_view.dart';

import '../../ui_tool_kit.dart';

class UiToolKitSDK extends StatefulWidget {
  const UiToolKitSDK({
    super.key,
  });

  @override
  State<UiToolKitSDK> createState() => _UiToolKitSDKState();
}

class _UiToolKitSDKState extends State<UiToolKitSDK> {
  @override
  void initState() {
    // if (widget.categoryName == CategoryName.trainingPLans) {
    getPath();
    // }
    // AuthController.login(context);
    // TODO: implement initState
    super.initState();
  }

  getPath() async {
    await PkgAppController.getPath();
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp]).then((value) {
              return context.navigatepushReplacement(const DashBoardView());
            });
          });
        }
        return Center(
          child: BaseHelper.loadingWidget(),
        );
      },
    ));
  }
}
