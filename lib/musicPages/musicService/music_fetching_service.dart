import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MusicFetchingService extends ChangeNotifier {
  MusicFetchingService(this._firebaseFirestore);

  FirebaseFirestore _firebaseFirestore;
}
