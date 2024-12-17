import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:portfolio/model/employement_history_model.dart';
import 'package:portfolio/model/projects.dart';

class PreviousProjectsService {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('previousProjects');

  final storage = FirebaseStorage.instance;

  Future<List<Project>> getPreviousProjects() async {
    var qSnapShot = await products.get();
    var history = qSnapShot.docs.map((doc) {
      Object? response = doc.data();
      return Project.fromJson(response as Map<String, dynamic>);
    }).toList();
    history.sort((a, b) => a.order.compareTo(b.order));
    return history;
  }
}
