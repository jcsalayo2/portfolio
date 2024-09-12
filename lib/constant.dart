import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/model/employement_history_model.dart';
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

List<EmployementHistory> employementHistory = [
  EmployementHistory(
    title: "Software Engineer at Globagility, Mandaluyong City",
    range: "April 2023 — Present",
    description: [
      "Developed and maintained software in multiple programming languages, such as Flutter Dart, C#, VB.NET, and ASP.NET.",
      "Developed a robust system architecture to ensure high scalability and maintainability of the app.",
      "Developed a MySQL database schema that allowed for efficient data storage and retrieval.",
    ],
  ),
  EmployementHistory(
    title:
        "Subject Matter Expert at Achieve Without Borders (Globagility Partner), Makati City",
    range: "August 2022 — April 2023",
    description: [
      "Developed and maintained relationships with internal and external stakeholders to ensure alignment and collaboration.",
      "Developed an in-depth understanding of the company's products and services, becoming the go-to source for questions and inquiries from internal and external stakeholders.",
      "Conducted code reviews and mentored junior developers to improve code quality and ensure adherence to best practices.",
    ],
  ),
  EmployementHistory(
    title:
        "Flutter Developer at Achieve Without Borders (Globagility Partner), Makati City",
    range: "May 2022 — August 2022",
    description: [
      "Developed a custom UI/UX design for the mobile application that increased user engagement and satisfaction.",
      "Implemented a REST API integration that dynamically retrieved and synchronized data from the server to the mobile application.",
      "Utilized the latest features of the Flutter SDK to create a dynamic and immersive user experience.",
      "Utilized state management techniques to create a responsive and reactive user interface",
      "Implemented automated testing that increased code coverage to 90%, reducing the number of production issues.",
    ],
  ),
  EmployementHistory(
    title: "Software Engineer at Globagility, Mandaluyong City",
    range: "Feb 2020 — May 2022",
    description: [],
  ),
];
