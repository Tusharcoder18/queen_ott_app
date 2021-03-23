import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  /// To fetch a series from the firebase
  Future<void> getSeries() async{
    try{
      print(_firebaseFirestore.collection("Series").doc(_email).get());
    } catch (e){
      print(e);
    }
  }
  /// End of fetching a series from the firebase
}