import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeriesFetchingService extends ChangeNotifier {
  SeriesFetchingService(this._firebaseFirestore);

  FirebaseFirestore _firebaseFirestore;

  final String consumerSeries = "ConsumerSeries";
  int _seriesLength = 0;
  List<dynamic> _seriesList = [];
  List<String> _seriesThumbnail = [];

  /// To fetch all the series that are there in the database
  Future<void> fetchSeriesList() async {
    _seriesList = [];
    _seriesThumbnail = [];
    final collection =
        await _firebaseFirestore.collection(consumerSeries).get();
    final List<DocumentSnapshot> documents = collection.docs;

    documents.forEach((element) async {
      final el = element.id.toString();
      _seriesList.add(el);
      _seriesThumbnail.add(element.data()["thumbnail"]);
    });

    print(_seriesList);
    print(_seriesThumbnail);
    print(documents);
  }

  /// returns the series List
  List<dynamic> returnSeriesList() {
    return _seriesList;
  }

  List<String> returnSeriesThumbnail() {
    return _seriesThumbnail;
  }

  List<dynamic> _seasonList = [];

  /// To get the number of seasons in a given series
  Future<void> getSeasonAndEpisodeInfo({String inputDocument}) async {
    _seasonList = [];
    final collection = await _firebaseFirestore
        .collection(consumerSeries)
        .doc(inputDocument)
        .collection("Seasons")
        .get();
    final List<DocumentSnapshot> documents = collection.docs;

    documents.forEach((element) {
      _seasonList.add(element.data()["Episodes"]);
    });

    print(_seasonList);
  }

  List<dynamic> returnSeasonAndEpisodeInfo() {
    return _seasonList;
  }

  String videoUrl = "";

  /// To return the video URL to the user
  Future<String> getUrl({String videoDocument}) async {
    videoUrl = "";
    final collection = await _firebaseFirestore
        .collection("SeriesVideoInfo")
        .doc(videoDocument)
        .get();

    videoUrl = collection.data()["videoUrl"];

    return videoUrl;
  }

  String _seriesName = "";

  /// To fetch the given series name based on the given documentName
  Future<String> getSeriesName({String documentName}) async {
    _seriesName = "";
    final document = await _firebaseFirestore
        .collection(consumerSeries)
        .doc(documentName)
        .get();
    _seriesName = document.data()["SeriesName"];

    return _seriesName;
  }

  /// To fetch the series description
  /// Here the series description is just the first episode description
  String _seriesDescription = "";
  Future<String> getSeriesDescription({String documentName}) async {
    _seriesDescription = "";
    try {
      final document = await _firebaseFirestore
          .collection("SeriesVideoInfo")
          .doc(documentName)
          .get();
      _seriesDescription = document.data()["description"];
    } catch (e) {
      print(e.message);
    }

    return _seriesDescription;
  }
}
