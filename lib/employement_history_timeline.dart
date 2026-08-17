import 'package:flutter/material.dart';
import 'package:portfolio/model/employement_history_model.dart';
import 'package:portfolio/service/employement_history_service.dart';
import 'package:portfolio/theme/portfolio_theme.dart';
import 'package:portfolio/widgets/scroll_reveal.dart';
import 'package:timelines_plus/timelines_plus.dart';

class EmployementHistoryTimeline extends StatefulWidget {
  const EmployementHistoryTimeline({
    super.key,
    required this.isPortrait,
  });

  final bool isPortrait;

  @override
  State<EmployementHistoryTimeline> createState() =>
      _EmployementHistoryTimelineState();
}

class _EmployementHistoryTimelineState extends State<EmployementHistoryTimeline> {
  late final Future<List<EmployementHistory>> _historyFuture =
      EmployementHistoryService().getEmploymentHistory();

  @override
  Widget build(BuildContext context) {
    final isMobile = PortfolioBreakpoints.isMobile(context);

    return FutureBuilder<List<EmployementHistory>>(
      future: _historyFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Padding(
            padding: EdgeInsets.all(48),
            child: Center(
              child: CircularProgressIndicator(color: PortfolioColors.accent),
            ),
          );
        }

        final history = snapshot.data ?? [];
        if (history.isEmpty) return const SizedBox.shrink();

        return Timeline.tileBuilder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          theme: TimelineThemeData(
            color: PortfolioColors.accent,
            nodePosition: widget.isPortrait || isMobile ? 0.15 : 0.5,
            indicatorTheme: const IndicatorThemeData(
              size: 20,
              color: PortfolioColors.accent,
            ),
            connectorTheme: const ConnectorThemeData(
              thickness: 2,
              color: PortfolioColors.accent,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: history.length,
            indicatorBuilder: (_, index) => DotIndicator(
              color: PortfolioColors.accent,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: PortfolioColors.background,
                ),
              ),
            ),
            connectorBuilder: (_, __, ___) => const SolidLineConnector(
              color: PortfolioColors.accent,
              thickness: 2,
            ),
            contentsBuilder: (context, index) => ScrollReveal(
              delay: Duration(milliseconds: 100 * index),
              horizontal: !widget.isPortrait && !isMobile,
              child: _TimelineCard(
                title: history[index].title,
                descriptions: history[index].description,
                range: history[index].range,
                isMobile: isMobile || widget.isPortrait,
              ),
            ),
            oppositeContentsBuilder: (context, index) {
              if (widget.isPortrait || isMobile) return const SizedBox.shrink();
              return ScrollReveal(
                delay: Duration(milliseconds: 100 * index + 50),
                horizontal: true,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, top: 24),
                  child: Text(
                    history[index].range,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontFamily: 'Quicksand',
                      color: PortfolioColors.textSecondary,
                      fontSize: 14,
                      fontVariations: [FontVariation('wght', 500)],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({
    required this.title,
    required this.descriptions,
    required this.range,
    required this.isMobile,
  });

  final String title;
  final List<String> descriptions;
  final String range;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: isMobile ? 8 : 24,
        right: isMobile ? 8 : 24,
        bottom: 24,
      ),
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: PortfolioColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: PortfolioColors.accent.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: PortfolioTextStyles.cardTitle.copyWith(
              fontSize: isMobile ? 18 : 22,
            ),
          ),
          if (isMobile) ...[
            const SizedBox(height: 6),
            Text(
              range,
              style: const TextStyle(
                fontFamily: 'Quicksand',
                color: PortfolioColors.accent,
                fontSize: 13,
                fontVariations: [FontVariation('wght', 500)],
              ),
            ),
          ],
          const SizedBox(height: 12),
          for (final description in descriptions)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6, right: 8),
                    child: Icon(
                      Icons.circle,
                      size: 8,
                      color: PortfolioColors.accent,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      description,
                      style: PortfolioTextStyles.body.copyWith(
                        fontSize: isMobile ? 14 : 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
