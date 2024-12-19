import 'package:flutter/material.dart';
import 'package:portfolio/constant.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.aboutMeKey,
    required this.projectsKey,
    required this.contactKey,
  });

  final GlobalKey aboutMeKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              Scrollable.ensureVisible(aboutMeKey.currentContext!);
            },
            child: Text(
              'About',
              style: textHeader,
            )),
        const SizedBox(width: 20),
        TextButton(
            onPressed: () {
              Scrollable.ensureVisible(projectsKey.currentContext!);
            },
            child: Text(
              'Projects',
              style: textHeader,
            )),
        const SizedBox(width: 20),
        TextButton(
            onPressed: () {
              Scrollable.ensureVisible(contactKey.currentContext!);
            },
            child: Text(
              'Contacts',
              style: textHeader,
            )),
      ],
    );
  }
}
