import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

CachedNetworkImage cacheNetworkWidget({required String imageUrl, BoxFit? fit}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: fit,
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        Transform.scale(
      scale: 0.6,
      child: Center(
          child: BaseHelper.loadingWidget(value: downloadProgress.progress)),
    ),
    useOldImageOnUrlChange: false,
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
