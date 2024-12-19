import 'package:flutter/material.dart';
import 'package:portfolio/constant.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key, required bool isPortrait});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            titleFields(),
            valueFields(),
          ],
        ),
        contactIcons()
      ],
    );
  }

  Row contactIcons() {
    return Row(
      children: [
        Image.asset(
          linkedinPNG,
          height: 40,
          color: Colors.amber,
        ),
        SizedBox(width: 5),
        Image.asset(
          githubPNG,
          height: 40,
          color: Colors.amber,
        ),
        SizedBox(width: 5),
        Image.asset(
          fbPNG,
          height: 40,
          color: Colors.amber,
        ),
      ],
    );
  }

  Column valueFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "James Carlo Desipida Salayo",
          style: TextStyle(
            fontSize: 18,
            color: Colors.amber,
            fontVariations: [FontVariation('wght', 800)],
          ),
        ),
        Text(
          "+639611400124(Smart), +639153440320(Globe)",
          style: TextStyle(
            fontSize: 18,
            color: Colors.amber,
            fontVariations: [FontVariation('wght', 800)],
          ),
        ),
      ],
    );
  }

  Column titleFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Full Name : ",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontVariations: [FontVariation('wght', 400)],
          ),
        ),
        Text(
          "Mobile Number : ",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontVariations: [FontVariation('wght', 400)],
          ),
        ),
      ],
    );
  }
}
