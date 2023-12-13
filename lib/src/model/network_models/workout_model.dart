import '../../../ui_tool_kit.dart';

class WorkoutModel {
  String? id;
  String? title;
  String? slug;
  String? gender;
  String? level;
  List<int>? types;
  List<int>? goals;
  List<int>? bodyParts;
  List<String>? locations;
  String? duration;
  List<dynamic>? contentPackages;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? description;
  String? image;
  Img? mapImage;
  List<Phase>? phases;

  WorkoutModel(
      {this.id,
      this.title,
      this.slug,
      this.gender,
      this.level,
      this.types,
      this.goals,
      this.bodyParts,
      this.locations,
      this.duration,
      this.contentPackages,
      this.createdAt,
      this.updatedAt,
      this.description,
      this.image,
      this.phases,
      this.mapImage});

  factory WorkoutModel.fromJson(Map<String, dynamic> json) => WorkoutModel(
        id: json["id"],
        title: json["title"] is Map ? json['title']['en'] : json['title'],
        slug: json["slug"],
        gender: json["gender"],
        level: json["level"],
        types: json["types"] == null
            ? []
            : List<int>.from(json["types"]!.map((x) => x)),
        goals: json["goals"] == null
            ? []
            : List<int>.from(json["goals"]!.map((x) => x)),
        bodyParts: json["body_parts"] == null
            ? []
            : List<int>.from(json["body_parts"]!.map((x) => x)),
        locations: json["locations"] == null
            ? []
            : List<String>.from(json["locations"]!.map((x) => x)),
        duration: json["duration"],
        contentPackages: json["content_packages"] == null
            ? []
            : List<dynamic>.from(json["content_packages"]!.map((x) => x)),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        description:
            json["description"] == null ? null : json["description"]['en'],
        image: json['image'] is Map ? null : json['image'],
        mapImage: json['image'] is Map ? Img.fromJson(json['image']) : null,
        phases: json["phases"] == null
            ? []
            : List<Phase>.from(json["phases"]!.map((x) => Phase.fromJson(x))),
      );
}

class Phase {
  String? title;
  int? time;
  List<Item>? items;

  Phase({
    this.title,
    this.time,
    this.items,
  });

  factory Phase.fromJson(Map<String, dynamic> json) => Phase(
        title: json["title"] == null ? null : json["title"]['en'],
        time: json["time"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //     "title": title?.toJson(),
  //     "time": time,
  //     "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  // };
}

class Item {
  ItemType? type;
  String? notes;
  List<SeExercise>? seExercises;
  List<CtRound>? ctRounds;
  List<CtRound>? crRounds;
  int? ssRest;
  int? ssSets;
  int? rftRounds;
  List<ExerciseObj>? ssExercises;
  List<ExerciseObj>? rftExercises;
  int? amrapDuration;
  List<ExerciseObj>? amrapExercises;
  int? emomRest;
  List<ExerciseObj>? emomMinutes;
  Item(
      {this.type,
      this.notes,
      this.seExercises,
      this.ctRounds,
      this.ssRest,
      this.ssSets,
      this.ssExercises,
      this.rftExercises,
      this.rftRounds,
      this.amrapDuration,
      this.amrapExercises,
      this.crRounds,
      this.emomMinutes,
      this.emomRest});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        type: itemTypeValues.map[json['type']],
        notes: json["notes"] == null ? null : json["notes"]['en'],
        seExercises: json["se_exercises"] == null
            ? []
            : List<SeExercise>.from(
                json["se_exercises"]!.map((x) => SeExercise.fromJson(x))),
        ctRounds: json["ct_rounds"] == null
            ? []
            : List<CtRound>.from(
                json["ct_rounds"]!.map((x) => CtRound.fromJson(x))),
        crRounds: json["cr_rounds"] == null
            ? []
            : List<CtRound>.from(
                json["cr_rounds"]!.map((x) => CtRound.fromJson(x))),
        ssRest: json["ss_rest"],
        ssSets: json["ss_sets"],
        ssExercises: json["ss_exercises"] == null
            ? []
            : List<ExerciseObj>.from(
                json["ss_exercises"]!.map((x) => ExerciseObj.fromJson(x))),
        rftExercises: json["rft_exercises"] == null
            ? []
            : List<ExerciseObj>.from(
                json["rft_exercises"]!.map((x) => ExerciseObj.fromJson(x))),
        rftRounds: json["rft_rounds"],
        amrapExercises: json["amrap_exercises"] == null
            ? []
            : List<ExerciseObj>.from(
                json["amrap_exercises"]!.map((x) => ExerciseObj.fromJson(x))),
        emomRest: json["emom_rest"],
        emomMinutes: json["emom_minutes"] == null
            ? []
            : List<ExerciseObj>.from(
                json["emom_minutes"]!.map((x) => ExerciseObj.fromJson(x))),
      );
}

class ExerciseObj {
  String? notes;
  int? rest;
  String? exerciseId;
  List<SetGoalTargetAndResistentTarget>? goalTargets;
  List<SetGoalTargetAndResistentTarget>? resistanceTargets;

