

import 'package:ui_tool_kit/ui_tool_kit.dart';

class SearchContentModel {
  List<Result>? results;
  List<dynamic>? suggestions;
  List<Cursor>? cursors;

  SearchContentModel({
    this.results,
    this.suggestions,
    this.cursors,
  });

  factory SearchContentModel.fromJson(Map<String, dynamic> json) =>
      SearchContentModel(
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        suggestions: json["suggestions"] == null
            ? []
            : List<dynamic>.from(json["suggestions"]!.map((x) => x)),
        cursors: json["cursors"] == null
            ? []
            : List<Cursor>.from(
                json["cursors"]!.map((x) => Cursor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "suggestions": suggestions == null
            ? []
            : List<dynamic>.from(suggestions!.map((x) => x)),
        "cursors": cursors == null
            ? []
            : List<dynamic>.from(cursors!.map((x) => x.toJson())),
      };
}

class Cursor {
  CategoryName? collection;
  int? offset;
  int? limit;
  int? total;

  Cursor({
    this.collection,
    this.offset,
    this.limit,
    this.total,
  });

  factory Cursor.fromJson(Map<String, dynamic> json) => Cursor(
        collection: collectionValues.map[json["collection"]]!,
        offset: json["offset"],
        limit: json["limit"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "collection": collectionValues.reverse[collection],
        "offset": offset,
        "limit": limit,
        "total": total,
      };
}

final collectionValues = EnumValue({
  "audio": CategoryName.audioClasses,
  "training-plans": CategoryName.trainingPlans,
  "video": CategoryName.videoClasses,
  "workouts": CategoryName.workouts
});

class Result {
  CategoryName? collection;
  double? matchScore;
  String? entityId;
  String? title;
  int? duration;
  List<Category>? categories;
  List<Category>? goals;
  String? level;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Result({
    this.collection,
    this.matchScore,
    this.entityId,
    this.title,
    this.duration,
    this.categories,
    this.goals,
    this.level,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        collection: collectionValues.map[json["collection"]]!,
        matchScore: json["match_score"]?.toDouble(),
        entityId: json["entity_id"],
        title: json["title"],
        duration: json["duration"].toInt(),
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
        goals: json["goals"] == null
            ? []
            : List<Category>.from(
                json["goals"]!.map((x) => Category.fromJson(x))),
        level: json["level"].toString().capitalizeFirst(),
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "collection": collectionValues.reverse[collection],
        "match_score": matchScore,
        "entity_id": entityId,
        "title": title,
        "duration": duration,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "goals": goals == null
            ? []
            : List<dynamic>.from(goals!.map((x) => x.toJson())),
        "level": level,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Category {
  String? id;
  String? label;

  Category({
    this.id,
    this.label,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
      };
}

class EnumValue<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValue(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
