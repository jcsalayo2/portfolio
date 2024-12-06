// To parse this JSON data, do
//
//     final projects = projectsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Project> projectsFromJson(String str) =>
    List<Project>.from(json.decode(str).map((x) => Project.fromJson(x)));

String projectsToJson(List<Project> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Project {
  String name;
  String image;
  String description;
  String duration;

  Project({
    required this.name,
    required this.image,
    required this.description,
    required this.duration,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        name: json["name"],
        image: json["image"],
        description: json["description"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "description": description,
        "duration": duration,
      };
}
