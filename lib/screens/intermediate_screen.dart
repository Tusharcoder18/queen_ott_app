import 'package:flutter/material.dart';
import 'package:queen_ott_app/screens/content_creator_screen.dart';
import 'package:queen_ott_app/screens/user_home_screen.dart';

class InterMediateScreen extends StatelessWidget {
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
                color: Colors.red,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              // This Container is for the stream video
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.red,
                child: Center(
                  child: Text(
                    'STREAM VIDEOS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              onTap: () {
                // This should go to the home page for the person who wants to watch just videos
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.red,
                child: Center(
                  child: Text(
                    'UPLOAD VIDEOS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              onTap: () {
                // This should take the user to the screen to upload videos
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContentCreatorScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
