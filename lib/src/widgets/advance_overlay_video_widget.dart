import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';
import 'package:video_player/video_player.dart';

class AdvancedOverlayWidget extends StatefulWidget {
  final VideoPlayerController controller;
  final VoidCallback onClickedFullScreen;

  final bool isPortrait;

  const AdvancedOverlayWidget({
    super.key,
    required this.controller,
    required this.onClickedFullScreen,
    required this.isPortrait,
  });

  @override
  State<AdvancedOverlayWidget> createState() => _AdvancedOverlayWidgetState();
}

class _AdvancedOverlayWidgetState extends State<AdvancedOverlayWidget> {
  static const allSpeeds = <double>[0.25, 0.5, 1, 1.5, 2.0];

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      fit: StackFit.expand,
      children: [
        widget.controller.value.isBuffering
            ? Center(child: BaseHelper.loadingWidget())
            : playButton(),
        Positioned(
          left: 16,
          top: widget.isPortrait == false ? 18 : 0,
          child: Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColor.surfaceBrandDarkColor,
                borderRadius: BorderRadius.circular(8)),
            child: InkWell(
              onTap: () {
                context.maybePopPage();
              },
              child: Icon(Icons.close, color: AppColor.textInvertEmphasis),
            ),
          ),
        ),
        Positioned(
          right: 16,
          top: widget.isPortrait == false ? 18 : 0,
          child: Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColor.surfaceBrandDarkColor,
                borderRadius: BorderRadius.circular(8)),
            child: InkWell(
              onTap: widget.onClickedFullScreen,
              child: widget.isPortrait
                  ? SvgPicture.asset(AppAssets.openFullScreenIcon)
                  : SvgPicture.asset(AppAssets.exitFullScreenIcon),
            ),
          ),
        ),
        Positioned(
          left: 12,
          bottom: 28,
          child: Text(
            "${VideoController.getPosition(widget.controller)}/${VideoController.getVideoDuration(widget.controller)}",
            style: AppTypography.label14SM
                .copyWith(color: AppColor.surfaceBackgroundBaseColor),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 12,
            child: Card(
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(child: buildIndicator()),
                  const SizedBox(width: 12),
                  buildSpeed(),
                  // const SizedBox(width: 8),
                ],
              ),
            )),
      ],
    );
  }

  Widget buildIndicator() => Container(
        margin: const EdgeInsets.all(8).copyWith(right: 0),
        height: 16,
        child: VideoProgressIndicator(
          widget.controller,
          allowScrubbing: true,
        ),
      );

  Widget buildSpeed() => PopupMenuButton<double>(
        initialValue: widget.controller.value.playbackSpeed,
        tooltip: 'Playback speed',
        onSelected: widget.controller.setPlaybackSpeed,
        itemBuilder: (context) => allSpeeds
            .map<PopupMenuEntry<double>>((speed) => PopupMenuItem(
                  value: speed,
                  child: Text('${speed}x'),
                ))
            .toList(),
        child: Container(
          decoration: BoxDecoration(
              color: AppColor.surfaceBackgroundBaseColor,
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text('${widget.controller.value.playbackSpeed}x'),
        ),
      );

  Widget playButton() {
    return widget.controller.value.isPlaying
        ? Center(
            child: IconButton(
                iconSize: 40,
                onPressed: () {
                  VideoController.showControls.value = true;

                  widget.controller.pause();
                },
                icon: Icon(
                  Icons.pause,
                  color: AppColor.textInvertEmphasis,
                )))
        : Center(
            child: IconButton(
                iconSize: 40,
                onPressed: () {
                  widget.controller.play();
                  Future.delayed(
                    const Duration(milliseconds: 250),
                    () {
                      VideoController.showControls.value = false;
                    },
                  );
                },
                icon: Icon(
                  Icons.play_arrow,
                  color: AppColor.textInvertEmphasis,
                )),
          );
  }
}
