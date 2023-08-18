import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:ui_tool_kit/ui_tool_kit.dart';



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoViewPotrait extends ConsumerStatefulWidget {
  static const routeName = '/videoPlayerView';
  final String videoUrl, thumbNail;
  const VideoViewPotrait(
      {required this.videoUrl, required this.thumbNail, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoViewPotrait();
}

class _VideoViewPotrait extends ConsumerState<VideoViewPotrait> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((_) {
            _videoPlayerController.play();
          })
          ..setLooping(true)
          ..addListener(() {
            ref.read(videoPlayerProvider).videoPlayerController =
                _videoPlayerController;
            ref.watch(videoPlayerProvider).init();
          });

    super.initState();
  }

  @override
  void dispose() {
    log('message page dispose call');

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _videoPlayerController.dispose();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayerController.value.isInitialized
        ? VideoPlayerBothWidget(_videoPlayerController)
        : SafeArea(
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColor.blackColor,
                    image: DecorationImage(
                        image: cachedNetworkImageProvider(
                            imageUrl: widget.thumbNail))),
                child: const CircularProgressIndicator.adaptive()),
          );
  }
}
