import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Test extends StatelessWidget {
  final String videoUrl;
  Test({this.videoUrl});

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
          ],
        ),
      ),
    );
  }
}
