import 'package:flutter/material.dart';
import 'package:queen_ott_app/screens/upload_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:chewie/chewie.dart';

class Test extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;

  Test({this.videoUrl, this.thumbnailUrl});

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  ChewieController _chewieController;
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.network(widget.videoUrl), //'assets/nature.mp4')'assets/nature.mp4'),
        aspectRatio: 19.9 / 9,
        autoInitialize: false,
        autoPlay: true,
        looping: false,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.white,
          backgroundColor: Colors.grey,
          handleColor: Colors.white,
          bufferedColor: Colors.grey,
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
            ),
          );
        });
    _controller = VideoPlayerController.asset(widget.videoUrl) //'assets/nature.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  bool isShow = false;

  void showContainer() {
    if (isShow) {
      isShow = false;
    } else {
      isShow = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    //MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    // : SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return SafeArea(
      top:
          MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
              ? true
              : false,
      child: WillPopScope(
        onWillPop: () async{
          _chewieController.pause();
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          Navigator.pop(context);
          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>UploadScreen()), (Route<dynamic>route) => false);
          return false;
        },
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Chewie(
              controller: _chewieController,
            ),
          ),
        ),
      ),
    );
  }

  // To dispose the controller
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}
