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
    return Scaffold(
        backgroundColor: AppColor.surfaceBrandDarkColor,
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              VideoController.showControls.value =
                  widget.videoPlayerController.value.isBuffering
                      ? true
                      : !VideoController.showControls.value;

              if (VideoController.showControls.value == true &&
                  context.mounted) {
                Timer(const Duration(seconds: 4), () {
                  if (widget.videoPlayerController.value.isPlaying &&
                      context.mounted) {
                    VideoController.showControls.value = false;
                  }
                });
              }
            },
            onDoubleTapDown: (details) {
              log('details  ${details.globalPosition.dx}');
              if (details.globalPosition.dx > 220) {
                widget.videoPlayerController.seekTo(Duration(
                    seconds:
                        widget.videoPlayerController.value.position.inSeconds +
                            10));
              } else if (details.globalPosition.dx < 220) {
                widget.videoPlayerController.seekTo(Duration(
                    seconds:
                        widget.videoPlayerController.value.position.inSeconds -
                            10));
              }
            },
            child: buildVideo()));
  }

  Widget buildVideo() {
    return ValueListenableBuilder<bool>(
        valueListenable: VideoController.showControls,
        builder: (context, value, child) {
          return Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              buildVideoPlayer(
                  MediaQuery.of(context).orientation == Orientation.portrait),
              if (value || widget.videoPlayerController.value.isBuffering)
                Positioned.fill(
                  child: SafeArea(
                    child: AdvancedOverlayWidget(
                      isPortrait: MediaQuery.of(context).orientation ==
                          Orientation.portrait,
                      controller: widget.videoPlayerController,
                      onClickedFullScreen: () async {
                        // log(VideoController.gyroscope.toString());
                        log(MediaQuery.of(context).orientation.toString());
                        if (MediaQuery.of(context).orientation ==
                            Orientation.portrait) {
                          await SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.immersiveSticky);
                          await SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeRight,
                            DeviceOrientation.landscapeLeft,
                          ]);
                        } else {
                          await SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.manual,
                              overlays: SystemUiOverlay.values);
                          await SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                          ]);
                        }
                      },
                    ),
                  ),
                ),
            ],
          );
        });
  }

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
