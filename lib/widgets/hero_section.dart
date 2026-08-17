import 'package:flutter/material.dart';
import 'package:portfolio/header_link_icons.dart';
import 'package:portfolio/service/portrait_service.dart';
import 'package:portfolio/theme/portfolio_theme.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({
    super.key,
    required this.scrollController,
    required this.isPortrait,
  });

  final ScrollController scrollController;
  final bool isPortrait;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entryController;
  late final Animation<double> _entryFade;
  late final Future<String> _portraitFuture;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _entryFade = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOut,
    );
    _entryController.forward();
    _portraitFuture = PortraitService().getPortrait();
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = PortfolioBreakpoints.isMobile(context);

    return FutureBuilder<String>(
      future: _portraitFuture,
      builder: (context, snapshot) {
        final portraitUrl =
            snapshot.connectionState == ConnectionState.done
                ? snapshot.data
                : null;

        if (isMobile || widget.isPortrait) {
          return _MobileHero(
            entryFade: _entryFade,
            portraitUrl: portraitUrl,
            scrollController: widget.scrollController,
          );
        }

        return _DesktopHero(
          entryFade: _entryFade,
          portraitUrl: portraitUrl,
          scrollController: widget.scrollController,
        );
      },
    );
  }
}

/// Portrait photo aspect ratio (width : height = 1 : 2).
const _portraitAspectRatio = 1 / 2;

double _parallaxOffset(ScrollController controller) {
  if (!controller.hasClients) return 0;
  return controller.offset * 0.25;
}

class _DesktopHero extends StatelessWidget {
  const _DesktopHero({
    required this.entryFade,
    required this.portraitUrl,
    required this.scrollController,
  });

  final Animation<double> entryFade;
  final String? portraitUrl;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 640,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: AnimatedBuilder(
              animation: scrollController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -_parallaxOffset(scrollController)),
                  child: child,
                );
              },
              child: FadeTransition(
                opacity: entryFade,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: _PortraitFrame(
                    portraitUrl: portraitUrl,
                    width: 300,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: FadeTransition(
              opacity: entryFade,
              child: const Center(child: _HeroText()),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 40,
            child: FadeTransition(
              opacity: entryFade,
              child: const HeaderLinkIcons(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileHero extends StatelessWidget {
  const _MobileHero({
    required this.entryFade,
    required this.portraitUrl,
    required this.scrollController,
  });

  final Animation<double> entryFade;
  final String? portraitUrl;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final portraitWidth = (screenWidth * 0.55).clamp(200.0, 280.0);

    return FadeTransition(
      opacity: entryFade,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: scrollController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -_parallaxOffset(scrollController) * 0.5),
                child: child,
              );
            },
            child: _PortraitFrame(
              portraitUrl: portraitUrl,
              width: portraitWidth,
            ),
          ),
          const SizedBox(height: 24),
          const _HeroText(centered: true),
          const SizedBox(height: 24),
          const HeaderLinkIcons(isHorizontal: true),
        ],
      ),
    );
  }
}

class _PortraitFrame extends StatelessWidget {
  const _PortraitFrame({
    required this.portraitUrl,
    required this.width,
  });

  final String? portraitUrl;
  final double width;

  double get height => width / _portraitAspectRatio;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PortfolioColors.accent.withValues(alpha: 0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: PortfolioColors.accent.withValues(alpha: 0.15),
            blurRadius: 40,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: portraitUrl == null
            ? Container(
                color: PortfolioColors.surface,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: PortfolioColors.accent,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Image.network(
                portraitUrl!,
                fit: BoxFit.cover,
                width: width,
                height: height,
                alignment: Alignment.topCenter,
              ),
      ),
    );
  }
}

class _HeroText extends StatefulWidget {
  const _HeroText({this.centered = false});

  final bool centered;

  @override
  State<_HeroText> createState() => _HeroTextState();
}

class _HeroTextState extends State<_HeroText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = PortfolioBreakpoints.isMobile(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          widget.centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        _AnimatedLine(
          controller: _controller,
          delay: 0,
          child: Text(
            "I'M",
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              color: PortfolioColors.textPrimary,
              fontFamily: 'Quicksand',
              fontVariations: const [FontVariation('wght', 400)],
              letterSpacing: 4,
            ),
          ),
        ),
        _AnimatedLine(
          controller: _controller,
          delay: 0.15,
          child: Text(
            "James",
            textAlign: widget.centered ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: isMobile ? 52 : 72,
              color: PortfolioColors.accent,
              fontFamily: 'PlayFair',
              fontVariations: const [FontVariation('wght', 800)],
              height: 1.1,
            ),
          ),
        ),
        _AnimatedLine(
          controller: _controller,
          delay: 0.3,
          child: Text(
            "A Software Engineer",
            textAlign: widget.centered ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: isMobile ? 20 : 28,
              color: PortfolioColors.textSecondary,
              fontFamily: 'Quicksand',
              fontVariations: const [FontVariation('wght', 500)],
            ),
          ),
        ),
      ],
    );
  }
}

class _AnimatedLine extends StatelessWidget {
  const _AnimatedLine({
    required this.controller,
    required this.delay,
    required this.child,
  });

  final AnimationController controller;
  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      curve: Interval(
        delay,
        (delay + 0.5).clamp(0.0, 1.0),
        curve: Curves.easeOutCubic,
      ),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.4),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
