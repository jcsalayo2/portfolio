import 'package:flutter/material.dart';
import 'package:portfolio/about_me.dart';
import 'package:portfolio/contact_info.dart';
import 'package:portfolio/employement_history_timeline.dart';
import 'package:portfolio/header.dart';
import 'package:portfolio/nav_rail.dart';
import 'package:portfolio/skills.dart';
import 'package:portfolio/theme/portfolio_theme.dart';
import 'package:portfolio/widgets/hero_section.dart';
import 'package:portfolio/widgets/section_title.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final aboutMeKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();
  final _scrollController = ScrollController();

  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 40;
    if (scrolled != _scrolled) {
      setState(() => _scrolled = scrolled);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isPortrait =
        MediaQuery.sizeOf(context).width <= MediaQuery.sizeOf(context).height;
    final isMobile = PortfolioBreakpoints.isMobile(context);
    final hPadding = PortfolioBreakpoints.horizontalPadding(context);
    final sectionPadding = PortfolioBreakpoints.sectionPadding(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Header(
        aboutMeKey: aboutMeKey,
        projectsKey: projectsKey,
        contactKey: contactKey,
        scrolled: _scrolled,
        onNavigate: () {},
      ),
      backgroundColor: PortfolioColors.background,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: isMobile ? 80 : 100),
              HeroSection(
                scrollController: _scrollController,
                isPortrait: isPortrait,
              ),
              const AnimatedSectionDivider(),
              RepaintBoundary(
                child: AboutMe(
                  isPortrait: isPortrait,
                  aboutMeKey: aboutMeKey,
                  sectionPadding: sectionPadding,
                ),
              ),
              const AnimatedSectionDivider(),
              RepaintBoundary(
                child: Skills(
                  isPortrait: isPortrait,
                  width: width,
                ),
              ),
              const AnimatedSectionDivider(),
              RepaintBoundary(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: sectionPadding),
                  child: const SectionTitle(title: 'Employment History'),
                ),
              ),
              const SizedBox(height: 16),
              RepaintBoundary(
                child: EmployementHistoryTimeline(isPortrait: isPortrait),
              ),
              const AnimatedSectionDivider(),
              RepaintBoundary(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: sectionPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(
                        title: 'Previous Projects',
                        sectionKey: projectsKey,
                      ),
                      NavRail(isPortrait: isPortrait),
                    ],
                  ),
                ),
              ),
              const AnimatedSectionDivider(),
              RepaintBoundary(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: sectionPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(
                        title: 'Contact',
                        sectionKey: contactKey,
                      ),
                      const SizedBox(height: 20),
                      ContactInfo(isPortrait: isPortrait),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
