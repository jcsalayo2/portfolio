import 'package:flutter/material.dart';
import 'package:portfolio/header_link_icons.dart';
import 'package:portfolio/theme/portfolio_theme.dart';
import 'package:portfolio/widgets/scroll_reveal.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key, required this.isPortrait});

  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    final isMobile = PortfolioBreakpoints.isMobile(context);

    return ScrollReveal(
      delay: const Duration(milliseconds: 150),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isMobile ? 20 : 28),
        decoration: BoxDecoration(
          color: PortfolioColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: PortfolioColors.accent.withValues(alpha: 0.25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ContactRow(
              label: 'Full Name',
              value: 'James Carlo Desipida Salayo',
              isMobile: isMobile,
            ),
            const SizedBox(height: 16),
            _ContactRow(
              label: 'Mobile',
              value: '+639611400124 (Smart), +639153440320 (Globe)',
              isMobile: isMobile,
            ),
            const SizedBox(height: 24),
            const Text(
              'Connect',
              style: TextStyle(
                fontFamily: 'PlayFair',
                fontSize: 18,
                color: PortfolioColors.accent,
                fontVariations: [FontVariation('wght', 600)],
              ),
            ),
            const SizedBox(height: 12),
            const HeaderLinkIcons(isHorizontal: true),
          ],
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.label,
    required this.value,
    required this.isMobile,
  });

  final String label;
  final String value;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: PortfolioColors.textSecondary,
              fontFamily: 'Quicksand',
              fontVariations: [FontVariation('wght', 500)],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: PortfolioColors.accent,
              fontFamily: 'Quicksand',
              fontVariations: [FontVariation('wght', 700)],
            ),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            '$label :',
            style: const TextStyle(
              fontSize: 16,
              color: PortfolioColors.textSecondary,
              fontVariations: [FontVariation('wght', 400)],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: PortfolioColors.accent,
              fontVariations: [FontVariation('wght', 700)],
            ),
          ),
        ),
      ],
    );
  }
}
