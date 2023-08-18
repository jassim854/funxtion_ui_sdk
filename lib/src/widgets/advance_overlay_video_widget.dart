
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';
import 'package:video_player/video_player.dart';

class AdvancedOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onClickedFullScreen;
  bool showControls;
  bool isPortrait;
  static const allSpeeds = <double>[0.25, 0.5, 1, 1.5, 2, 3, 5, 10];

  AdvancedOverlayWidget(
      {super.key,
      required this.isPortrait,
      required this.controller,
      required this.showControls,
      required this.onClickedFullScreen});

  String getPosition() {
    final duration = Duration(
        milliseconds: controller.value.position.inMilliseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  String getVideoDuration() {
    final duration = Duration(
        milliseconds: controller.value.duration.inMilliseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          buildPlay(),
          Positioned(
            left: 20,
            top: 15,
            child: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColor.blackLightColor,
                  borderRadius: BorderRadius.circular(8)),
              child: InkWell(
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 190),
                      () => Navigator.of(context).maybePop());
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 15,
            child: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColor.blackLightColor,
                  borderRadius: BorderRadius.circular(8)),
              child: InkWell(
                onTap: onClickedFullScreen,
                child: isPortrait
                    ? SvgPicture.asset(AppAssets.openFullScreenIcon)
                    : SvgPicture.asset(AppAssets.exitFullScreenIcon),
              ),
            ),
          ),
          Positioned(
            left: 8,
            bottom: 28,
            child: Text(
              "${getPosition()}/${getVideoDuration()}",
              style: AppTypography.label14SM
                  .copyWith(color: AppColor.scaffoldBackgroundColor),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  Expanded(child: buildIndicator()),
                  const SizedBox(width: 12),
                  buildSpeed(),
                  const SizedBox(width: 8),
                ],
              )),
        ],
      );

  Widget buildIndicator() => Container(
        margin: const EdgeInsets.all(8).copyWith(right: 0),
        height: 16,
        child: VideoProgressIndicator(
          controller,
          allowScrubbing: true,
        ),
      );

  Widget buildSpeed() => PopupMenuButton<double>(
        initialValue: controller.value.playbackSpeed,
        tooltip: 'Playback speed',
        onSelected: controller.setPlaybackSpeed,
        itemBuilder: (context) => allSpeeds
            .map<PopupMenuEntry<double>>((speed) => PopupMenuItem(
                  value: speed,
                  child: Text('${speed}x'),
                ))
            .toList(),
        child: Container(
          decoration: BoxDecoration(
              color: AppColor.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text('${controller.value.playbackSpeed}x'),
        ),
      );

  Widget buildPlay() => controller.value.isPlaying
      ? Center(
          child: !controller.value.isBuffering
              ? IconButton(
                  iconSize: 40,
                  onPressed: () {
                    showControls = true;
                    controller.pause();
                  },
                  icon: const Icon(
                    Icons.pause,
                    color: AppColor.whiteColor,
                  ))
              : const CircularProgressIndicator.adaptive())
      : Center(
          child: IconButton(
              iconSize: 40,
              onPressed: () {
                controller.play();
                Future.delayed(
                  const Duration(milliseconds: 250),
                  () {
                    showControls = false;
                  },
                );
              },
              icon: const Icon(
                Icons.play_arrow,
                color: AppColor.whiteColor,
              )),
        );
}
