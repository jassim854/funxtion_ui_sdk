import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class UiToolKitSDK extends StatelessWidget {
  const UiToolKitSDK({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: appThemes(),
          builder: EasyLoading.init(
            builder: (context, child) {
              EasyLoading.instance
                ..indicatorType = EasyLoadingIndicatorType.ring
                ..loadingStyle = EasyLoadingStyle.custom
                ..indicatorSize = 40
                ..radius = 10
                ..textColor = AppColor.appBarColor
                ..backgroundColor = AppColor.scaffoldBackgroundColor
                ..indicatorColor = AppColor.appBarColor
                ..maskColor = AppColor.blackLightColor
                ..userInteractions = false
                ..dismissOnTap = false;
              return Container(
                child: child,
              );
            },
          ),
          onGenerateRoute: AppRoutes.onGenerateRoute,
          initialRoute: MyHomePage.routeName),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  static const routeName = '/homeView';
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(appProvider).connectivity(
            _navigatorKey.currentContext,
          );
    });

    ref.read(authProvider).login(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Center(
        child: InkWell(
            onTap: () {
              ref.read(appProvider).connectivity(
                    _navigatorKey.currentContext,
                  );
              ref.read(authProvider).login(context);
            },
            child: Text(
              'Login',
              style: AppTypography.label18LG,
            )),
      ),
    );
  }
}
