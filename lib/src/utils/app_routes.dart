import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/src/ui/ui.dart';
import 'package:ui_tool_kit/src/utils/utils.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyHomePage.routeName:
        return MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        );
      case VideoCategoriesView.routeName:
        return MaterialPageRoute(
          builder: (context) => const VideoCategoriesView(),
        );
      case VideoDetailView.routeName:
        OnDemandModel data = settings.arguments as OnDemandModel;
        return MaterialPageRoute(
          builder: (context) => VideoDetailView(
            data: data,
          ),
        );
      case VideoViewPotrait.routeName:
        MapEntry data = settings.arguments as MapEntry;
        return MaterialPageRoute(
            builder: (context) =>
                VideoViewPotrait(videoUrl: data.key, thumbNail: data.value));
      default:
        {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
                body: Center(
              child: Text(
                'No route found',
                style: AppTypography.label18LG,
              ),
            )),
          );
        }
    }
  }
}
