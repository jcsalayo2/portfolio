import 'package:flutter/material.dart';
import 'package:portfolio/constant.dart';

class HeaderLinkIcons extends StatelessWidget {
  const HeaderLinkIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          linkedinPNG,
          height: 40,
          color: Colors.amber,
        ),
        SizedBox(height: 5),
        Image.asset(
          githubPNG,
          height: 40,
          color: Colors.amber,
        ),
        SizedBox(height: 5),
        Image.asset(
          fbPNG,
          height: 40,
          color: Colors.amber,
        ),
      ],
    );
  }
}
