import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/add_series_services.dart';
import 'package:queen_ott_app/services/authentication_service.dart';
import 'package:queen_ott_app/services/upload_service.dart';
import 'package:provider/provider.dart';

import 'sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 5 /*5*/), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => SignInScreen(),
          ),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUSer = context.watch<User>();

    if(firebaseUSer != null){
      Provider.of<UploadService>(context, listen: false).getEmailID(
          emailId: Provider.of<AuthenticationService>(context, listen: false).returnCurrentEmailId()
      );
      Provider.of<AddSeriesServices>(context, listen: false).getEmailId(
          email: Provider.of<AuthenticationService>(context, listen: false).returnCurrentEmailId()
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200.0,
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: 30.0,
            ),
            Container(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
