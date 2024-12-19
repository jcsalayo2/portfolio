import 'package:flutter/material.dart';
import 'package:portfolio/about_me.dart';
import 'package:portfolio/contact_info.dart';
import 'package:portfolio/employement_history_timeline.dart';
import 'package:portfolio/header.dart';
import 'package:portfolio/header_about_rich_text.dart';
import 'package:portfolio/header_link_icons.dart';
import 'package:portfolio/nav_rail.dart';
import 'package:portfolio/service/portrait_service.dart';
import 'package:portfolio/skills.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final aboutMeKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    bool isPortrait =
        MediaQuery.of(context).size.width <= MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: Header(
          aboutMeKey: aboutMeKey,
          projectsKey: projectsKey,
          contactKey: contactKey,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 51, 51, 51),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: width * 0.125, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 100,
              ),
              Stack(children: <Widget>[
                Align(
                  alignment:
                      isPortrait ? Alignment.centerLeft : Alignment.center,
                  child: Container(
                    height: 600,
                    width: isPortrait ? null : 600,
                    alignment: isPortrait ? null : Alignment.centerLeft,
                    child: FutureBuilder<String>(
                        future: PortraitService().getPortrait(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return Container();
                          }
                          return Image.network(
                            snapshot.data!,
                            height: 600,
                          );
                        }),
                  ),
                ),
                const Positioned.fill(
                    child: Center(child: HeaderAboutRichText())),
                const Positioned(
                  right: 0,
                  bottom: 0,
                  child: HeaderLinkIcons(),
                )
              ]),
              const SizedBox(
                height: 50,
              ),
              const Divider(
                color: Colors.amber,
              ),
              AboutMe(isPortrait: isPortrait, aboutMeKey: aboutMeKey),
              const SizedBox(
                height: 50,
              ),
              Skills(isPortrait: isPortrait, width: width),
              const Divider(
                color: Colors.amber,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isPortrait ? 0 : 120),
                child: const Text(
                  "Employement History",
                  style: TextStyle(
                      fontSize: 36,
                      color: Colors.amber,
                      fontFamily: 'PlayFair',
                      fontVariations: [FontVariation('wght', 800)]),
                ),
              ),
              EmployementHistoryTimeline(isPortrait: isPortrait),
              const SizedBox(
                height: 50,
              ),
              const Divider(
                color: Colors.amber,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isPortrait ? 0 : 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      key: projectsKey,
                      "Previous Projects",
                      style: const TextStyle(
                          fontSize: 36,
                          color: Colors.amber,
                          fontFamily: 'PlayFair',
                          fontVariations: [FontVariation('wght', 800)]),
                    ),
                    NavRail(isPortrait: isPortrait),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Divider(
                color: Colors.amber,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isPortrait ? 0 : 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      key: contactKey,
                      "Contacts",
                      style: const TextStyle(
                          fontSize: 36,
                          color: Colors.amber,
                          fontFamily: 'PlayFair',
                          fontVariations: [FontVariation('wght', 800)]),
                    ),
                    ContactInfo(isPortrait: isPortrait),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
