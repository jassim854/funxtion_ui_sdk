import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';

class VideoController {
  static ValueNotifier<bool> showControls = ValueNotifier(false);

  static void onTap(videoPlayerController) {

    
  }

  static String getPosition(videoPlayerController) {
    final duration = Duration(
        milliseconds:
            videoPlayerController.value.position.inMilliseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  static String getVideoDuration(videoPlayerController) {
    final duration = Duration(
        milliseconds:
            videoPlayerController.value.duration.inMilliseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
}
