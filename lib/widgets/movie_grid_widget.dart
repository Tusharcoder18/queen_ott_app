import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/models/video.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:queen_ott_app/services/video_fetching_service.dart';

class MovieGridWidget extends StatefulWidget {
  MovieGridWidget({
    this.physics,
    this.videos,
  });

  final List<Video> videos;
  final ScrollPhysics physics;

  @override
  _MovieGridWidgetState createState() => _MovieGridWidgetState();
}

class _MovieGridWidgetState extends State<MovieGridWidget> {
  List<Video> gridContents = [];

  @override
  void initState() {
    super.initState();
    // gridContents = widget.videos;
    context.read<VideoFetchingService>().fetchVideoList().whenComplete(() {
      setState(() {
        gridContents = context.read<VideoFetchingService>().getVideos();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.2,
      width: screenWidth,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: gridContents.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                print(gridContents[index].getVideoUrl());
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Test(
                    videoUrl: gridContents[index].getVideoUrl(),
                    thumbnailUrl: gridContents[index].getVideoThumbnail(),
                  );
                }));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.pink),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    gridContents[index].getVideoThumbnail(),
                    fit: BoxFit.cover,
                    height: screenHeight * 0.20,
                    width: screenWidth * 0.30,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
