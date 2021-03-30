import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:queen_ott_app/services/authentication_service.dart';
import 'package:queen_ott_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class TestCRUDScreen extends StatefulWidget {
  @override
  _TestCRUDScreenState createState() => _TestCRUDScreenState();
}

class _TestCRUDScreenState extends State<TestCRUDScreen> {
  // Creating the instance of FirebaseFirestore
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  DocumentReference docRef;
  var doc;

  Future<void> initiateSnapShots() async{
    var _email = context.read<AuthenticationService>().returnCurrentEmailId();
    docRef = _firebaseFirestore
        .collection("Series")
        .doc(_email)
        .collection("Series name")
        .doc("Series 2");
    doc =  docRef.snapshots().map((event) => ["Episodes"]);
    print(doc);
    setState(() {
    });
  }

  @override
  void initState() {
    initiateSnapShots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: CustomButton(
              color: Colors.blueGrey,
              text: 'Add new data',
              onTap: () async{
              },
            ),
          ),
        ),
      ),
    );
  }
}
