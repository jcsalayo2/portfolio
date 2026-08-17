import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constant.dart';
import 'package:portfolio/model/links.dart';
import 'package:portfolio/service/links_service.dart';
import 'package:portfolio/theme/portfolio_theme.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

class HeaderLinkIcons extends StatefulWidget {
  const HeaderLinkIcons({
    super.key,
    this.isHorizontal = false,
  });

  final bool isHorizontal;

  @override
  State<HeaderLinkIcons> createState() => _HeaderLinkIconsState();
}

class _HeaderLinkIconsState extends State<HeaderLinkIcons> {
  late final Future<List<Link>> _linksFuture =
      LinksService().getLinksProjects();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Link>>(
      future: _linksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              color: PortfolioColors.accent,
              strokeWidth: 2,
            ),
          );
        }

        final links = snapshot.data ?? [];
        final linkedinLink =
            links.firstWhere((x) => x.name == 'linkedin').link;
        final fbLink = links.firstWhere((x) => x.name == 'facebook').link;
        final githubLink = links.firstWhere((x) => x.name == 'github').link;

        final icons = [
          _SocialIcon(asset: linkedinPNG, url: linkedinLink),
          _SocialIcon(asset: githubPNG, url: githubLink),
          _SocialIcon(asset: fbPNG, url: fbLink),
        ];

        if (widget.isHorizontal) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < icons.length; i++) ...[
                if (i > 0) const SizedBox(width: 12),
                icons[i],
              ],
            ],
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < icons.length; i++) ...[
              if (i > 0) const SizedBox(height: 12),
              icons[i],
            ],
          ],
        );
      },
    );
  }
}

class _SocialIcon extends StatefulWidget {
  const _SocialIcon({required this.asset, required this.url});

  final String asset;
  final String url;

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  void _open() {
    if (kIsWeb) {
      html.window.open(widget.url, 'new tab');
    } else {
      launchInBrowserView(Uri.parse(widget.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _open,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovered
                ? PortfolioColors.accent.withValues(alpha: 0.15)
                : Colors.transparent,
            border: Border.all(
              color: _hovered
                  ? PortfolioColors.accent
                  : PortfolioColors.accent.withValues(alpha: 0.3),
            ),
          ),
          child: AnimatedScale(
            scale: _hovered ? 1.1 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Image.asset(
              widget.asset,
              height: 32,
              color: PortfolioColors.accent,
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> launchInBrowserView(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
    throw Exception('Could not launch $url');
  }
}
