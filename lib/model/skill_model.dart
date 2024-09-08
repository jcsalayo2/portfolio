// To parse this JSON data, do
//
//     final skill = skillFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Skill> skillFromJson(String str) =>
    List<Skill>.from(json.decode(str).map((x) => Skill.fromJson(x)));

String skillToJson(List<Skill> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Skill {
  int year;
  String name;
  String asset;

  Skill({
    required this.year,
    required this.name,
    required this.asset,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        year: json["year"],
        name: json["name"],
        asset: json["asset"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "name": name,
        "asset": asset,
      };
}
