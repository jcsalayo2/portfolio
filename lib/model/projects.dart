// To parse this JSON data, do
//
//     final project = projectFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Project> projectFromJson(String str) => List<Project>.from(json.decode(str).map((x) => Project.fromJson(x)));

String projectToJson(List<Project> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Project {
    String name;
    String image;
    String description;
    String duration;
    List<String> technologies;
    int order;

    Project({
        required this.name,
        required this.image,
        required this.description,
        required this.duration,
        required this.technologies,
        required this.order,
    });

    factory Project.fromJson(Map<String, dynamic> json) => Project(
        name: json["name"],
        image: json["image"],
        description: json["description"],
        duration: json["duration"],
        technologies: List<String>.from(json["technologies"].map((x) => x)),
        order: json["order"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "description": description,
        "duration": duration,
        "technologies": List<dynamic>.from(technologies.map((x) => x)),
        "order": order,
    };
}
