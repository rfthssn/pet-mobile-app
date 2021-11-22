import 'dart:convert';

List<Weight> weightFromJson(String str) =>
    List<Weight>.from(json.decode(str).map((x) => Weight.fromJson(x)));

String weightToJson(List<Weight> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Weight {
  Weight({
    this.id,
    this.user,
    required this.weightInKg,
    required this.date,
    this.v,
  });

  String? id;
  String? user;
  int weightInKg;
  String date;
  int? v;

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
        id: json["_id"],
        user: json["user"],
        weightInKg: json["weight_in_kg"],
        date: json["date"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "weight_in_kg": weightInKg,
        "date": date,
        "__v": v,
      };
}
