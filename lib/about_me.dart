import 'package:flutter/material.dart';
import 'package:portfolio/constant.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({
    super.key,
    required this.isPortrait,
    required this.aboutMeKey,
  });
  final GlobalKey aboutMeKey;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isPortrait ? 0 : 120),
      child: Column(
        key: aboutMeKey,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "About Me",
            style: TextStyle(
                fontSize: 36,
                color: Colors.amber,
                fontFamily: 'PlayFair',
                fontVariations: [FontVariation('wght', 800)]),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40),
            child: Text(
              aboutMe,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                // fontVariations: [FontVariation('wght', 800)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
