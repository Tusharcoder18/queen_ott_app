import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeriesFetchingService extends ChangeNotifier {

  SeriesFetchingService(this._firebaseFirestore);
  FirebaseFirestore _firebaseFirestore;


  int _seriesLength = 0;
  List<dynamic> _seriesList = [];
  List<String> _seriesThumbnail = [];

  /// To fetch all the series that are there in the database
  Future<void> fetchSeriesList() async{
    _seriesList = [];
    _seriesThumbnail = [];
    final collection = await _firebaseFirestore.collection("ConsumerSeries").get();
    final List<DocumentSnapshot> documents = collection.docs;

    documents.forEach((element) async{
      final el =  element.id.toString();
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


}