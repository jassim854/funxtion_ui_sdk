import 'package:ui_tool_kit/ui_tool_kit.dart';

class FiltersModel {
  String? key;
  String? type;
  String? label;
  bool? multi;
  List<ValueClass>? values;
  List<dynamic>? dynamicValues;
  List<dynamic>? operands;
  String? collectionName;

  FiltersModel({
    this.key,
    this.type,
    this.label,
    this.multi,
    this.values,
    this.dynamicValues,
    this.operands,
    this.collectionName,
  });

  factory FiltersModel.fromJson(Map<String, dynamic> json) =>
      FiltersModel(
        key: json["key"],
        type: json["type"],
        label: json["label"] == null ? null : json["label"]['en'].toString(),
        multi: json["multi"],
        values: json["values"] == null
            ? []
            : json["values"][0] is Map
                ? List<ValueClass>.from(
                    json["values"].map((x) => ValueClass.fromJson(x)))
                : null,
        dynamicValues: json["values"] == null
            ? []
            : json["values"][0] is Map
                ? null
                : List<dynamic>.from(json["values"]
                    .map((x) => (x).toString().capitalizeFirst())),
        operands: json["operands"] == null
            ? []
            : List<dynamic>.from(json["operands"]!.map((x) => x)),
        collectionName: json["collection_name"],
      );
}

// enum Operand { and, not, or }

// final operandValues =
//     EnumValues({"AND": Operand.and, "NOT": Operand.not, "OR": Operand.or});

class ValueClass {
  String? id;
  String? label;

  ValueClass({
    this.id,
    this.label,
  });

  factory ValueClass.fromJson(Map<String, dynamic> json) => ValueClass(
        id: json["id"].toString(),
        label: json["label"].toString().capitalizeFirst(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
      };
}

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }

