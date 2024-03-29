import 'dart:developer';

import 'package:funxtion/funxtion_sdk.dart';
import 'package:ui_tool_kit/ui_tool_kit.dart';

class SearchContentController {
  static Future<SearchContentModel?> fetchData({
    required Map<String, dynamic> data,
    required SearchContentModel? searchContentData,
  }) async =>
      await SearchContentRequest.searchContent(data: data).then((value) {
        if (value != null) {
          SearchContentModel fetchData = SearchContentModel.fromJson(value);
          log(fetchData.toString());
          return fetchData;
        }
        return null;
      });
}
