import 'package:flutter/material.dart';
import 'package:queen_ott_app/models/series.dart';
import 'package:queen_ott_app/models/video.dart';
import 'package:queen_ott_app/screens/series_details_screen.dart';
import 'package:queen_ott_app/screens/test.dart';

class VideoGridWidget extends StatefulWidget {
  VideoGridWidget({
    this.isVideo,
    this.isSeries,
    this.physics,
    this.videos,
    this.series,
    // this.isSearchGrid,
    // this.videoThumbnailList,
    // this.videoUrlList,
    // this.seriesList,
    // this.seriesThumbnailList,
  });

  final List<Video> videos;
  final List<Series> series;
  final bool isVideo;
  final bool isSeries;
  final ScrollPhysics physics;

  // This is temporary to show results for search functionality
  // final bool isSearchGrid;
  // final List<String> videoThumbnailList;
  // final List<String> videoUrlList;
  // final List<dynamic> seriesList;
  // final List<String> seriesThumbnailList;

  @override
  _VideoGridWidgetState createState() => _VideoGridWidgetState();
}

class _VideoGridWidgetState extends State<VideoGridWidget> {
  List gridContents = [];

  // List<String> _videoThumbnailList = [];
  // List<dynamic> _videoList = [];
  // List<String> _videoUrlList = [];
  // List<String> _videoNameList = [];
  // List<String> _videoDescriptionList = [];
  // List<String> _seriesThumbnailList = [];
  // List<dynamic> _seriesList = [];

  // Future<void> fetchVideos() async {
  //   await context.read<VideoFetchingService>().fetchVideoList();

  //   _videoThumbnailList =
  //       context.read<VideoFetchingService>().returnVideoThumbnail();
  //   _videoList = context.read<VideoFetchingService>().returnVideoList();
  //   _videoUrlList = context.read<VideoFetchingService>().returnVideoUrlList();
  //   _videoNameList = context.read<VideoFetchingService>().returnVideoNameList();
  //   _videoDescriptionList =
  //       context.read<VideoFetchingService>().returnVideoDescriptionList();

  //   setState(() {});
  // }

  // Future<void> fetchSeries() async {
  //   await context.read<SeriesFetchingService>().fetchSeriesList();
  //   _seriesThumbnailList =
  //       context.read<SeriesFetchingService>().returnSeriesThumbnail();
  //   _seriesList = context.read<SeriesFetchingService>().returnSeriesList();
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    // try {
    //   if (widget.isSearchGrid == null || widget.isSearchGrid == false) {
    //     fetchVideos();
    //     fetchSeries();
    //   } else {
    //     _videoThumbnailList = widget.videoThumbnailList;
    //     _videoUrlList = widget.videoUrlList;
    //     _seriesList = widget.seriesList;
    //     _seriesThumbnailList = widget.seriesThumbnailList;
    //     print(_videoThumbnailList);
    //     print(_videoUrlList);
    //   }
    // } catch (e) {
    //   print(e);
    // }
    // gridContents = widget.videos;
    // gridContents.forEach((element) {
    //   print(element.getVideoTitle());
    // });
    if (widget.isVideo) {
      print('video');
      gridContents = <Video>[];
      gridContents = widget.videos;
      print(gridContents.length);
    } else if (widget.isSeries) {
      print('series');
      gridContents = <Series>[];
      gridContents = widget.series;
      print(gridContents.length);
    }
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
              // if (!widget.isMovie)
              //   await context
              //       .read<SeriesFetchingService>()
              //       .getSeasonAndEpisodeInfo(inputDocument: _seriesList[index]);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    if (widget.isVideo) {
                      return Test(
                        videoUrl: gridContents[index].getVideoUrl(),
                        thumbnailUrl: gridContents[index].getVideoThumbnail(),
                      );
                    } else if (widget.isSeries) {
                      return SeriesDetailScreen(gridContents[index]);
                    }
                  },
                ),
              );
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
                          widget.isVideo
                              ? gridContents[index].getVideoThumbnail()
                              : gridContents[index].getSeriesThumbnail(),
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
