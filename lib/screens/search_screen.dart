import 'package:flutter/material.dart';
import 'package:queen_ott_app/models/video.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';
import 'package:queen_ott_app/services/video_fetching_service.dart';
import 'package:queen_ott_app/widgets/video_grid_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  String _searchKey;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    autofocus: true,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search for shows, movies here',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(color: Colors.grey),
                    ),
                    onChanged: (value) {
                      _searchKey = value;
                      // We can call a function here for the search functionality to work
                      print(_searchKey);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Popular Searches',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Expanded(
                  child: VideoGridWidget(
                    physics: ScrollPhysics(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchScreeenDelegate extends SearchDelegate<String> {
  // List<String> _videoThumbnailList = [];
  // List<String> _videoUrlList = [];
  // List<String> _videoNameList = [];
  // List<String> _seriesThumbnailList = [];
  // List<dynamic> _seriesList = [];
  // List<String> _seriesNameList = [];
  List<Video> _searchResults = [];
  List<Video> _videos;

  SearchScreeenDelegate(BuildContext context) {
    context.read<VideoFetchingService>().fetchVideoList().whenComplete(() {});
    _videos = context.read<VideoFetchingService>().getVideos();
  }

  // Future<void> fetchLists(BuildContext context) async {
  // await context.read<VideoFetchingService>().fetchVideoList();
  // await context.read<SeriesFetchingService>().fetchSeriesList();

  // _videoNameList = context.read<VideoFetchingService>().returnVideoNameList();
  // _seriesNameList =
  //     context.read<SeriesFetchingService>().returnSeriesNameList();
  // _videoThumbnailList =
  //     context.read<VideoFetchingService>().returnVideoThumbnail();
  // _seriesThumbnailList =
  //     context.read<SeriesFetchingService>().returnSeriesThumbnail();
  // _videoUrlList = context.read<VideoFetchingService>().returnVideoUrlList();
  // _seriesList = context.read<SeriesFetchingService>().returnSeriesList();
  // }

  // Future<void> fetchData(BuildContext context) async {
  //   await context
  //       .read<VideoFetchingService>()
  //       .fetchVideoListSubset(_searchResults);
  //   _videoThumbnailList =
  //       context.read<VideoFetchingService>().returnVideoThumbnail();
  //   _videoUrlList = context.read<VideoFetchingService>().returnVideoUrlList();
  // }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = '';
            _searchResults.clear();
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      _searchResults.clear();
      return Container(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Popular Searches',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              VideoGridWidget(
                physics: NeverScrollableScrollPhysics(),
                videos: _videos,
              ),
            ],
          ),
        ),
      );
    } else {
      // This will traverse through the video list and store the search results in _searchResults
      // if (_searchResults.isEmpty) {
      //   _videoNameList.forEach((element) {
      //     if (element.toLowerCase().startsWith(query.toLowerCase()) &&
      //         !_searchResults.contains(element)) {
      //       _searchResults.add(element);
      //     }
      //   });
      // } else {
      //   _searchResults.removeWhere((element) =>
      //       !element.toLowerCase().startsWith(query.toLowerCase()));
      // }
      // print(_searchResults);
      // fetchData(context);

      if (_searchResults.isEmpty) {
        _videos.forEach((element) {
          var title = element.getVideoTitle();
          if (title.toLowerCase().startsWith(query.toLowerCase()) &&
              !_searchResults.contains(element)) {
            _searchResults.add(element);
          }
        });
      } else {
        _searchResults.removeWhere((element) => !element
            .getVideoTitle()
            .toLowerCase()
            .startsWith(query.toLowerCase()));
      }

      return Container(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoGridWidget(
                physics: NeverScrollableScrollPhysics(),
                videos: _searchResults,
              )
            ],
          ),
        ),
      );
    }
  }
}
