import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideoFetchingService extends ChangeNotifier{

  VideoFetchingService(this._firebaseFirestore);

  FirebaseFirestore _firebaseFirestore;

  List<dynamic> _videoList = [];

  /// This is to fetch the video

}