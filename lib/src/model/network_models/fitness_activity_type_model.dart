

import '../../../ui_tool_kit.dart';

class FitnessActivityTypeModel {
  int id;
  String name;
  String slug;
  List<Field>? fields;

  FitnessActivityTypeModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.fields,
  });

  factory FitnessActivityTypeModel.fromJson(Map<String, dynamic> json) =>
      FitnessActivityTypeModel(
          id: json["id"],
          name: json['name'] is Map ? json["name"]['en'] : json['name'],
          slug: json["slug"],
          fields: json.containsKey('fields')
              ? List<Field>.from(json["fields"].map((x) => Field.fromJson(x)))
              : null);
}
