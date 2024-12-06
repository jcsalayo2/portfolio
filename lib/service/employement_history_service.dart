import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:portfolio/model/employement_history_model.dart';

class EmployementHistoryService {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('employementHistory');

  final storage = FirebaseStorage.instance;

  Future<List<EmployementHistory>> getEmploymentHistory() async {
    var qSnapShot = await products.get();
    var history = qSnapShot.docs.map((doc) {
      Object? response = doc.data();
      return EmployementHistory.fromJson(response as Map<String, dynamic>);
    }).toList();
    history.sort((a, b) => a.order.compareTo(b.order));
    return history;
  }
}
