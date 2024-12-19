import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:portfolio/model/employement_history_model.dart';
import 'package:portfolio/model/projects.dart';

import '../model/links.dart';

class LinksService {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('links');

  final storage = FirebaseStorage.instance;

  Future<List<Link>> getLinksProjects() async {
    var qSnapShot = await products.get();
    var history = qSnapShot.docs.map((doc) {
      Object? response = doc.data();
      return Link.fromJson(response as Map<String, dynamic>);
    }).toList();
    return history;
  }
}
