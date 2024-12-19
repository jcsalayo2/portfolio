import 'package:flutter/material.dart';
import 'package:portfolio/model/projects.dart';
import 'package:portfolio/service/previous_projects_service.dart';
import 'package:tab_container/tab_container.dart';

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
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: TabContainer(
                  borderRadius: BorderRadius.circular(10),
                  tabEdge: isPortrait ? TabEdge.left : TabEdge.top,
                  curve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    animation = CurvedAnimation(
                        curve: Curves.easeIn, parent: animation);
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
                  color: Colors.amber[200],
                  // selectedTextStyle: textTheme.bodyMedium?.copyWith(fontSize: 15.0),
                  // unselectedTextStyle: textTheme.bodyMedium?.copyWith(fontSize: 13.0),
                  tabs: tabTitle,
                  children: tabContent,
                ),
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
