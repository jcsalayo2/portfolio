import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/model/skill_model.dart';

TextStyle textHeader = const TextStyle(
  color: Colors.amber,
  fontFamily: 'PlayFair',
  fontSize: 24,
  fontVariations: [FontVariation('wght', 500)],
);

const String aboutMe =
    "Experienced IT professional and software developer with over 4 years of industry experience. Skilled in designing and implementing innovative software solutions, optimizing system performance, and delivering high-quality products. Strong problem-solving and communication abilities, committed to staying updated with industry trends.";

// Links
const linkedinPNG = "icons/linkedin.png";
const githubPNG = "icons/github.png";
const fbPNG = "icons/fb.png";

// Portraits
const portraitPNG = "portraits/me.png";

// Skill Icons
const cSharpPNG = "icons/csharp.png";
const dotNetPNG = "icons/dotnet.png";
const fireBasePNG = "icons/firebase.png";
const flutterPNG = "icons/flutter.png";
const gitPNG = "icons/git.png";
const mySqlPNG = "icons/mysql.png";
const sqLitePNG = "icons/sqlite.png";
const vbDotNet = "icons/vbdotnet.png";

List<Skill> skills = [
  Skill(year: 4, asset: flutterPNG, name: "Flutter / Dart"),
  Skill(year: 4, asset: fireBasePNG, name: "Firebase"),
  Skill(year: 4, asset: cSharpPNG, name: "C#"),
  Skill(year: 4, asset: dotNetPNG, name: ".NET"),
  Skill(year: 4, asset: mySqlPNG, name: "MySQL"),
  Skill(year: 4, asset: gitPNG, name: "Git"),
  Skill(year: 3, asset: vbDotNet, name: "VB.NET"),
  Skill(year: 1, asset: sqLitePNG, name: "SQLite"),
];
// [
//   flutterPNG,
//   fireBasePNG,
//   gitHubBigPNG,
//   cSharpPNG,
//   dotNetPNG,
//   mySqlPNG,
//   vbDotNet,
//   sqLite,
// ];
