import 'package:flutter/material.dart';
import 'package:queen_ott_app/screens/season_details_screen.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';
import 'package:queen_ott_app/services/video_fetching_service.dart';
import 'package:provider/provider.dart';

class VideoGridWidget extends StatefulWidget {
  VideoGridWidget({
    this.isMovie,
    this.physics,
  });

  final bool isMovie;
  final ScrollPhysics physics;

  @override
  _VideoGridWidgetState createState() => _VideoGridWidgetState();
}

class _VideoGridWidgetState extends State<VideoGridWidget> {
  List<String> _videoThumbnailList = [];
  List<dynamic> _videoList = [];
  List<String> _videoUrlList = [];
  List<String> _videoNameList = [];
  List<String> _videoDescriptionList = [];
  List<String> _seriesThumbnail = [];
  List<dynamic> _seriesList = [];

  Future<void> getInformation() async {
    await context.read<VideoFetchingService>().fetchVideoList();

    _videoThumbnailList =
        context.read<VideoFetchingService>().returnVideoThumbnail();
    _videoList = context.read<VideoFetchingService>().returnVideoList();
    _videoUrlList = context.read<VideoFetchingService>().returnVideoUrlList();
    _videoNameList = context.read<VideoFetchingService>().returnVideoNameList();
    _videoDescriptionList =
        context.read<VideoFetchingService>().returnVideoDescriptionList();

    setState(() {});
  }

  Future<void> fetchSeries() async {
    await context.read<SeriesFetchingService>().fetchSeriesList();
    _seriesThumbnail =
        context.read<SeriesFetchingService>().returnSeriesThumbnail();
    _seriesList = context.read<SeriesFetchingService>().returnSeriesList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    try {
      getInformation();
      fetchSeries();
    } catch (e) {
      print(e);
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
        children: List.generate(_videoThumbnailList.length, (index) {
          return GestureDetector(
            onTap: () async {
              await context
                  .read<SeriesFetchingService>()
                  .getSeasonAndEpisodeInfo(inputDocument: _seriesList[index]);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                if (widget.isMovie) {
                  return Test(
                    videoUrl: _videoUrlList[index],
                    thumbnailUrl: _videoThumbnailList[index],
                  );
                } else {
                  return SeasonDetailScreen(
                    videoThumbnail: _videoThumbnailList[index],
                    indexNumber: index,
                    consumerDocument: _seriesList[index].toString(),
                  );
                }
              }));
            },
            child: Container(
              // margin: EdgeInsets.all(5),
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
                          _videoThumbnailList[index],
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
