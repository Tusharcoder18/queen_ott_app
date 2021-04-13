import 'package:flutter/material.dart';
import 'package:queen_ott_app/models/video.dart';
import 'package:queen_ott_app/services/video_fetching_service.dart';
import 'package:queen_ott_app/widgets/banner_widget.dart';
import 'package:queen_ott_app/widgets/image_carousel_widget.dart';
import 'package:queen_ott_app/widgets/movie_grid_widget.dart';
import 'package:queen_ott_app/widgets/video_grid_widget.dart';
import 'package:queen_ott_app/services/video_fetching_service.dart';
import 'package:provider/provider.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  List<Video> _videos;
  // List<String> _videoThumbnailList = [];
  // List<dynamic> _videoList = [];
  // List<String> _videoUrlList = [];
  // List<String> _videoNameList = [];
  // List<String> _videoDescriptionList = [];

  // Future<void> getInformation() async {
  //   await context.read<VideoFetchingService>().fetchVideoList();
  Future<void> getInformation() async {
    await context.read<VideoFetchingService>().fetchVideoList().then((
        value) async {
      await context.read<VideoFetchingService>().fetchAllGenre();
    });
  }

  //   _videoThumbnailList =
  //       context.read<VideoFetchingService>().returnVideoThumbnail();
  //   _videoList = context.read<VideoFetchingService>().returnVideoList();
  //   _videoUrlList = context.read<VideoFetchingService>().returnVideoUrlList();
  //   _videoNameList = context.read<VideoFetchingService>().returnVideoNameList();
  //   _videoDescriptionList =
  //       context.read<VideoFetchingService>().returnVideoDescriptionList();

  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getInformation();
  // }

  @override
  void initState() {
    super.initState();

    context.read<VideoFetchingService>().fetchVideoList().whenComplete(() {
      _videos = context.read<VideoFetchingService>().getVideos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    List<String> banners = [
      'assets/movieTwo.jpg',
      'assets/moviePoster.jpg',
      'assets/movieOne.jpg',
    ];
    List<String> titles = [
      'Award Winning Movies',
      'Best of 90s',
      'Blockbusters',
    ];
    return ListView(
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        Container(
          height: screenHeight * 0.2,
          width: screenWidth,
          color: Colors.pink,
          child: ImageCarousel(),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: titles.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        titles[index],
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    MovieGridWidget(
                      physics: NeverScrollableScrollPhysics(),
                    ),
                    BannerWidget(
                      banners[index],
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
