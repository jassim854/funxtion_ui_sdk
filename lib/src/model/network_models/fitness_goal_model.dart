class FitnessGoalModel {
  int id;
  String name;
  dynamic slug;

  FitnessGoalModel({
    required this.id,
    required this.name,
    this.slug,
  });

  factory FitnessGoalModel.fromJson(Map<String, dynamic> json) =>
      FitnessGoalModel(
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
