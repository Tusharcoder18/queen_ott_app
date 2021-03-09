import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<String> uploadOnlyVideo(
      File video,
      ) async{
    try{
      UploadTask videoUploadTask = videoRef.child('VideoUpload').putFile(video, SettableMetadata(contentType: 'video/MP4'));

      TaskSnapshot videoSnapshots = await videoUploadTask;

      videoUrl = await videoSnapshots.ref.getDownloadURL();


      return videoUrl;
    } catch(e){
      print(e.message);
      return e.message;
    }
  }

  Future<List<String>> uploadVideo(
      {File video, File thumbnail, String name}) async {
    try {
      UploadTask videoUploadTask = videoRef
          .child(name)
          .putFile(video, SettableMetadata(contentType: "video/MP4"));
      UploadTask thumbnailUploadTask = thumbnailRef
          .child(name)
          .putFile(thumbnail, SettableMetadata(contentType: "image/jpeg"));
      TaskSnapshot videoSnapshot = (await videoUploadTask);
      TaskSnapshot thumbnailSnapshot = (await thumbnailUploadTask);
      videoUrl = (await videoSnapshot.ref.getDownloadURL());
      thumbnailUrl = (await thumbnailSnapshot.ref.getDownloadURL());
      uploadVideoInfo();

      return [videoUrl, thumbnailUrl];
    } catch (e) {
      print(e);
      return [];
    }

    return [videoUrl, thumbnailUrl];
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


  // This is to take the input for videoPlayer path and video Thumbnail

  String _videoPath;
  String _videoThumbnailPath;

  Future<String> getVideoPath() async{
    final file = await ImagePicker().getVideo(source: ImageSource.gallery);

    this._videoPath = File(file.path).toString();
    this._videoThumbnailPath = this._videoPath;

    notifyListeners();

    return _videoPath;
  }


}
