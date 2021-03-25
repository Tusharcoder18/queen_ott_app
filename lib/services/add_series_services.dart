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
  Future<void> addNewSeries({String seriesName, String seriesList}) async {
    try {
      _firebaseFirestore
          .collection("Series")
          .doc(_email)
          .collection("Series name")
          .doc(seriesList)
          .set({"seriesName": seriesName}).then(
              (value) => print("// Series Added \\\\"));
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
      return _seriesList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  List<String> returnSeriesInfoList() {
    return _seriesList;
  }

  /// To get information about the episodes of given series
  Future<List<dynamic>> getEpisodeInfo(
      {int episodeNumber, int indexNumber}) async {
    print("Episode number : $episodeNumber ");
    print("index Number : $indexNumber");
    try {
      var temp = await _firebaseFirestore
          .collection("Series")
          .doc(_email)
          .collection("Series name")
          .doc("Series $episodeNumber")
          .collection("Episodes")
          .doc("episode$indexNumber")
          .get();
      List<dynamic> _episodeList = temp.data()["episodeName"];
      print("Series is :");
      print(_episodeList);
      return _episodeList;
    } catch (e) {
      print(e);
      print("could not form a list, COULD NOT READ FROM THE DATABASE");
      return [];
    }
  }

  /// To return the length of current series
  int returnSeriesListLength() {
    getSeriesInfo();
    return seriesLength;
  }

  int _episodeNumber;
  /// To get the current series number
  void getEpisodeNumber({int episodeNumber}){
    _episodeNumber = episodeNumber;
  }

  int returnEpisodeNumber(){
    return _episodeNumber;
  }

  /// End of to get the current series number
}
