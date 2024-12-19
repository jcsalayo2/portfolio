import 'package:flutter/material.dart';
import 'package:portfolio/model/employement_history_model.dart';
import 'package:portfolio/service/employement_history_service.dart';
import 'package:timelines_plus/timelines_plus.dart';

class EmployementHistoryTimeline extends StatelessWidget {
  const EmployementHistoryTimeline({
    super.key,
    required this.isPortrait,
  });

  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EmployementHistory>>(
        future: EmployementHistoryService().getEmploymentHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }
          return Timeline.tileBuilder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            theme: TimelineThemeData(
              color: Colors.amber,
              nodePosition: isPortrait ? 0.2 : null,
            ),
            builder: TimelineTileBuilder.fromStyle(
              indicatorStyle: IndicatorStyle.outlined,
              contentsAlign:
                  isPortrait ? ContentsAlign.basic : ContentsAlign.alternating,
              contentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data![index].title,
                      style: const TextStyle(
                          color: Colors.amber,
                          fontFamily: "PlayFair",
                          fontSize: 22),
                    ),
                    for (var description
                        in snapshot.data![index].description) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 6, right: 5),
                            child: Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.amber,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              softWrap: true,
                              description,
                              style: const TextStyle(
                                  fontFamily: "Quicksand",
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
              oppositeContentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  snapshot.data![index].range,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              itemCount: snapshot.data!.length,
            ),
          );
        });
  }
}
