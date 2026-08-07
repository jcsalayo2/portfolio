import 'package:cloud_firestore/cloud_firestore.dart';

class StringsService {
  final CollectionReference strings =
      FirebaseFirestore.instance.collection('strings');

  Future<String> getAboutMe() async {
    final doc = await strings.doc('aboutMe').get();
    final data = doc.data() as Map<String, dynamic>?;
    return data?['description'] as String? ?? '';
  }
}
