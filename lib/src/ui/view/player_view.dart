import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';

import 'package:video_player/video_player.dart';

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

class _CategoryPlayerViewState extends State<CategoryPlayerView> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoURL))
      ..initialize().then((_) {
        _videoPlayerController.play();

        setState(() {});
      })
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true);
    // _videoPlayerController = CachedVideoPlayerController.network(
    //     "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    //     videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
    //   ..initialize().then((_) {
    //     _videoPlayerController.play();

    //     setState(() {});
    //   })
    //   ..addListener(() {
    //     setState(() {});
    //   })
    //   ..setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    log('message page dispose call');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      VideoController.showControls = false;
      _videoPlayerController.dispose();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayerController.value.isInitialized
   
        ? VideoPlayerWidget(videoPlayerController: _videoPlayerController)
        : SafeArea(
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColor.surfaceBrandDarkColor,
                    image: DecorationImage(
                        image: cachedNetworkImageProvider(
                            imageUrl: widget.thumbNail))),
                child: const CircularProgressIndicator.adaptive()),
          );
  }
}
