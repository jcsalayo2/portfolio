import 'package:flutter/material.dart';
import 'package:portfolio/model/skill_model.dart';
import 'package:portfolio/service/skill_service.dart';
import 'package:portfolio/theme/portfolio_theme.dart';
import 'package:portfolio/widgets/scroll_reveal.dart';
import 'package:portfolio/widgets/section_title.dart';

class Skills extends StatefulWidget {
  const Skills({
    super.key,
    required this.isPortrait,
    required this.width,
  });

  final bool isPortrait;
  final double width;

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  late final Future<List<Skill>> _skillsFuture = SkillService().getSkills();

  @override
  Widget build(BuildContext context) {
    final isMobile = PortfolioBreakpoints.isMobile(context);
    final cardSize = isMobile ? 140.0 : 160.0;

    return Column(
      children: [
        const SectionTitle(title: 'Skills'),
        const SizedBox(height: 24),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.isPortrait ? 0 : widget.width * 0.05,
          ),
          child: FutureBuilder<List<Skill>>(
            future: _skillsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Padding(
                  padding: EdgeInsets.all(48),
                  child: CircularProgressIndicator(
                    color: PortfolioColors.accent,
                  ),
                );
              }

              final skills = snapshot.data ?? [];
              return Wrap(
                alignment: WrapAlignment.center,
                spacing: isMobile ? 12 : 20,
                runSpacing: isMobile ? 20 : 28,
                children: [
                  for (var i = 0; i < skills.length; i++)
                    ScrollReveal(
                      delay: Duration(milliseconds: 60 * i),
                      child: _SkillCard(
                        skill: skills[i],
                        size: cardSize,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SkillCard extends StatefulWidget {
  const _SkillCard({required this.skill, required this.size});

  final Skill skill;
  final double size;

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = PortfolioBreakpoints.isMobile(context);
    final circleSize = widget.size;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hovered ? -6.0 : 0.0, 0),
        child: SizedBox(
          width: isMobile ? (MediaQuery.sizeOf(context).width - 64) / 2 : 180,
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(20),
                height: circleSize,
                width: circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: PortfolioColors.surface,
                  border: Border.all(
                    color: _hovered
                        ? PortfolioColors.accent
                        : PortfolioColors.accent.withValues(alpha: 0.5),
                    width: _hovered ? 3 : 2,
                  ),
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: PortfolioColors.accent.withValues(alpha: 0.25),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Image.network(
                  widget.skill.asset,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.skill.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: PortfolioColors.textPrimary,
                  fontFamily: 'Quicksand',
                  fontVariations: [FontVariation('wght', 600)],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${widget.skill.years} ${widget.skill.years > 1 ? 'YEARS' : 'YEAR'}',
                style: TextStyle(
                  fontSize: 13,
                  color: PortfolioColors.accent.withValues(
                    alpha: _hovered ? 1 : 0.8,
                  ),
                  fontFamily: 'Quicksand',
                  fontVariations: const [FontVariation('wght', 500)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
