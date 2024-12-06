import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:portfolio/model/skill_model.dart';

class PortraitService {
  final storage = FirebaseStorage.instance.ref();

  final imageName = "me.png";

  Future<String> getPortrait() async {
    return await storage.child("portrait/$imageName").getDownloadURL();
  }
}
