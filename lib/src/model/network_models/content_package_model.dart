class ContentPackageModel {
  String id;
  String name;
  String? description;
  List<String> linkedSubscriptionTypes;
  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;

  ContentPackageModel({
    required this.id,
    required this.name,
    this.description,
    required this.linkedSubscriptionTypes,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContentPackageModel.fromJson(Map<String, dynamic> json) =>
      ContentPackageModel(
        id: json["id"],
        name: json["name"]['en'],
        description:
            json["description"] == null ? null : json['description']['en'],
        linkedSubscriptionTypes:
            List<String>.from(json["linked_subscription_types"].map((x) => x)),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
