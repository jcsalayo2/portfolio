import 'package:flutter/material.dart';
import 'package:portfolio/constant.dart';
import 'package:portfolio/header_link_icons.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key, required bool isPortrait});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            fullName(),
            mobileNumber(),
          ],
        ),
        // contactIcons()
        HeaderLinkIcons(isHorizontal: true),
      ],
    );
  }

  Row mobileNumber() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Mobile Number : ",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontVariations: [FontVariation('wght', 400)],
          ),
        ),
        Flexible(
          child: Text(
            "+639611400124(Smart), +639153440320(Globe)",
            softWrap: true,
            style: TextStyle(
              fontSize: 18,
              color: Colors.amber,
              fontVariations: [FontVariation('wght', 800)],
            ),
          ),
        ),
      ],
    );
  }

  Row fullName() {
    return const Row(
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
        Flexible(
          child: Text(
            "James Carlo Desipida Salayo",
            softWrap: true,
            style: TextStyle(
              overflow: TextOverflow.clip,
              fontSize: 18,
              color: Colors.amber,
              fontVariations: [FontVariation('wght', 800)],
            ),
          ),
        ),
      ],
    );
  }
}
