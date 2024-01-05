import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';

import 'package:video_player/video_player.dart';
// import 'package:sensors_plus/sensors_plus.dart';

class CategoryPlayerView extends StatefulWidget {
  final String videoURL, thumbNail;
  const CategoryPlayerView({
    super.key,
    required this.videoURL,
    required this.thumbNail,
  });

  @override
  State<CategoryPlayerView> createState() => _CategoryPlayerViewState();
}

class _CategoryPlayerViewState extends State<CategoryPlayerView>
    with WidgetsBindingObserver {
  late VideoPlayerController _videoPlayerController;
  // StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

// Don't forget to cancel subscription after use

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoURL))
          ..initialize().then((_) {
            _videoPlayerController.play();

            setState(() {});
          })
          ..addListener(() {
            setState(() {});
          });

    setLandScapeAutoRotation();
    // _gyroscopeSubscription = gyroscopeEvents.listen((event) {
    //   // VideoController.gyroscope = event;
    // });
  }

  @override
  void dispose() {
    super.dispose();

    log('message page dispose call');
    // _gyroscopeSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      VideoController.showControls.value = false;
      _videoPlayerController.dispose();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!_videoPlayerController.value.isPlaying) {
        _videoPlayerController.play();
      }
    } else if (state == AppLifecycleState.inactive) {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
      }
    } else {
      _videoPlayerController.play();
    }
  }

  Future setLandScapeAutoRotation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp
    ]);
  }

  Future setPotrait() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setPotrait();
        return Future.delayed(const Duration(milliseconds: 350), () => true);
      },
      child: _videoPlayerController.value.isInitialized
          ? VideoPlayerWidget(videoPlayerController: _videoPlayerController)
          : Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColor.surfaceBrandDarkColor,
                  image: DecorationImage(
                      image: cachedNetworkImageProvider(
                          imageUrl: widget.thumbNail))),
              child: BaseHelper.loadingWidget()),
    );
  }
}
