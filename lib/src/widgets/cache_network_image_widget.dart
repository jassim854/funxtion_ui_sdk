import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

CachedNetworkImage cacheNetworkWidget(BuildContext context,
    {required String imageUrl, required int width, required int height}) {
  return CachedNetworkImage(
    // imageUrl: imageUrl,

    imageUrl: !imageUrl.contains("vixyvideo")
        ? imageUrl
        : "$imageUrl/width/${width * 2.5}/height/${height * 2.5}/quality/1500",

    fit: BoxFit.fitHeight,
    errorListener: (value) {
      log(value.toString());
    },
    useOldImageOnUrlChange: false,
    progressIndicatorBuilder: (context, url, progress) {
      return Center(
        child: BaseHelper.loadingWidget(value: progress.progress),
      );
    },
    errorWidget: (context, url, error) {
      if (error is SocketException) {
        // Handle SocketException here
        return const Text(
            'Error: Failed to load image. Check your internet connection.');
      } else {
        return const Icon(Icons.error);
      }
    },
  );
}

ImageProvider<CachedNetworkImageProvider> cachedNetworkImageProvider({
  required String imageUrl,
}) {
  return CachedNetworkImageProvider(
    imageUrl,
  );
}