  ExerciseObj({
    this.notes,
    this.rest,
    this.exerciseId,
    this.goalTargets,
    this.resistanceTargets,
  });

  factory ExerciseObj.fromJson(Map<String, dynamic> json) => ExerciseObj(
        notes: json["notes"] == null ? null : json["notes"]['en'],
        rest: json["rest"],
        exerciseId: json["exercise_id"],
        goalTargets: json["goal_targets"] == null
            ? []
            : List<SetGoalTargetAndResistentTarget>.from(json["goal_targets"]!
                .map((x) => SetGoalTargetAndResistentTarget.fromJson(x))),
        resistanceTargets: json["resistance_targets"] == null
            ? []
            : List<SetGoalTargetAndResistentTarget>.from(
                json["resistance_targets"]!
                    .map((x) => SetGoalTargetAndResistentTarget.fromJson(x))),
      );
}

class CtRound {
  int? restRound;
  int? work;
  int? rest;
  List<ExerciseObj>? exercises;

  CtRound({
    this.restRound,
    this.work,
    this.rest,
    this.exercises,
  });

  factory CtRound.fromJson(Map<String, dynamic> json) => CtRound(
        restRound: json["rest_round"],
        work: json["work"],
        rest: json["rest"],
        exercises: json["exercises"] == null
            ? []
            : List<ExerciseObj>.from(
                json["exercises"]!.map((x) => ExerciseObj.fromJson(x))),
      );
}

enum Metric {
  duration,
  repetitions,
  weight,
  watt,
  angle,
  irm,
  distance,
  height,
  level
}

final metricValues = EnumValues({
  "duration": Metric.duration,
  "repetitions": Metric.repetitions,
  "weight": Metric.weight,
  "watt": Metric.watt,
  "angle": Metric.angle,
  "1rm": Metric.irm,
  "distance": Metric.distance,
  "height": Metric.height,
  "level": Metric.level
});

enum GoalTargetType { range, value }

final goalTargetTypeValues =
    EnumValues({"RANGE": GoalTargetType.range, "VALUE": GoalTargetType.value});

class SeExercise {
  String? exerciseId;
  String? notes;
  List<ExerciseObj>? sets;

  SeExercise({
    this.exerciseId,
    this.notes,
    this.sets,
  });

  factory SeExercise.fromJson(Map<String, dynamic> json) => SeExercise(
        exerciseId: json["exercise_id"],
        notes: json["notes"] == null ? null : json["notes"]['en'],
        sets: json["sets"] == null
            ? []
            : List<ExerciseObj>.from(
                json["sets"]!.map((x) => ExerciseObj.fromJson(x))),
      );
}

class SetGoalTargetAndResistentTarget {
  GoalTargetType? type;
  Metric? metric;
  double? min;
  double? max;
  double? value;

  SetGoalTargetAndResistentTarget({
    this.type,
    this.metric,
    this.min,
    this.max,
    this.value,
  });

  factory SetGoalTargetAndResistentTarget.fromJson(Map<String, dynamic> json) =>
      SetGoalTargetAndResistentTarget(
        type: goalTargetTypeValues.map[json["type"]]!,
        metric: metricValues.map[json["metric"]]!,
        min: json["min"],
        max: json["max"],
        value: json["value"],
      );

  @override
  String toString() {
    return "Type : $type , Metric :$metric , Min : $max , Max : $max , Value : $value ";
  }
}

enum ItemType {
  circuitTime,
  singleExercise,
  superSet,
  rft,
  circuitRep,
  amrap,
  enom
}

final itemTypeValues = EnumValues({
  "CIRCUIT-TIME": ItemType.circuitTime,
  "SINGLE-EXERCISES": ItemType.singleExercise,
  "SUPERSET": ItemType.superSet,
  "RFT": ItemType.rft,
  "CIRCUIT-REPETITIONS": ItemType.circuitRep,
  "AMRAP": ItemType.amrap,
  "EMOM": ItemType.enom
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
