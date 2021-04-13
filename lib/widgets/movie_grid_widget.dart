import 'package:flutter/material.dart';
import 'package:queen_ott_app/models/series.dart';
import 'package:queen_ott_app/models/video.dart';
import 'package:queen_ott_app/screens/series_details_screen.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';
import 'package:queen_ott_app/services/video_fetching_service.dart';
import 'package:provider/provider.dart';

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
      height: screenHeight * 0.42,
      child: GridView.count(
        // Creates a 2 row scrollable listview
        crossAxisCount: 3,
        physics: widget.physics,
        childAspectRatio: 0.8,
        children: List.generate(gridContents.length, (index) {
          return GestureDetector(
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Test(
                  videoUrl: gridContents[index].getVideoUrl(),
                  thumbnailUrl: gridContents[index].getVideoThumbnail(),
                );
              }));
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: screenWidth * 0.37,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.pink),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          gridContents[index].getVideoThumbnail(),
                          fit: BoxFit.cover,
                          height: screenWidth * 0.54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
