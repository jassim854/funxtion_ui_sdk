import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../ui_tool_kit.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  const VideoPlayerWidget({super.key, required this.videoPlayerController});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        return Future.delayed(
          const Duration(milliseconds: 200),
          () => true,
        );
      },
      child: Scaffold(
          backgroundColor: AppColor.surfaceBrandDarkColor,
          body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {});
                // setState(() {
                VideoController.isTap = !VideoController.isTap;
                VideoController.showControls =
                    widget.videoPlayerController.value.isBuffering
                        ? true
                        : !VideoController.showControls;

                if (VideoController.showControls == true && context.mounted) {
                  Future.delayed(
                    const Duration(seconds: 4),
                    () {
                      if (widget.videoPlayerController.value.isPlaying &&
                          context.mounted) {
                        setState(() {
                          VideoController.showControls = false;
                          VideoController.isTap = false;
                        });
                      }
                    },
                  );
                }

                // });
              },
              onDoubleTapDown: (details) {
                log('details  ${details.globalPosition.dx}');
                if (details.globalPosition.dx > 220) {
                  setState(() {
                    widget.videoPlayerController.seekTo(Duration(
                        seconds: widget.videoPlayerController.value.position
                                .inSeconds +
                            10));
                  });
                } else if (details.globalPosition.dx < 220) {
                  setState(() {
                    widget.videoPlayerController.seekTo(Duration(
                        seconds: widget.videoPlayerController.value.position
                                .inSeconds -
                            10));
                  });
                }
              },
              child: buildVideo())),
    );
  }

  Widget buildVideo() => OrientationBuilder(
        builder: (context, orientation) {
          bool isPortrait = orientation == Orientation.portrait;

          return Stack(
            fit: isPortrait ? StackFit.loose : StackFit.expand,
            alignment: Alignment.center,
            children: [
              buildVideoPlayer(isPortrait),
              if (VideoController.showControls ||
                  widget.videoPlayerController.value.isBuffering)
                Positioned.fill(
                  child: AdvancedOverlayWidget(
                    isPortrait: isPortrait,
                    controller: widget.videoPlayerController,
                    onClickedFullScreen: () {
                      isPortrait == true
                          ? SystemChrome.setPreferredOrientations([
                              DeviceOrientation.landscapeRight,
                              DeviceOrientation.landscapeLeft
                            ])
                          : SystemChrome.setPreferredOrientations([
                              DeviceOrientation.portraitDown,
                              DeviceOrientation.portraitUp,
                            ]);
                      isPortrait = false;
                    },
                  ),
                ),
            ],
          );
        },
      );

  Widget buildVideoPlayer(bool isPortrait) {
    return Container(
      alignment: Alignment.center,
      margin: isPortrait
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 60),
      child: AspectRatio(
        aspectRatio: widget.videoPlayerController.value.aspectRatio,
        child: VideoPlayer(widget.videoPlayerController),
      ),
    );
  }
}
