import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddSeriesServices extends ChangeNotifier {
  AddSeriesServices(this._firebaseFirestore);

  final FirebaseFirestore _firebaseFirestore;

  /// To get the current Email Id
  String _email;

  void getEmailId({String email}) {
    _email = email;
  }

  String returnEmailId() {
    return _email;
  }

  /// End of the function to get the current Email Id

  /// TO add a series in the firebase
  Future<void> addNewSeries({String seriesName}) async {
    try {
      _firebaseFirestore
          .collection("Series")
          .doc(_email)
          .collection("Series name")
          .doc(seriesName)
          .set({
        "seriesName": seriesName,
        "Episodes": [],
      });
    } catch (e) {
      print(e);
    }
  }

  /// End of to add a series in the firebase

  int seriesLength;
  List<String> _seriesList = [];

  /// To get the information about the series of a given email id
  Future<void> getSeriesInfo() async {
    try {
      var temp = await _firebaseFirestore
          .collection("Series")
          .doc(_email)
          .collection("Series name")
          .get();
      final List<DocumentSnapshot> documents = temp.docs;
      _seriesList = [];
      //print("Documents are: ");
      documents.forEach((element) {
        _seriesList.add(element.data()["seriesName"].toString());
      });
      //print(_seriesList);
      seriesLength = _seriesList.length;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  List<String> returnSeriesInfoList() {
    return _seriesList;
  }

  /*
    For deleting an existing series
   */
  Future<void> deleteSeries({String inputText}) async {
    await _firebaseFirestore
        .collection("Series")
        .doc(_email)
        .collection("Series name")
        .doc(inputText)
        .delete();
    print("Deleted Successfully");
    notifyListeners();
  }

  List<dynamic> _episodeList;

  void justMakeEpisodeListNull() {
    _episodeList = [];
  }

  /// To get information about the episodes of given series
  Future<void> getEpisodeInfo({String seriesName}) async {
    justMakeEpisodeListNull();
    print("SeriesName : $seriesName");
    try {
      var document = _firebaseFirestore
          .collection("Series")
          .doc(_email)
          .collection("Series name")
          .doc(seriesName)
          .snapshots();
      document.forEach((element) {
        _episodeList = element.data()["Episodes"];
      });
      print("Series is :");
    } catch (e) {
      print(e);
      print("could not form a list, COULD NOT READ FROM THE DATABASE");
    }
  }

  ///
  dynamic returnEpisodeList() {
    return _episodeList;
  }

  /// This is only for testing purposes
  /// This is to get the path of the current video location
  /// trying to set a particular video location for each video
  Future<void> testing() async {
    String pathTemp;
    final temp = await _firebaseFirestore.collection("VideoInfo").get();
    final List<DocumentSnapshot> documents = temp.docs;
    documents.forEach((element) {
      if (element.data()["genre"] == "Animation") {
        pathTemp = element.data().hashCode.toString();
        print(element.id);
      }
    });
    print("PATH === $pathTemp");
  }

  /// To return the length of current series
  int returnSeriesListLength() {
    getSeriesInfo();
    return seriesLength;
  }

  int _episodeNumber;

  /// To get the current series number
  void getEpisodeNumber({int episodeNumber}) {
    _episodeNumber = episodeNumber;
  }

  int returnEpisodeNumber() {
    return _episodeNumber;
  }

  /// End of to get the current series number


/*
  TO add new season for the given series
   */
}
