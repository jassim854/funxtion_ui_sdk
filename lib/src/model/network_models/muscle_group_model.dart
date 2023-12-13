class MuscleGroupsModel {
  int id;
  String name;
  dynamic slug;

  MuscleGroupsModel({
    required this.id,
    required this.name,
    this.slug,
  });

  factory MuscleGroupsModel.fromJson(Map<String, dynamic> json) =>
      MuscleGroupsModel(
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
