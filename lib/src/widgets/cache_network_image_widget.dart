import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

CachedNetworkImage cacheNetworkWidget(BuildContext context,
    {required String imageUrl,
    // BoxFit? fit,
    required int width,
    required int height}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    // imageUrl:
    //     "$imageUrl/width/${width * 2.8}/height/${height * 2.8}/quality/1500",

    fit: BoxFit.fitHeight,

    useOldImageOnUrlChange: false,
    progressIndicatorBuilder: (context, url, progress) {
      return Center(
        child: BaseHelper.loadingWidget(value: progress.progress),
      );
    },
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}

ImageProvider<CachedNetworkImageProvider> cachedNetworkImageProvider({
  required String imageUrl,
}) {
  return CachedNetworkImageProvider(
    imageUrl,
  );
}
