class ContentPackageItemsModel {
  int total;
  List<Datum> data;

  ContentPackageItemsModel({
    required this.total,
    required this.data,
  });

  factory ContentPackageItemsModel.fromJson(Map<String, dynamic> json) =>
      ContentPackageItemsModel(
        total: json["total"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  String type;
  String id;
  DateTime createdAt;
  Data data;

  Datum({
    required this.type,
    required this.id,
    required this.createdAt,
    required this.data,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: json["type"],
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  String id;
  String title;
  String? video;
  String image;
  String? instructorId;
  String type;
  String? duration;
  String level;
  List<int> goals;
  String? slug;
  String? gender;
  List<int>? types;
  List<int>? bodyParts;
  List<String>? locations;
  String? description;
  int? weeksTotal;
  int? daysTotal;
  int? maxDaysPerWeek;

  Data({
    required this.id,
    required this.title,
    this.video,
    required this.image,
    this.instructorId,
    required this.type,
    this.duration,
    required this.level,
    required this.goals,
    this.slug,
    this.gender,
    this.types,
    this.bodyParts,
    this.locations,
    this.description,
    this.weeksTotal,
    this.daysTotal,
    this.maxDaysPerWeek,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        video: json["video"],
        image: json["image"],
        instructorId: json["instructor_id"],
        type: json["type"],
        duration: json["duration"],
        level: json["level"],
        goals: List<int>.from(json["goals"].map((x) => x)),
        slug: json["slug"],
        gender: json["gender"],
        types: json["types"] == null
            ? []
            : List<int>.from(json["types"]!.map((x) => x)),
        bodyParts: json["body_parts"] == null
            ? []
            : List<int>.from(json["body_parts"]!.map((x) => x)),
        locations: json["locations"] == null
            ? []
            : List<String>.from(json["locations"]!.map((x) => x)),
        description: json["description"] == null
            ? null
            : json["description"]['en'],
        weeksTotal: json["weeks_total"],
        daysTotal: json["days_total"],
        maxDaysPerWeek: json["max_days_per_week"],
      );
}


