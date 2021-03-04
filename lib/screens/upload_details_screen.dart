import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UploadDetailsPage extends StatelessWidget {
  final String videoUrl;
  UploadDetailsPage({this.videoUrl});

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
