import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class Test extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;

  Test({this.videoUrl, this.thumbnailUrl});

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Icon(_controller.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow)),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _controller.seekTo(Duration.zero);
                setState(() {
                });
              },
              child: Icon(Icons.replay),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
