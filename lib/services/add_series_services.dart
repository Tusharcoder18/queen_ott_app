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
    String _consumerId = "";
    try {
      _firebaseFirestore
          .collection("Series")
          .doc(_email)
          .collection("Series name")
          .doc(seriesName)
          .set({
        "seriesName": seriesName,
        "ConsumerID": "",
      }).then((value) {
        _firebaseFirestore
            .collection("Series")
            .doc(_email)
            .collection("Series name")
            .doc(seriesName)
            .collection("Episodes")
            .doc("Episode1")
            .set({"Episode": []});
      }).then((value) {
        _firebaseFirestore.collection("ConsumerSeries").add({
          "SeriesName": seriesName,
          "emailID": _email,
          "thumbnail": "",
        });
      }).then((value) async {
        final collection =
            await _firebaseFirestore.collection("ConsumerSeries").get();
        final List<DocumentSnapshot> _document = collection.docs;

        _document.forEach((element) {
          if ((element.data()["emailID"] == _email) &&
              (element.data()["SeriesName"] == seriesName)) {
            print("If condition is called \n\n\n");
            _consumerId = element.id.toString();
            print(_consumerId);
          }
        });
      }).then((value) {
        print("updating function is called");
        _firebaseFirestore
            .collection("Series")
            .doc(_email)
            .collection("Series name")
            .doc(seriesName)
            .update({
          "ConsumerID": _consumerId,
        });
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
    final collection = await _firebaseFirestore
        .collection("Series")
        .doc(_email)
        .collection("Series name")
        .doc(inputText)
        .get();
    final String _consumerID = collection.data()["ConsumerID"].toString();

    print(_consumerID);

    await _firebaseFirestore
        .collection("ConsumerSeries")
        .doc(_consumerID)
        .delete()
        .then((value) async {
      await _firebaseFirestore
          .collection("Series")
          .doc(_email)
          .collection("Series name")
          .doc(inputText)
          .delete();
      print("Deleted Successfully");
    });
    notifyListeners();
  }

  List<dynamic> _episodeList;
  String _currentSeries = "";

  void justMakeEpisodeListNull() {
    _episodeList = [];
  }

  /// To get information about the episodes of given series
  Future<void> getEpisodeInfo({String seriesName}) async {
    justMakeEpisodeListNull();
    print("SeriesName : $seriesName");
    _currentSeries = seriesName;
    try {
      var collection = await _firebaseFirestore
          .collection("Series")
          .doc(_email)
          .collection("Series name")
          .doc(seriesName)
          .collection("Episodes")
          .get();

      final List<DocumentSnapshot> documents = collection.docs;

      documents.forEach((element) {
        _episodeList.add(element.data()["Episode"]);
      });
    } catch (e) {
      print(e);
      print("could not form a list, COULD NOT READ FROM THE DATABASE");
    }
  }

  /// Returns list of episodes in a given series
  dynamic returnEpisodeList() {
    return _episodeList;
  }

  /// To add new season in a given series
  void addNewSeason({int length}) {
    _firebaseFirestore
        .collection("Series")
        .doc(_email)
        .collection("Series name")
        .doc(_currentSeries)
        .collection("Episodes")
        .doc("Episode$length")
        .set({"Episode": []}).then((value) => print("Added new season"));
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
