// To parse this JSON data, do
//
//     final link = linkFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Link> linkFromJson(String str) =>
    List<Link>.from(json.decode(str).map((x) => Link.fromJson(x)));

String linkToJson(List<Link> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Link {
  String name;
  String link;

  Link({
    required this.name,
    required this.link,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        name: json["name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "link": link,
      };
}
