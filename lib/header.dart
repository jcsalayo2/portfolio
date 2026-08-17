import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/constant.dart';
import 'package:portfolio/theme/portfolio_theme.dart';

void scrollToSection(GlobalKey key) {
  final context = key.currentContext;
  if (context == null) return;
  Scrollable.ensureVisible(
    context,
    duration: const Duration(milliseconds: 800),
    curve: Curves.easeInOutCubic,
    alignment: 0.08,
  );
}

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    super.key,
    required this.aboutMeKey,
    required this.projectsKey,
    required this.contactKey,
    required this.scrolled,
    required this.onNavigate,
  });

  final GlobalKey aboutMeKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;
  final bool scrolled;
  final VoidCallback onNavigate;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final isMobile = PortfolioBreakpoints.isMobile(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: scrolled ? 12 : 0,
          sigmaY: scrolled ? 12 : 0,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: scrolled
                ? PortfolioColors.background.withValues(alpha: 0.85)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: scrolled
                    ? PortfolioColors.accent.withValues(alpha: 0.25)
                    : Colors.transparent,
              ),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: PortfolioBreakpoints.horizontalPadding(context),
              ),
              child: SizedBox(
                height: 56,
                child: Row(
                  children: [
                    Text(
                      'JS',
                      style: textHeader.copyWith(
                        fontSize: isMobile ? 20 : 24,
                        fontVariations: const [FontVariation('wght', 700)],
                      ),
                    ),
                    const Spacer(),
                    if (isMobile)
                      _MobileMenuButton(
                        aboutMeKey: aboutMeKey,
                        projectsKey: projectsKey,
                        contactKey: contactKey,
                        onNavigate: onNavigate,
                      )
                    else
                      _DesktopNav(
                        aboutMeKey: aboutMeKey,
                        projectsKey: projectsKey,
                        contactKey: contactKey,
                        onNavigate: onNavigate,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopNav extends StatelessWidget {
  const _DesktopNav({
    required this.aboutMeKey,
    required this.projectsKey,
    required this.contactKey,
    required this.onNavigate,
  });

  final GlobalKey aboutMeKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;
  final VoidCallback onNavigate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _NavButton(
          label: 'About',
          onTap: () {
            scrollToSection(aboutMeKey);
            onNavigate();
          },
        ),
        const SizedBox(width: 8),
        _NavButton(
          label: 'Projects',
          onTap: () {
            scrollToSection(projectsKey);
            onNavigate();
          },
        ),
        const SizedBox(width: 8),
        _NavButton(
          label: 'Contact',
          onTap: () {
            scrollToSection(contactKey);
            onNavigate();
          },
        ),
      ],
    );
  }
}

class _NavButton extends StatefulWidget {
  const _NavButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: TextButton(
        onPressed: widget.onTap,
        style: TextButton.styleFrom(
          foregroundColor: PortfolioColors.accent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: textHeader.copyWith(
            fontSize: _hovered ? 22 : 20,
            color: _hovered
                ? PortfolioColors.accent
                : PortfolioColors.textSecondary,
            fontVariations: [
              FontVariation('wght', _hovered ? 600 : 500),
            ],
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  const _MobileMenuButton({
    required this.aboutMeKey,
    required this.projectsKey,
    required this.contactKey,
    required this.onNavigate,
  });

  final GlobalKey aboutMeKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;
  final VoidCallback onNavigate;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu_rounded, color: PortfolioColors.accent),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          backgroundColor: PortfolioColors.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: PortfolioColors.accent.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _SheetNavItem(
                    label: 'About',
                    icon: Icons.person_outline,
                    onTap: () {
                      Navigator.pop(context);
                      scrollToSection(aboutMeKey);
                      onNavigate();
                    },
                  ),
                  _SheetNavItem(
                    label: 'Projects',
                    icon: Icons.work_outline,
                    onTap: () {
                      Navigator.pop(context);
                      scrollToSection(projectsKey);
                      onNavigate();
                    },
                  ),
                  _SheetNavItem(
                    label: 'Contact',
                    icon: Icons.mail_outline,
                    onTap: () {
                      Navigator.pop(context);
                      scrollToSection(contactKey);
                      onNavigate();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SheetNavItem extends StatelessWidget {
  const _SheetNavItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: PortfolioColors.accent),
      title: Text(
        label,
        style: const TextStyle(
          fontFamily: 'PlayFair',
          fontSize: 20,
          color: PortfolioColors.textPrimary,
          fontVariations: [FontVariation('wght', 600)],
        ),
      ),
      onTap: onTap,
    );
  }
}
