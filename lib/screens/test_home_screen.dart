import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/authentication_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HOME"),
            RaisedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
                context.read<AuthenticationService>().signOutGoogle();
                context.read<AuthenticationService>().signOutFacebook();
              },
              child: Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }
}
