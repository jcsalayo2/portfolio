import 'package:flutter/material.dart';
import 'package:portfolio/constant.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/model/employement_history_model.dart';
import 'package:portfolio/model/projects.dart';
import 'package:portfolio/model/skill_model.dart';
import 'package:portfolio/service/employement_history_service.dart';
import 'package:portfolio/service/portrait_service.dart';
import 'package:portfolio/service/previous_projects_service.dart';
import 'package:portfolio/service/skill_service.dart';
import 'package:tab_container/tab_container.dart';
import 'package:timelines_plus/timelines_plus.dart';

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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NavRail extends StatelessWidget {
  const NavRail({
    super.key,
    required this.isPortrait,
  });

  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FutureBuilder<List<Project>>(
            future: PreviousProjectsService().getPreviousProjects(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container();
              }
              List<Widget> tabTitle = [];
              List<Widget> tabContent = [];
              for (var project in snapshot.data!) {
                tabTitle.add(Text(project.name));
                tabContent.add(ProjectContent(project: project));
              }
              return TabContainer(
                borderRadius: BorderRadius.circular(10),
                tabEdge: isPortrait ? TabEdge.left : TabEdge.top,
                curve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  animation =
                      CurvedAnimation(curve: Curves.easeIn, parent: animation);
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                // colors: const <Color>[
                //   Color(0xfffa86be),
                //   Color(0xfffa86be),
                //   Color(0xfffa86be),
                // ],
                color: Colors.amber[100],
                // selectedTextStyle: textTheme.bodyMedium?.copyWith(fontSize: 15.0),
                // unselectedTextStyle: textTheme.bodyMedium?.copyWith(fontSize: 13.0),
                tabs: tabTitle,
                children: tabContent,
              );
            }),
      ],
    );
  }

  Widget ProjectContent({required Project project}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            "Description",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(project.description),
          SizedBox(
            height: 20,
          ),
          Text(
            "Technologies",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(project.technologies.join(", ")),
        ],
      ),
    );
  }
}

class EmployementHistoryTimeline extends StatelessWidget {
  const EmployementHistoryTimeline({
    super.key,
    required this.isPortrait,
  });

  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EmployementHistory>>(
        future: EmployementHistoryService().getEmploymentHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }
          return Timeline.tileBuilder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            theme: TimelineThemeData(
              color: Colors.amber,
              nodePosition: isPortrait ? 0.2 : null,
            ),
            builder: TimelineTileBuilder.fromStyle(
              indicatorStyle: IndicatorStyle.outlined,
              contentsAlign:
                  isPortrait ? ContentsAlign.basic : ContentsAlign.alternating,
              contentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data![index].title,
                      style: const TextStyle(
                          color: Colors.amber,
                          fontFamily: "PlayFair",
                          fontSize: 22),
                    ),
                    for (var description
                        in snapshot.data![index].description) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 6, right: 5),
                            child: Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.amber,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              softWrap: true,
                              description,
                              style: const TextStyle(
                                  fontFamily: "Quicksand",
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
              oppositeContentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  snapshot.data![index].range,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              itemCount: snapshot.data!.length,
            ),
          );
        });
  }
}

class Skills extends StatelessWidget {
  const Skills({
    super.key,
    required this.isPortrait,
    required this.width,
  });

  final bool isPortrait;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Skills",
          style: TextStyle(
              fontSize: 36,
              color: Colors.amber,
              fontFamily: 'PlayFair',
              fontVariations: [FontVariation('wght', 800)]),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: isPortrait ? 0 : width * 0.1),
          child: Center(
            child: FutureBuilder<List<Skill>>(
                future: SkillService().getSkills(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Container();
                  }
                  return Wrap(
                    children: snapshot.data!
                        .map(
                          (e) =>
                              // SkillContainer(),
                              Container(
                            margin: EdgeInsets.only(bottom: 15),
                            height: 200,
                            width: 200,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.amber, width: 2)),
                                  child: Image.network(
                                    e.asset,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(e.name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: "Quicksand")),
                                Text(
                                    "${e.years} ${e.years > 1 ? "YEARS" : "YEAR"}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: "Quicksand")),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                }),
          ),
        ),
      ],
    );
  }
}

class SkillContainer extends StatelessWidget {
  const SkillContainer({
    super.key,
    required this.e,
  });

  final Skill e;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      height: 200,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            e.asset,
            height: 80,
          ),
          Text(e.name, style: const TextStyle(fontSize: 20)),
          Text("${e.years} year/s", style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}

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
