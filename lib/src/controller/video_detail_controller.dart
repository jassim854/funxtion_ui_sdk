import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

class CategoryDetailController {
  static Future<OnDemandModel?> getOnDemandData(context,
      {required String id}) async {
    try {
      OnDemandModel fetcheddata =
          await OnDemandRequest.onDemandById(id: id) as OnDemandModel;
      return fetcheddata;
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }

    return null;
  }

static Future<InstructorModel?> getInstructor(context, {required String id}) async {
    try {
      InstructorModel fetchData =
          await InstructorRequest.instructorsById(id: id) as InstructorModel;
      return fetchData;
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
    return null;
  }
  static Future<EquipmentModel?> getEquipment(context, {required String id}) async {
    try {
      EquipmentModel fetchData =
          await EquipmentRequest.equipmentById(id: id) as EquipmentModel;
      return fetchData;
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
    return null;
  }
}
