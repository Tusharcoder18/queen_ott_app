import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class UploadService extends ChangeNotifier {

  UploadService(this._firebaseFirestore);

  final FirebaseFirestore _firebaseFirestore;

  CollectionReference videoInfo = FirebaseFirestore.instance.collection("VideoInfo");
  final Reference ref = FirebaseStorage.instance.ref().child("videos");
  String downloadUrl;

  Future<String> uploadVideo({File video, String name}) async {
    try {
      UploadTask uploadTask = ref.child(name).putFile(video);
      TaskSnapshot snapshot = (await uploadTask);
      downloadUrl = (await snapshot.ref.getDownloadURL());
      uploadVideoInfo();
    } catch (e) {
      print(e);
    }

    return downloadUrl;
  }

  // Info of all the video to be updated

  String _videoTitle;
  String _videoDescription;
  String _videoGenre;

  void getVideoTitle(String videoTitle){
    _videoTitle = videoTitle;
    notifyListeners();
  }

  void getVideoDescription(String videoDescription){
    _videoDescription = videoDescription;
    notifyListeners();
  }

  void getVideoGenre(String videoGenre){
    _videoGenre = videoGenre;
    notifyListeners();
  }

  void uploadVideoInfo() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String date = formatter.format(now);
    formatter = DateFormat('HH-mm-ss');
    String time = formatter.format(now);

    videoInfo
        .add({
          'title': _videoTitle??'',
          'decription': _videoDescription??'',
          'genre': _videoGenre??'',
          'date': date,
          'time': time,
          'downloadUrl': downloadUrl,
        })
        .then((value) => print("Data added to firebase!"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  String returnVideoTitle(){
    return _videoTitle;
  }

  String returnVideoDescription(){
    if(_videoDescription != null)
      return _videoDescription;
    else return '';
  }
}
