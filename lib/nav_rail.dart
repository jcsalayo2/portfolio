import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/header_link_icons.dart';
import 'package:portfolio/model/projects.dart';
import 'package:portfolio/service/previous_projects_service.dart';
import 'package:portfolio/theme/portfolio_theme.dart';
import 'package:universal_html/html.dart' as html;

class NavRail extends StatefulWidget {
  const NavRail({
    super.key,
    required this.isPortrait,
  });

  final bool isPortrait;

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  int _selectedIndex = 0;
  late final Future<List<Project>> _projectsFuture =
      PreviousProjectsService().getPreviousProjects();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Project>>(
      future: _projectsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 48),
            child: Center(
              child: CircularProgressIndicator(color: Colors.amber),
            ),
          );
        }

        final projects = snapshot.data ?? [];
        if (projects.isEmpty) {
          return const SizedBox.shrink();
        }

        final selected =
            projects[_selectedIndex.clamp(0, projects.length - 1)];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            _ProjectSelector(
              projects: projects,
              selectedIndex: _selectedIndex,
              isPortrait: widget.isPortrait,
              onSelected: (index) => setState(() => _selectedIndex = index),
            ),
            const SizedBox(height: 24),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.04),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: _ProjectDetail(
                key: ValueKey(selected.name),
                project: selected,
                isPortrait: widget.isPortrait,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProjectSelector extends StatelessWidget {
  const _ProjectSelector({
    required this.projects,
    required this.selectedIndex,
    required this.isPortrait,
    required this.onSelected,
  });

  final List<Project> projects;
  final int selectedIndex;
  final bool isPortrait;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final tabs = List.generate(projects.length, (index) {
      final isSelected = index == selectedIndex;
      return Padding(
        padding: EdgeInsets.only(
          right: index == projects.length - 1 ? 0 : 10,
          bottom: isPortrait ? 10 : 0,
        ),
        child: _ProjectTab(
          label: projects[index].name,
          isSelected: isSelected,
          onTap: () => onSelected(index),
        ),
      );
    });

    if (isPortrait) {
      return Wrap(children: tabs);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: tabs),
    );
  }
}

class _ProjectTab extends StatelessWidget {
  const _ProjectTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
        child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? PortfolioColors.accent.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? PortfolioColors.accent
                  : PortfolioColors.accent.withValues(alpha: 0.25),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: isSelected ? 16 : 15,
              color: isSelected ? Colors.amber : Colors.white70,
              fontVariations: [
                FontVariation('wght', isSelected ? 700 : 500),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectDetail extends StatelessWidget {
  const _ProjectDetail({
    super.key,
    required this.project,
    required this.isPortrait,
  });

  final Project project;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    final hasImage = project.image.trim().isNotEmpty;
    final hasWebsite = project.website.trim().isNotEmpty;
    final hasPlayLink = project.playLink.trim().isNotEmpty;

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                project.name,
                style: const TextStyle(
                  fontFamily: 'PlayFair',
                  fontSize: 26,
                  color: Colors.amber,
                  fontVariations: [FontVariation('wght', 700)],
                ),
              ),
            ),
            if (project.duration.trim().isNotEmpty) ...[
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  project.duration,
                  style: const TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 13,
                    color: Colors.white70,
                    fontVariations: [FontVariation('wght', 500)],
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        Text(
          project.description,
          style: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 16,
            height: 1.5,
            color: Colors.white,
            fontVariations: [FontVariation('wght', 400)],
          ),
        ),
        if (project.technologies.isNotEmpty) ...[
          const SizedBox(height: 20),
          const Text(
            'Technologies',
            style: TextStyle(
              fontFamily: 'PlayFair',
              fontSize: 18,
              color: Colors.amber,
              fontVariations: [FontVariation('wght', 600)],
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.technologies
                .map(
                  (tech) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tech,
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 13,
                        color: Colors.white,
                        fontVariations: [FontVariation('wght', 500)],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
        if (hasWebsite || hasPlayLink) ...[
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              if (hasWebsite)
                _ProjectLinkButton(
                  label: 'Visit Website',
                  icon: Icons.open_in_new,
                  url: project.website,
                ),
              if (hasPlayLink)
                _ProjectLinkButton(
                  label: 'Google Play',
                  icon: Icons.shop,
                  url: project.playLink,
                ),
            ],
          ),
        ],
      ],
    );

    return Container(
      padding: EdgeInsets.all(isPortrait ? 16 : 24),
      decoration: BoxDecoration(
        border: Border.all(
          color: PortfolioColors.accent.withValues(alpha: 0.35),
        ),
        borderRadius: BorderRadius.circular(12),
        color: PortfolioColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: isPortrait || !hasImage
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasImage) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      project.image,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                details,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    project.image,
                    width: 220,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(width: 28),
                Expanded(child: details),
              ],
            ),
    );
  }
}

class _ProjectLinkButton extends StatelessWidget {
  const _ProjectLinkButton({
    required this.label,
    required this.icon,
    required this.url,
  });

  final String label;
  final IconData icon;
  final String url;

  void _open() {
    if (kIsWeb) {
      html.window.open(url, 'new tab');
    } else {
      launchInBrowserView(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: _open,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.amber,
        side: const BorderSide(color: Colors.amber, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 14,
          fontVariations: [FontVariation('wght', 600)],
        ),
      ),
    );
  }
}
