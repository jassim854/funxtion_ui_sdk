import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../ui_tool_kit.dart';

class VideoPlayerBothWidget extends ConsumerWidget {
  final VideoPlayerController videoPlayerController;
  const VideoPlayerBothWidget(this.videoPlayerController, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        return Future.delayed(
          const Duration(milliseconds: 200),
          () => true,
        );
      },
      child: Scaffold(
          backgroundColor: AppColor.blackColor,
          body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: videoPlayerController.value.isBuffering == false
                  ? () {
                      ref.read(videoPlayerProvider).isTap = true;
                      ref.read(videoPlayerProvider).showControls =
                          !ref.read(videoPlayerProvider).showControls;
                      if (ref.read(videoPlayerProvider).showControls == true) {
                        Future.delayed(
                          const Duration(seconds: 6),
                          () {
                            if (videoPlayerController.value.isPlaying) {
                              ref.read(videoPlayerProvider).showControls =
                                  false;
                              ref.read(videoPlayerProvider).isTap = false;
                            }
                          },
                        );
                      }
                      print("object1");
                    }
                  : null,
              onDoubleTapDown: (details) {
                log('details  ${details.globalPosition.dx}');
                if (details.globalPosition.dx > 220) {
                  videoPlayerController.seekTo(Duration(
                      seconds:
                          videoPlayerController.value.position.inSeconds + 10));
                } else if (details.globalPosition.dx < 220) {
                  videoPlayerController.seekTo(Duration(
                      seconds:
                          videoPlayerController.value.position.inSeconds - 10));
                }
              },
              child: buildVideo(ref))),
    ));
  }

  Widget buildVideo(WidgetRef ref) => OrientationBuilder(
        builder: (context, orientation) {
          bool isPortrait = orientation == Orientation.portrait;

          return Stack(
            fit: isPortrait ? StackFit.loose : StackFit.expand,
            alignment: Alignment.center,
            children: [
              buildVideoPlayer(ref, isPortrait),
              if (ref.watch(videoPlayerProvider).showControls == true)
                Positioned.fill(
                  child: AdvancedOverlayWidget(
                    showControls: ref.watch(videoPlayerProvider).showControls,
                    isPortrait: isPortrait,
                    controller: videoPlayerController,
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

  Widget buildVideoPlayer(WidgetRef ref, bool isPortrait) {
    return Container(
      alignment: Alignment.center,
      margin: isPortrait
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 60),
      child: AspectRatio(
        aspectRatio: videoPlayerController.value.aspectRatio,
        child: VideoPlayer(videoPlayerController),
      ),
    );
  }
}
