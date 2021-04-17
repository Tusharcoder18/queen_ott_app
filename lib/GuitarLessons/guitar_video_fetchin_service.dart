import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GuitarService extends ChangeNotifier {
  GuitarService(this._firebaseFirestore);

  FirebaseFirestore _firebaseFirestore;

  List<List<String>> _guitarLessonList = [];

  Future<List<List<String>>> returnLessonList() async {
    _guitarLessonList = [];

    try {
      final collection =
          await _firebaseFirestore.collection("GuitarLessons").get();
      final List<DocumentSnapshot> documents = collection.docs;

      documents.forEach(
        (element) {
          _guitarLessonList
              .add([element.data()["videoUrl"], element.data()["pdfUrl"]]);
        },
      );
    } catch (e) {
      print(e);
      _guitarLessonList.add([]);
    }

    return _guitarLessonList;
  }
}
