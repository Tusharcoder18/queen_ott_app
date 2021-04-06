import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/video_fetching_service.dart';
import 'package:queen_ott_app/widgets/movie_grid_view_widget.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  List<String> _videoThumbnailList = [];
  List<dynamic> _videoList = [];
  List<String> _videoUrlList = [];
  List<String> _videoNameList = [];
  List<String> _videoDescriptionList = [];

  Future<void> getInformation() async{
    await context.read<VideoFetchingService>().fetchVideoList().then((value) async{
      await context.read<VideoFetchingService>().fetchAllGenre();
    });

    _videoThumbnailList = context.read<VideoFetchingService>().returnVideoThumbnail();
    _videoList = context.read<VideoFetchingService>().returnVideoList();
    _videoUrlList = context.read<VideoFetchingService>().returnVideoUrlList();
    _videoNameList = context.read<VideoFetchingService>().returnVideoNameList();
    _videoDescriptionList = context.read<VideoFetchingService>().returnVideoDescriptionList();

    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    getInformation();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Movies you may like'),
              SizedBox(height: 20,),
              MovieGridViewWidget(
                videoDescriptionList: _videoDescriptionList,
                videoList: _videoList,
                videoNameList: _videoNameList,
                videoThumbnailList: _videoThumbnailList,
                videoUrlList: _videoUrlList,
              ),
              SizedBox(height: 20,),
              Text('Action'),
              SizedBox(height: 20,),
              MovieGridViewWidget(
                videoDescriptionList: _videoDescriptionList,
                videoList: _videoList,
                videoNameList: _videoNameList,
                videoThumbnailList: _videoThumbnailList,
                videoUrlList: _videoUrlList,
              ),
              SizedBox(height: 20,),
              Text('Drama'),
              SizedBox(height: 20,),
              MovieGridViewWidget(
                videoDescriptionList: _videoDescriptionList,
                videoList: _videoList,
                videoNameList: _videoNameList,
                videoThumbnailList: _videoThumbnailList,
                videoUrlList: _videoUrlList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
