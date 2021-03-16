import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/authentication_service.dart';

class UploadService extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore;
  UploadService(this._firebaseFirestore);

  CollectionReference videoInfo =
      FirebaseFirestore.instance.collection("VideoInfo");
  final Reference videoRef = FirebaseStorage.instance.ref().child("videos");
  final Reference thumbnailRef =
      FirebaseStorage.instance.ref().child("thumbnails");
  String videoUrl;
  String thumbnailUrl;
  final List<String> vUrls = [];
  final List<String> tUrls = [];
  bool isLoading = false;

  Future<void> showMyDialog(BuildContext context, UploadTask uploadTask) async {
    print("Show Dialog called");
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      // ignore: missing_return
      builder: (BuildContext context) {
        if (uploadTask != null) {
          return StreamBuilder<TaskSnapshot>(
              stream: uploadTask.snapshotEvents,
              builder: (context, snapshot) {
                var event = snapshot?.data;

                double progressPercent = event != null
                    ? event.bytesTransferred / event.totalBytes
                    : 0;

                return AlertDialog(
                  title: Text('Upload Progress'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${(progressPercent * 100).toStringAsFixed(2)} %'),
                      SizedBox(
                        height: 3.0,
                      ),
                      LinearProgressIndicator(
                        value: progressPercent,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        } else {
          return AlertDialog(
            title: Text('Upload Progress'),
            content: Text('Upload Done!'),
            actions: <Widget>[
              TextButton(
                child: Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      },
    );
  }

  Future<List<String>> uploadVideo(BuildContext context,
      {File video, File thumbnail, String name, String genre}) async {
    try {
      UploadTask videoUploadTask = videoRef
          .child(name)
          .putFile(video, SettableMetadata(contentType: "video/MP4"));
      showMyDialog(context, videoUploadTask);

      TaskSnapshot videoSnapshot = (await videoUploadTask);
      videoUrl = (await videoSnapshot.ref.getDownloadURL());

      await uploadThumbnail(thumbnail: thumbnail);
      _videoGenre = genre;

      final uid = Provider.of<AuthenticationService>(context).currentUser.uid;

      uploadVideoInfo(uid);
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

  void uploadVideoInfo(String uid) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String date = formatter.format(now);
    formatter = DateFormat('HH-mm-ss');
    String time = formatter.format(now);

    videoInfo
        .add({
          'uploaderID': uid,
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

  Future<void> getCurrentUrls() async {
    if (vUrls.isEmpty) {
      final collection = await videoInfo.get();
      final List<DocumentSnapshot> documents = collection.docs;
      print('Documents are:');
      documents.forEach((element) {
        vUrls.add(element.data()['videoUrl'].toString());
        tUrls.add(element.data()['thumbnailUrl'].toString());
        // print(element.data()['videoUrl']);
        // print(element.data()['thumbnailUrl']);
      });
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

  String returnVideoTitle() {
    return _videoTitle;
  }

  String returnVideoDescription() {
    if (_videoDescription != null)
      return _videoDescription;
    else
      return '';
  }

  List<String> returnVideoUrls() {
    return vUrls;
  }

  List<String> returnThumbnailUrls() {
    return tUrls;
  }

  void videoInfoNull() {
    this._videoGenre = null;
    this._videoDescription = null;
    this._videoTitle = null;
    notifyListeners();
  }
}
