import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/authentication_service.dart';

class AddSeriesServices extends ChangeNotifier{
  AddSeriesServices(this._firebaseFirestore);

  final FirebaseFirestore _firebaseFirestore;

  /// To get the current Email Id
  String _email;
  void getEmailId({String email}){
    _email = email;
  }

  String returnEmailId(){
    return _email;
  }

  /// End of the function to get the current Email Id

  /// TO add a series in the firebase
  Future<void> addNewSeries({String seriesName, String seriesList}) async{
    try{
      _firebaseFirestore.collection("Series").doc(_email).collection("Series name").doc(seriesList).set({
        "seriesName": seriesName
      }).then((value) => print("// Series Added \\\\"));
    } catch(e){
      print(e);
    }
  }
  /// End of to add a series in the firebase

  int seriesLength;
  List<String> _seriesList = [];
  /// Return a list of type string
  Future<void> getSeriesInfo() async{
    try{
      var temp =  await _firebaseFirestore.collection("Series").doc(_email).collection("Series name").get();
      final List<DocumentSnapshot> documents = temp.docs;
      int len = temp.docs.length;
      _seriesList = [];
      print("Documents are: ");
      documents.forEach((element) {
        _seriesList.add(element.data()["seriesName"].toString());
        print(element.data()["seriesName"]);
      });
      print(_seriesList);
      seriesLength = _seriesList.length;
      return _seriesList;
    } catch(e){
      print(e);
      return [];
    }
  }

  List<String> returnSeriesInfoList(){
    return _seriesList;
  }


  /// To return the length of current series
  int returnSeriesListLength(){
    getSeriesInfo();
    return seriesLength;
  }


}