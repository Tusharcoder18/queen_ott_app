import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class UploadService extends ChangeNotifier {
  UploadService(this._firebaseFirestore);

  final FirebaseFirestore _firebaseFirestore;

  CollectionReference videoInfo =
      FirebaseFirestore.instance.collection("VideoInfo");
  final Reference videoRef = FirebaseStorage.instance.ref().child("videos");
  final Reference thumbnailRef =
      FirebaseStorage.instance.ref().child("thumbnails");
  String videoUrl;
  String thumbnailUrl;

  Future<List<String>> uploadVideo(
      {File video, File thumbnail, String name}) async {
    try {
      UploadTask videoUploadTask = videoRef
          .child(name)
          .putFile(video, SettableMetadata(contentType: "video/MP4"));
      TaskSnapshot videoSnapshot = (await videoUploadTask);
      videoUrl = (await videoSnapshot.ref.getDownloadURL());
      await uploadThumbnail(thumbnail: thumbnail);
      uploadVideoInfo();
    } catch (e) {
      print(e);
    }

    return [videoUrl, thumbnailUrl];
  }

  Future<void> uploadThumbnail({File thumbnail}) async {
    try {
      UploadTask thumbnailUploadTask = thumbnailRef
          .child("image1")
          .putFile(thumbnail, SettableMetadata(contentType: "image/jpeg"));
      TaskSnapshot thumbnailSnapshot = (await thumbnailUploadTask);
      thumbnailUrl = (await thumbnailSnapshot.ref.getDownloadURL());
    } catch (e) {
      print(e);
    }
  }

  // Info of all the video to be updated

  String _videoTitle;
  String _videoDescription;
  String _videoGenre;

  void getVideoTitle(String videoTitle) {
    _videoTitle = videoTitle;
    notifyListeners();
  }

  void getVideoDescription(String videoDescription) {
    _videoDescription = videoDescription;
    notifyListeners();
  }

  void getVideoGenre(String videoGenre) {
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
          'title': _videoTitle ?? '',
          'decription': _videoDescription ?? '',
          'genre': _videoGenre ?? '',
          'date': date,
          'time': time,
          'videoUrl': videoUrl,
          'thumbnailUrl': thumbnailUrl,
        })
        .then((value) => print("Data added to firebase!"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  String returnVideoTitle() {
    return _videoTitle;
  }

  String returnVideoDescription() {
    if (_videoDescription != null)
      return _videoDescription;
    else
      return '';
  }

  void videoInfoNull() {
    this._videoGenre = null;
    this._videoDescription = null;
    this._videoTitle = null;
    notifyListeners();
  }
}
