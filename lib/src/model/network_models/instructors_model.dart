import 'model_helper/model_helper.dart';

class InstructorModel {
  String? id;
  String? userId;
  String name;
  String gender;
  Img? photo;

  InstructorModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.gender,
    required this.photo,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) =>
      InstructorModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        gender: json["gender"],
        photo: json["photo"] == null ? null : Img.fromJson(json["photo"]),
      );
}
