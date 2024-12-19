import 'package:flutter/material.dart';

class HeaderAboutRichText extends StatelessWidget {
  const HeaderAboutRichText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: const TextSpan(
      style: TextStyle(fontSize: 32, color: Colors.white),
      children: [
        TextSpan(text: "I'M "),
        TextSpan(
          text: "James\n",
          style: TextStyle(
              fontSize: 46,
              color: Colors.amber,
              fontFamily: 'PlayFair',
              fontVariations: [FontVariation('wght', 800)]),
        ),
        TextSpan(
          text: "A software engineer",
        ),
      ],
    ));
  }
}
