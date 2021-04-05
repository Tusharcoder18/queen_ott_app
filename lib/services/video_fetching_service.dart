import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideoFetchingService extends ChangeNotifier{

  VideoFetchingService(this._firebaseFirestore);

  FirebaseFirestore _firebaseFirestore;

  final String videoInfo = "VideoInfo";
  List<dynamic> _videoList = [];
  List<String> _videoThumbnail = [];
  List<String> _videoUrlList = [];
  List<String> _videoNameList = [];
  List<String> _videoDescriptionList = [];

  /// To fetch all the videos that are there in the database
  Future<void> fetchVideoList() async {
    _videoList = [];
    _videoThumbnail  = [];
    _videoUrlList = [];
    _videoNameList = [];
    _videoDescriptionList = [];
    final collection = await _firebaseFirestore.collection(videoInfo).get();
    final List<DocumentSnapshot> documents = collection.docs;

    documents.forEach((element) {
      _videoList.add(element.id.toString());
      _videoThumbnail.add(element.data()["thumbnailUrl"]);
      _videoUrlList.add(element.data()["videoUrl"]);
      _videoNameList.add(element.data()["title"]);
      _videoDescriptionList.add(element.data()["description"]);
    });

  }
  
  List<dynamic> returnVideoList(){
    return _videoList;
  }
  
  List<String> returnVideoThumbnail(){
    return _videoThumbnail;
  }

  List<String> returnVideoUrlList(){
    return _videoUrlList;
  }

  List<String> returnVideoNameList(){
    return _videoNameList;
  }

  List<String> returnVideoDescriptionList(){
    return _videoDescriptionList;
  }
  

}