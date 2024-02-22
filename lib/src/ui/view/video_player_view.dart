import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  final String videoURL, thumbNail, title;
  const VideoPlayerView({
    super.key,
    required this.videoURL,
    required this.thumbNail,
    required this.title,
  });

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView>
    with WidgetsBindingObserver {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoURL))
      ..initialize().then((_) {
        if (context.mounted) {
          _videoPlayerController.play();
          if (EveentTriggered.video_class_player_open != null) {
            EveentTriggered.video_class_player_open!(
                widget.title,
                widget.videoURL,
                VideoDetailController.getPosition(_videoPlayerController));
          }
          setState(() {});
        }
      })
      ..addListener(() {
        if (context.mounted) {
          if (!_videoPlayerController.value.isPlaying) {
            if (EveentTriggered.video_class_player_pause != null) {
              EveentTriggered.video_class_player_pause!(
                  widget.title,
                  widget.videoURL,
                  VideoDetailController.getPosition(_videoPlayerController));
            }
          }
          setState(() {});
        }
      });

    setLandScapeAutoRotation();
  }

  @override
  void dispose() {
    super.dispose();
    if (EveentTriggered.video_class_player_close != null) {
      EveentTriggered.video_class_player_close!(
        widget.title,
        widget.videoURL,
        VideoDetailController.getPosition(_videoPlayerController),
      );
    }
 
    _videoPlayerController.dispose();

    WidgetsBinding.instance.removeObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      VideoDetailController.showControls.value = false;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!_videoPlayerController.value.isPlaying && context.mounted) {
        _videoPlayerController.play();
      }
    } else if (state == AppLifecycleState.inactive && context.mounted) {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
        if (EveentTriggered.video_class_player_pause != null) {
          EveentTriggered.video_class_player_pause!(
              widget.title,
              widget.videoURL,
              VideoDetailController.getPosition(_videoPlayerController));
        }
      }
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
      onWillPop: () async {
        setPotrait();
        return Future.delayed(const Duration(seconds: 1), () => true);
      },
      child: _videoPlayerController.value.isInitialized
          ? VideoPlayerWidget(
              videoPlayerController: _videoPlayerController,
              title: widget.title,
              videoUrl: widget.videoURL,
            )
          : Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColor.surfaceBrandDarkColor,
                  image: DecorationImage(
                      image: cachedNetworkImageProvider(
                        imageUrl: widget.thumbNail,
                      ),
                      fit: BoxFit.contain)),
              child: BaseHelper.loadingWidget()),
    );
  }
}
