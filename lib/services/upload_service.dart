import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class UploadService {
  final Reference ref = FirebaseStorage.instance.ref().child("videos");
  String downloadUrl;

  Future<String> uploadVideo({File video, String name}) async {
    try {
      UploadTask uploadTask = ref.child(name).putFile(video);
      TaskSnapshot snapshot = (await uploadTask);
      downloadUrl = (await snapshot.ref.getDownloadURL());
    } catch (e) {
      print(e);
    }

    return downloadUrl;
  }
}
