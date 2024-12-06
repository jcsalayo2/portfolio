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
  int years;
  String name;
  String asset;
  int order;

  Skill({
    required this.years,
    required this.name,
    required this.asset,
    required this.order,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        years: json["years"],
        name: json["name"],
        asset: json["asset"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "years": years,
        "name": name,
        "asset": asset,
        "order": order,
      };
}
