import 'package:flutter/material.dart';
import 'package:portfolio/constant.dart';
import 'package:portfolio/model/links.dart';
import 'package:portfolio/service/links_service.dart';
import 'dart:html' as html;

class HeaderLinkIcons extends StatelessWidget {
  const HeaderLinkIcons({
    super.key,
    this.isHorizontal = false,
  });

  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Link>>(
        future: LinksService().getLinksProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }
          var linkedinLink =
              snapshot.data!.firstWhere((x) => x.name == 'linkedin').link;
          var fbLink =
              snapshot.data!.firstWhere((x) => x.name == 'facebook').link;
          var githubLink =
              snapshot.data!.firstWhere((x) => x.name == 'github').link;
          if (isHorizontal) {
            return Row(
              children: [
                linkedin(linkedinLink),
                SizedBox(width: 5),
                github(githubLink),
                SizedBox(width: 5),
                fb(fbLink),
              ],
            );
          } else {
            return Column(
              children: [
                linkedin(linkedinLink),
                SizedBox(height: 5),
                github(githubLink),
                SizedBox(height: 5),
                fb(fbLink),
              ],
            );
          }
        });
  }

  InkWell fb(String fbLink) {
    return InkWell(
      onTap: () {
        html.window.open(fbLink, 'new tab');
      },
      child: Image.asset(
        fbPNG,
        height: 40,
        color: Colors.amber,
      ),
    );
  }

  InkWell github(String githubLink) {
    return InkWell(
      onTap: () {
        html.window.open(githubLink, 'new tab');
      },
      child: Image.asset(
        githubPNG,
        height: 40,
        color: Colors.amber,
      ),
    );
  }

  InkWell linkedin(String linkedinLink) {
    return InkWell(
      onTap: () {
        html.window.open(linkedinLink, 'new tab');
      },
      child: Image.asset(
        linkedinPNG,
        height: 40,
        color: Colors.amber,
      ),
    );
  }
}
