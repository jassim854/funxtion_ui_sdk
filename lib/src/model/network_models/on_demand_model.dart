import 'package:ui_tool_kit/ui_tool_kit.dart';

import 'model_helper/model_helper.dart';

class OnDemandModel {
  String id;
  String title;
  String? description;
  String type;
  dynamic video;
  dynamic image;
  Img? mapImage;
  Img? mapVideo;
  String? language;
  String instructorId;
  String level;
  int? externalId;
  List<int>? equipment;
  List<int> goals;
  int? contentProvider;
  List<int>? contentTypes;
  List<String>? categories;
  String duration;
  List<String> contentPackages;

  OnDemandModel({
    required this.id,
    this.mapImage,
    this.mapVideo,
    required this.title,
    required this.description,
    required this.type,
    required this.video,
    required this.image,
    required this.language,
    required this.instructorId,
    required this.level,
    required this.externalId,
    required this.equipment,
    required this.goals,
    required this.contentProvider,
    required this.contentTypes,
    required this.categories,
    required this.duration,
    required this.contentPackages,
  });

  factory OnDemandModel.fromJson(Map<String, dynamic> json) => OnDemandModel(
        id: json["id"],
        title: json["title"] is Map ? json['title']['en'] : json['title'],
        description: json.containsKey('description')
            ? json['description']['en'].toString().capitalizeFirst()
            : null,
        type: json["type"],
        video: json['video'] is Map ? null : json['video'],
        image: json['image'] is Map ? null : json['image'],
        mapVideo: json['video'] is Map ? Img.fromJson(json["video"]) : null,
        mapImage: json['image'] is Map ? Img.fromJson(json["image"]) : null,
        language: json.containsKey('language') ? json["language"] : null,
        instructorId: json["instructor_id"],
        level: json["level"].toString().capitalizeFirst(),
        externalId:
            json.containsKey('external_id') ? json["external_id"] : null,
        equipment: json.containsKey('equipment')
            ? List<int>.from(json["equipment"].map((x) => x))
            : null,
        goals: List<int>.from(json["goals"].map((x) => x)),
        contentProvider: json["content_provider"],
        contentTypes: json.containsKey('content_types')
            ? List<int>.from(json["content_types"].map((x) => x))
            : null,
        categories: json.containsKey('categories')
            ? List<String>.from(json["categories"].map((x) => x))
            : null,
        duration: json["duration"],
        contentPackages:
            List<String>.from(json["content_packages"].map((x) => x)),
      );
}
