import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/models/series.dart';
import 'package:queen_ott_app/models/video.dart';
import 'package:queen_ott_app/screens/search_screen.dart';
import 'package:queen_ott_app/services/authentication_service.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';
import 'package:queen_ott_app/services/video_fetching_service.dart';
import 'package:queen_ott_app/widgets/banner_widget.dart';
import 'package:queen_ott_app/widgets/image_carousel_widget.dart';
import 'package:queen_ott_app/widgets/movie_grid_widget.dart';
import 'package:queen_ott_app/widgets/series_grid_widget.dart';
import 'package:queen_ott_app/widgets/video_grid_widget.dart';

class HomeScreenWidget extends StatelessWidget {
  // This is to give font style to the different headings
  // on the screen

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    User _user = Provider.of<AuthenticationService>(context).currentUser;
    String _name = _user.displayName ?? 'User';
    _name = _name.split(" ")[0];

    return DefaultTabController(
      length: 3,
      child: Container(
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Welcome $_name',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 20),
                ),
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: SearchScreeenDelegate(context));
                    }),
              ],
            ),
            Container(
              height: screenHeight * 0.2,
              width: screenWidth,
              color: Colors.pink,
              child: ImageCarousel(),
            ),
            SizedBox(
              height: screenHeight * 0.06,
              child: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: 'Continue Watching',
                    ),
                    Tab(
                      text: 'Recommended',
                    ),
                    Tab(
                      text: 'Language',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ContinueWatchingWidget(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  RecommendedShowWidget(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  LanguageShowsWidget(screenWidth: screenWidth),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageShowsWidget extends StatelessWidget {
  LanguageShowsWidget({
    @required this.screenWidth,
  });

  final double screenWidth;

  final TextStyle _textStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
  );

  final List<String> languages = [
    'Hindi',
    'English',
    'Punjabi',
    'Telugu',
    'Bengali',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListView.builder(
          itemCount: languages.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: screenWidth * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.green, Colors.lightBlueAccent]),
                ),
                child: Center(
                    child: Text(
                  languages[index],
                  style: _textStyle,
                )),
              ),
            );
          }),
    );
  }
}

// This Widget contains all the shows to be displayed under recommended shows
class RecommendedShowWidget extends StatefulWidget {
  const RecommendedShowWidget({
    @required this.screenWidth,
    @required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  _RecommendedShowWidgetState createState() => _RecommendedShowWidgetState();
}

class _RecommendedShowWidgetState extends State<RecommendedShowWidget> {
  List<Series> _seriesList;

  @override
  void initState() {
    super.initState();
    // context
    //     .read<SeriesFetchingService>()
    //     .fetchSeriesList(context)
    //     .whenComplete(() {
    //   setState(() {
    //     _seriesList = context.read<SeriesFetchingService>().getSeriesList();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    List<String> banners = [
      'assets/movieTwo.jpg',
      'assets/moviePoster.jpg',
      'assets/movieOne.jpg',
    ];
    return ListView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Queen Originals',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SeriesGridWidget(
                  physics: NeverScrollableScrollPhysics(),
                ),
                BannerWidget(
                  banners[index],
                  screenHeight: widget.screenHeight,
                  screenWidth: widget.screenWidth,
                ),
              ],
            ),
          );
        });
  }
}

// This widget contains all the shows which the user was previously watching
class ContinueWatchingWidget extends StatefulWidget {
  const ContinueWatchingWidget({
    @required this.screenWidth,
    @required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  _ContinueWatchingWidgetState createState() => _ContinueWatchingWidgetState();
}

class _ContinueWatchingWidgetState extends State<ContinueWatchingWidget> {
  List<Video> _videos;

  Future<List<Video>> getData(BuildContext context) async {
    await context.read<VideoFetchingService>().fetchVideoList();
    _videos = context.read<VideoFetchingService>().getVideos();
    return _videos;
  }

  @override
  void initState() {
    super.initState();
    // context.read<VideoFetchingService>().fetchVideoList();
    // .whenComplete(() {
    // setState(() {
    //   _videos = context.read<VideoFetchingService>().getVideos();
    // });
    // });
    // getData(context).whenComplete(() {
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: MovieGridWidget(
        physics: ScrollPhysics(),
      ),
    );
  }
}
