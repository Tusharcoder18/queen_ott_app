import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Test extends StatelessWidget {
  final String videoUrl;
  final String thumbnailUrl;
  Test({this.videoUrl, this.thumbnailUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                launch(videoUrl);
              },
              child: Text("Play Video"),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                launch(thumbnailUrl);
              },
              child: Text("Show thumbnail"),
            ),
          ],
        ),
      ),
    );
  }
}
