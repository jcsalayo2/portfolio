import 'package:flutter/material.dart';
import 'package:portfolio/model/skill_model.dart';
import 'package:portfolio/service/skill_service.dart';

class Skills extends StatelessWidget {
  const Skills({
    super.key,
    required this.isPortrait,
    required this.width,
  });

  final bool isPortrait;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Skills",
          style: TextStyle(
              fontSize: 36,
              color: Colors.amber,
              fontFamily: 'PlayFair',
              fontVariations: [FontVariation('wght', 800)]),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: isPortrait ? 0 : width * 0.1),
          child: Center(
            child: FutureBuilder<List<Skill>>(
                future: SkillService().getSkills(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Container();
                  }
                  return Wrap(
                    children: snapshot.data!
                        .map(
                          (e) =>
                              // SkillContainer(),
                              Container(
                            margin: EdgeInsets.only(bottom: 15),
                            height: 200,
                            width: 200,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.amber, width: 2)),
                                  child: Image.network(
                                    e.asset,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(e.name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: "Quicksand")),
                                Text(
                                    "${e.years} ${e.years > 1 ? "YEARS" : "YEAR"}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: "Quicksand")),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
