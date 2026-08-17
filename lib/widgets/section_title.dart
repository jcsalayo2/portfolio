import 'package:flutter/material.dart';
import 'package:portfolio/theme/portfolio_theme.dart';
import 'package:portfolio/widgets/scroll_reveal.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.sectionKey,
    this.subtitle,
  });

  final String title;
  final GlobalKey? sectionKey;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final isMobile = PortfolioBreakpoints.isMobile(context);

    return ScrollReveal(
      child: Column(
        key: sectionKey,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: PortfolioTextStyles.sectionTitle.copyWith(
              fontSize: isMobile ? 28 : 36,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: const TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 15,
                color: PortfolioColors.textSecondary,
                fontVariations: [FontVariation('wght', 400)],
              ),
            ),
          ],
          const SizedBox(height: 12),
          Container(
            width: isMobile ? 48 : 64,
            height: 3,
            decoration: BoxDecoration(
              color: PortfolioColors.accent,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: PortfolioColors.accent.withValues(alpha: 0.4),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedSectionDivider extends StatelessWidget {
  const AnimatedSectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollReveal(
      duration: const Duration(milliseconds: 900),
      offset: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      PortfolioColors.accent.withValues(alpha: 0.6),
                      PortfolioColors.accent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: PortfolioColors.accent,
                  boxShadow: [
                    BoxShadow(
                      color: PortfolioColors.accent.withValues(alpha: 0.5),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      PortfolioColors.accent,
                      PortfolioColors.accent.withValues(alpha: 0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
