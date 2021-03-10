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
  final Reference videoUploadRef = FirebaseStorage.instance.ref().child("videos");
  final Reference thumbnailUploadRef = FirebaseStorage.instance.ref().child('thumbnails');
  String videoDownloadUrl;
  String thumbnailDownloadUrl;

  Future<String> uploadVideo({File video, String name}) async {
    try {
      UploadTask uploadTask = videoUploadRef.child(name).putFile(video);
      TaskSnapshot snapshot = (await uploadTask);
      videoDownloadUrl = (await snapshot.ref.getDownloadURL());
      uploadVideoInfo();
    } catch (e) {
      print(e);
    }

    return videoDownloadUrl;
  }

  Future<String> uploadThumbnail({File video, String name}) async {
    try {
      UploadTask uploadTask = thumbnailUploadRef.child(name).putFile(video);
      TaskSnapshot snapshot = (await uploadTask);
      thumbnailDownloadUrl = (await snapshot.ref.getDownloadURL());
      uploadVideoInfo();
    } catch (e) {
      print(e);
    }

    return thumbnailDownloadUrl;
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
          'downloadUrl': videoDownloadUrl,
        })
        .then((value) => print("Data added to firebase!"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void makeVideoDescriptionNull(){
    this._videoDescription = null;
    notifyListeners();
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
