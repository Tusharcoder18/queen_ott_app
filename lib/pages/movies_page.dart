import 'package:flutter/material.dart';
import 'package:queen_ott_app/widgets/banner_widget.dart';
import 'package:queen_ott_app/widgets/image_carousel_widget.dart';
import 'package:queen_ott_app/widgets/video_grid_widget.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  // List<String> _videoThumbnailList = [];
  // List<dynamic> _videoList = [];
  // List<String> _videoUrlList = [];
  // List<String> _videoNameList = [];
  // List<String> _videoDescriptionList = [];

  // Future<void> getInformation() async {
  //   await context.read<VideoFetchingService>().fetchVideoList();
  Future<void> getInformation() async{
    await context.read<VideoFetchingService>().fetchVideoList().then((value) async{
      await context.read<VideoFetchingService>().fetchAllGenre();
    });

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
                    VideoGridWidget(
                      isMovie: true,
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
    // return SingleChildScrollView(
    //   child: Container(
    //     width: screenWidth,
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text('Movies you may like'),
    //           SizedBox(height: 20,),
    //           MovieGridViewWidget(
    //             videoDescriptionList: _videoDescriptionList,
    //             videoList: _videoList,
    //             videoNameList: _videoNameList,
    //             videoThumbnailList: _videoThumbnailList,
    //             videoUrlList: _videoUrlList,
    //           ),
    //           SizedBox(height: 20,),
    //           Text('Action'),
    //           SizedBox(height: 20,),
    //           MovieGridViewWidget(
    //             videoDescriptionList: _videoDescriptionList,
    //             videoList: _videoList,
    //             videoNameList: _videoNameList,
    //             videoThumbnailList: _videoThumbnailList,
    //             videoUrlList: _videoUrlList,
    //           ),
    //           SizedBox(height: 20,),
    //           Text('Drama'),
    //           SizedBox(height: 20,),
    //           MovieGridViewWidget(
    //             videoDescriptionList: _videoDescriptionList,
    //             videoList: _videoList,
    //             videoNameList: _videoNameList,
    //             videoThumbnailList: _videoThumbnailList,
    //             videoUrlList: _videoUrlList,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
