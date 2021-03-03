import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:queen_ott_app/screens/content_creator_screen.dart';
import 'package:queen_ott_app/screens/user_home_screen.dart';

class IntermediateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'QUEEN',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
                fontFamily: 'Roboto',
                fontSize: 25.0,
              ),
            ),
            Container(
              height: 50,
              child: Image.asset('assets/logo.png'),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              elevation: 0,
              minWidth: double.maxFinite,
              height: 100,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue[600]),
                  borderRadius: BorderRadius.circular(3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesomeIcons.laptop),
                  SizedBox(width: 10),
                  Text('Content Consumer',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
              textColor: Colors.white,
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              elevation: 0,
              minWidth: double.maxFinite,
              height: 100,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContentCreatorScreen()));
              },
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue[600]),
                  borderRadius: BorderRadius.circular(3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesomeIcons.creativeCommons),
                  SizedBox(width: 10),
                  Text('Content Creator',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
