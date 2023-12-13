import '../../../ui_tool_kit.dart';

class ExerciseModel {
  String id;
  String name;
  String slug;
  String level;
  String instructorGender;
  dynamic orientation;
  List<int> muscleGroups;
  List<int> equipment;
  List<int> types;
  String? video;
  Img? mapVideo;
  String? gif;
  Img? mapGif;
  String? image;
  Img? mapImage;
  List? steps;
  ExerciseModel(
      {required this.id,
      required this.name,
      required this.slug,
      required this.level,
      required this.instructorGender,
      this.orientation,
      required this.muscleGroups,
      required this.equipment,
      required this.types,
      this.video,
      this.mapVideo,
      required this.gif,
      required this.mapGif,
      this.image,
      this.mapImage,
      this.steps});

  factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
        id: json.containsKey('id') ? json['id'] : '',
        name:
            json['name'] is Map ? json["name"]['en'].toString() : json['name'],
        slug: json["slug"],
        level: json["level"],
        instructorGender: json["gender"],
        orientation: json["orientation"],
        muscleGroups: List<int>.from(json["muscle_groups"].map((x) => x)),
        equipment: List<int>.from(json["equipment"].map((x) => x)),
        types: List<int>.from(json["types"].map((x) => x)),
        video: json["video"] is Map ? null : json['video'],
        mapVideo: json["video"] is Map ? Img.fromJson(json['video']) : null,
        gif: json["gif"] is Map ? null : json['gif'],
        mapGif: json['gif'] is Map ? Img.fromJson(json['gif']) : null,
        image: json["image"] is Map ? null : json['image'],
        mapImage: json["image"] is Map ? Img.fromJson(json['image']) : null,
        steps: json.containsKey('steps')
            ? List.from(json["steps"].map((e) => e['en']))
            : null,
      );

  @override
  String toString() =>
      "{id :$id, name :$name, slug :$slug, level : $level, instructorGender : $instructorGender , orientation : $orientation , muscleGroups : $muscleGroups , equipment :$equipment , types:$types, video:$video, mapVideo:$mapVideo, gif:$gif, mapGif:$mapGif, image:$image, mapImage:$mapImage , steps:$steps }";
}
