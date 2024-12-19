import 'package:flutter/material.dart';
import 'package:portfolio/model/skill_model.dart';

class SkillContainer extends StatelessWidget {
  const SkillContainer({
    super.key,
    required this.e,
  });

  final Skill e;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      height: 200,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            e.asset,
            height: 80,
          ),
          Text(e.name, style: const TextStyle(fontSize: 20)),
          Text("${e.years} year/s", style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
