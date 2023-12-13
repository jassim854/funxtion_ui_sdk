class BodyPartModel {
  int id;
  String name;
  dynamic slug;

  BodyPartModel({
    required this.id,
    required this.name,
    this.slug,
  });

  factory BodyPartModel.fromJson(Map<String, dynamic> json) => BodyPartModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };
}
