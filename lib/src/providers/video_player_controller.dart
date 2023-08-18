
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

final videoPlayerProvider =
    ChangeNotifierProvider<VideoPlayerProviderNotifier>((ref) {
  return VideoPlayerProviderNotifier();
});

class VideoPlayerProviderNotifier extends ChangeNotifier {
  late VideoPlayerController videoPlayerController;
  void init() {
    notifyListeners();
    if (videoPlayerController.value.isBuffering) {
      showControls = videoPlayerController.value.isBuffering;
    } else if (videoPlayerController.value.isPlaying &&
        isTap == false &&
        showControls == true) {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          showControls = false;
        },
      );
    }
  }

  bool showControls = false;
  bool isTap = false;
}
