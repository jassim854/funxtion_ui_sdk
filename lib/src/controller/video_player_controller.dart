class VideoController {
  static bool showControls = false;
  static bool isTap = false;

  static void onTap(videoPlayerController) {
    print(showControls);
    print("object1");
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
