import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class UploadService {
  CollectionReference videoInfo =
      FirebaseFirestore.instance.collection("VideoInfo");
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

  void uploadVideoInfo() {
    // DateTime now = new DateTime.now();
    // DateTime date = new DateTime(now.day, now.month, now.year);
    // DateTime time = new DateTime(now.hour, now.minute);
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String date = formatter.format(now);
    formatter = DateFormat('HH-mm-ss');
    String time = formatter.format(now);

    videoInfo
        .add({
          'title': 'Title of the video',
          'decription': 'Description of the video',
          'genre': 'video genre',
          'date': date,
          'time': time,
          'downloadUrl': downloadUrl,
        })
        .then((value) => print("Data added to firebase!"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
