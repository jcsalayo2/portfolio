import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:portfolio/model/skill_model.dart';

class SkillService {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('skills');

  final storage = FirebaseStorage.instance.ref();

  Future<List<Skill>> getSkills() async {
    var qSnapShot = await products.get();
    var skills = qSnapShot.docs.map((doc) {
      Object? response = doc.data();
      return Skill.fromJson(response as Map<String, dynamic>);
    }).toList();
    skills.sort((a, b) => a.order.compareTo(b.order));
    for (var skill in skills) {
      skill.asset = await storage.child(skill.asset).getDownloadURL();
    }
    return skills;
  }
}
