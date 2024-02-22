import 'package:flutter/material.dart';
import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

class VideoDetailController {
  static Future<OnDemandModel?> getOnDemandData(context,
      {required String id}) async {
    try {
      final fetcheddata =
          await OnDemandRequest.onDemandById(id: id) as Map<String, dynamic>;
      OnDemandModel data = OnDemandModel.fromJson(fetcheddata);
      return data;
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    return null;
  }

  static String getOnDemandCategoryData(
    OnDemandModel data,
  ) {
    List<ContentProvidersCategoryOnDemandModel> onDemandCategoryData = [];
    for (var i = 0; i < data.categories!.length; i++) {
      for (var element in CommonController.onDemandCategoryData) {
        if (element.id.toString() == data.categories![i]) {
          onDemandCategoryData.add(element);
        }
      }
    }

    return onDemandCategoryData.map((e) => e.name).join(',');
  }

  static Future<InstructorModel?> getInstructor(context,
      {required String id}) async {
    try {
      final fetchData = await InstructorRequest.instructorsById(id: id)
          as Map<String, dynamic>;
      InstructorModel data = InstructorModel.fromJson(fetchData);
      return data;
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
    return null;
  }

  static Future<EquipmentModel?> getEquipment(context,
      {required String id}) async {
    try {
      final fetchData =
          await EquipmentRequest.equipmentById(id: id) as Map<String, dynamic>;
      EquipmentModel data = EquipmentModel.fromJson(fetchData);
      return data;
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
    return null;
  }

  static ValueNotifier<bool> showControls = ValueNotifier(false);

  static void onTap(videoPlayerController) {}

  static String getPosition(videoPlayerController) {
    final duration = Duration(
        milliseconds:
            videoPlayerController.value.position.inMilliseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((x) => x.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
    static String getDestinationPosition(double value) {
    final duration = Duration(
        milliseconds:
          value.toInt());

    return [duration.inMinutes, duration.inSeconds]
        .map((x) => x.remainder(60).toString().padLeft(2, '0'))
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
