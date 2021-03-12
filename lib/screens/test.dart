import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class Test extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;
  Test({this.videoUrl, this.thumbnailUrl});

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  VideoPlayerController _controller;
  double videoDuration = 0;
  double currentValue;
  double totalDuration;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/nature.mp4')
      ..initialize().then((_) {
        setState(() {
          currentValue = _controller.value.position.inSeconds.toDouble();
          totalDuration = _controller.value.duration.inSeconds.toDouble();
        });
      });
  }

  double getCurrentDuration(){
    currentValue = _controller.value.position.inSeconds.toDouble();
    return currentValue;
  }

  double getTotalDuration(){
    totalDuration = _controller.value.duration.inSeconds.toDouble();
    if(totalDuration == 0)
        return 1;
    return totalDuration;
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]) : SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return SafeArea(
      top: MediaQuery.of(context).size.width < MediaQuery.of(context).size.height ? true : false,
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: _controller.value.isInitialized
                  ? Container(
                    height: MediaQuery.of(context).size.width < MediaQuery.of(context).size.height ? 250 : MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                  )
                  : Container(),
              ),
              Positioned(
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.width < MediaQuery.of(context).size.height ? 250 : MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: ElevatedButton(
                            onPressed: (){
                              print("play pressed");
                              print(_controller.value.position.inSeconds);
                              setState(() {
                                _controller.value.isPlaying ? _controller.pause() : _controller.play();
                              });
                            },
                            child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 30,
                            child: Slider(
                                activeColor: Colors.white,
                                inactiveColor: Colors.grey,
                                value: (getCurrentDuration()/getTotalDuration())*100 != null ? (getCurrentDuration()/getTotalDuration())*100 : 0,
                                onChanged: (double newValue){
                                  videoDuration = newValue;
                                  print(videoDuration);
                                  print(_controller.value.position);
                                  setState(() {
                                    _controller.seekTo(_controller.value.duration*(videoDuration/100));
                                  });
                                },
                                min: 0,
                                max: 100,
                                ),
                          ),
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: (){
                              videoDuration = 0;
                              _controller.seekTo(Duration.zero);
                              setState(() {
                              });
                            },
                            child: Icon(Icons.replay),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]
          ),
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
