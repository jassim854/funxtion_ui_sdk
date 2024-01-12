import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

CachedNetworkImage cacheNetworkWidget(BuildContext context,
    {required String imageUrl,
    BoxFit? fit,
    required int width,
    required int height}) {
  return CachedNetworkImage(
    // imageUrl:imageUrl,
    imageUrl: "$imageUrl/width/$width/height/$height/quality/${100}",

    fit: fit,

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
