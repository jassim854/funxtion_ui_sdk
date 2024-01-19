import '../../../ui_tool_kit.dart';

class EquipmentModel {
  int id;
  String name;
  String slug;
  dynamic brandId;
  List<dynamic>? categories;
  dynamic description;
  dynamic image;

  EquipmentModel({
    required this.id,
    required this.name,
    required this.slug,
    this.brandId,
    required this.categories,
    this.description,
    this.image,
  });

  factory EquipmentModel.fromJson(Map<String, dynamic> json) => EquipmentModel(
        id: json["id"],
        description:
            json.containsKey("description") && json["description"] != null
                ? json["description"]['en']
                : null,
        name: json["name"],
        slug: json["slug"],
        brandId: json.containsKey("brand_id") ? json["brand_id"] : null,
        categories: json.containsKey("categories")
            ? List<int>.from(json["categories"].map((x) => x))
            : null,
        image:
            json["image"] is Map ? Img.fromJson(json["image"]) : json['image'],
      );
}
