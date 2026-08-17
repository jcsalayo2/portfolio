import 'package:flutter/material.dart';
import 'package:portfolio/service/strings_service.dart';
import 'package:portfolio/theme/portfolio_theme.dart';
import 'package:portfolio/widgets/scroll_reveal.dart';
import 'package:portfolio/widgets/section_title.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({
    super.key,
    required this.isPortrait,
    required this.aboutMeKey,
    required this.sectionPadding,
  });

  final GlobalKey aboutMeKey;
  final bool isPortrait;
  final double sectionPadding;

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  late final Future<String> _aboutMeFuture = StringsService().getAboutMe();

  @override
  Widget build(BuildContext context) {
    final isMobile = PortfolioBreakpoints.isMobile(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.sectionPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: 'About Me', sectionKey: widget.aboutMeKey),
          const SizedBox(height: 20),
          ScrollReveal(
            delay: const Duration(milliseconds: 120),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(isMobile ? 20 : 28),
              decoration: BoxDecoration(
                color: PortfolioColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: const Border(
                  left: BorderSide(
                    color: PortfolioColors.accent,
                    width: 4,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: FutureBuilder<String>(
                future: _aboutMeFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const SizedBox(
                      height: 80,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: PortfolioColors.accent,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                  return Text(
                    snapshot.data ?? '',
                    textAlign: TextAlign.justify,
                    style: PortfolioTextStyles.body.copyWith(
                      fontSize: isMobile ? 15 : 16,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
