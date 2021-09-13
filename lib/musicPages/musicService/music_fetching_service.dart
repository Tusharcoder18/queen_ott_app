import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MusicFetchingService extends ChangeNotifier {
  MusicFetchingService(this._firebaseFirestore);

  FirebaseFirestore _firebaseFirestore;

  List<List<String>> _musicList = [];
  List<List<String>> _musicThisWeekList = [];
  List<List<String>> _musicNewArrivalList = [];

  /// This function would return a List of List of String that contains
  /// the name of the song, image location for the song, music location for the
  /// song
  Future<List<List<String>>> getMusicInfo({String collectionName}) async {
    _musicList = [];
    _musicThisWeekList = [];
    _musicNewArrivalList = [];
    List<String> infoList = [];
    try {
      final collection =
          await _firebaseFirestore.collection(collectionName).get();
      final List<DocumentSnapshot> documents = collection.docs;
      documents.forEach((element) {
        infoList = [];
        infoList.add(element.data()["name"]); // gets the name of the
        infoList.add(element.data()["image"]);
        infoList.add(element.data()["file"]);
        if (element.data()["new"] == true) {
          _musicNewArrivalList.add(infoList);
        }
        if (element.data()["thisweek"] == true) {
          _musicThisWeekList.add(infoList);
        }
        _musicList.add(infoList);
      });
    } catch (e) {
      print(e);
      _musicList.add([]);
      _musicThisWeekList.add([]);
      _musicNewArrivalList.add([]);
    }
    return _musicList;
  }

  List<List<String>> returnNewArrivalList() {
    return _musicNewArrivalList;
  }

  List<List<String>> returnThisWeekList() {
    return _musicThisWeekList;
  }

  List<List<String>> returnMusicList() {
    return _musicList;
  }
}
