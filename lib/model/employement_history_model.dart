// To parse this JSON data, do
//
//     final employementHistory = employementHistoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<EmployementHistory> employementHistoryFromJson(String str) =>
    List<EmployementHistory>.from(
        json.decode(str).map((x) => EmployementHistory.fromJson(x)));

String employementHistoryToJson(List<EmployementHistory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployementHistory {
  String range;
  String title;
  List<String> description;
  int order;

  EmployementHistory({
    required this.range,
    required this.title,
    required this.description,
    required this.order,
  });

  factory EmployementHistory.fromJson(Map<String, dynamic> json) =>
      EmployementHistory(
        range: json["range"],
        title: json["title"],
        description: List<String>.from(json["description"].map((x) => x)),
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "range": range,
        "title": title,
        "description": List<dynamic>.from(description.map((x) => x)),
        "order": order,
      };
}
