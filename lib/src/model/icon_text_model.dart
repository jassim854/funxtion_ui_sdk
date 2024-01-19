class IconTextModel {
  final String text;
  final String? imageName;
  final String? id;

  IconTextModel({this.id, required this.text, this.imageName});

  @override
  String toString() {
    return "id is $id , text is  $text, image Name is $imageName";
  }
}
