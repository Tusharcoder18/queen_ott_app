import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:queen_ott_app/models/season.dart';
import 'package:queen_ott_app/models/series.dart';
import 'package:queen_ott_app/models/video.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';
import 'package:provider/provider.dart';

class SeasonDetailScreen extends StatefulWidget {
  SeasonDetailScreen(
    this.series,
    // {this.videoThumbnail, this.indexNumber, this.consumerDocument}
  );

  final Series series;
  // final String videoThumbnail;
  // final int indexNumber;
  // final String consumerDocument;

  /// this is the series document

  @override
  _SeasonDetailScreenState createState() => _SeasonDetailScreenState();
}

class _SeasonDetailScreenState extends State<SeasonDetailScreen> {
  Series _series;
  // List<dynamic> _seasonList = [];
  // String videoName = "";
  // String seriesDescription = "";
  // List<Series> _seriesList = [];

  // Future<void> getSeasonList() async {
  //   _seasonList =
  //       context.read<SeriesFetchingService>().returnSeasonAndEpisodeInfo();
  // print(_seasonList);
  // final name = await context
  //     .read<SeriesFetchingService>()
  //     .getSeriesName(documentName: widget.consumerDocument.toString());
  // videoName = name.toString();
  // final getSeriesDescription = await context
  //     .read<SeriesFetchingService>()
  //     .getSeriesDescription(documentName: _seasonList[0][0].toString());
  // seriesDescription = getSeriesDescription.toString();

  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    // getSeasonList();
    _series = widget.series;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(context, screenHeight, screenWidth),
          _episodesList(context, screenHeight, screenWidth)
        ],
      ),
    );
  }

  Widget _appBar(
      BuildContext context, double screenHeight, double screenWidth) {
    return SliverAppBar(
      expandedHeight: screenHeight * 0.65,
      backgroundColor: Colors.black,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        // collapseMode: CollapseMode.pin,
        background: Container(
          child: Stack(
            fit: StackFit.expand,
            children: [
              FadeInImage(
                placeholder: NetworkImage(_series.getSeriesThumbnail()),
                image: NetworkImage(_series.getSeriesThumbnail()),
                fit: BoxFit.cover,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.005),
                  width: double.infinity,
                  // color: Colors.pink,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _series.getSeriesTitle(),
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(fontSize: 20),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.17,
                            height: screenHeight * 0.04,
                            child: MaterialButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              child: Text(
                                'Action',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              color: Colors.blueGrey,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: screenWidth * 0.17,
                            height: screenHeight * 0.04,
                            child: MaterialButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              child: Text(
                                'Drama',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              color: Colors.blueGrey,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: screenWidth * 0.17,
                            height: screenHeight * 0.04,
                            child: MaterialButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              child: Text(
                                'Sci-fi',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              color: Colors.blueGrey,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        _series.getSeriesDescription(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          TextButton(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  size: screenWidth * 0.1,
                                ),
                                Text(
                                  'Watch List',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.heart,
                                  size: screenWidth * 0.08,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Like',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.share,
                                  size: screenWidth * 0.1,
                                ),
                                Text(
                                  'Share',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _episodesList(
      BuildContext context, double screenHeight, double screenWidth) {
    List<Season> _seasons = _series.getSeriesSeasons();
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            height: 200,
            width: screenWidth,
            child: ListView.builder(
              itemCount: _seasons.length,
              itemBuilder: (context, index) {
                List<Video> _episodes = _seasons[index].getSeasonEpisodes();
                return Container(
                  height: 200,
                  width: 300,
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Season ${_seasons[index].getSeasonNumber()}'),
                      Container(
                        height: 100,
                        child: ListView.builder(
                          itemCount: _episodes.length,
                          itemBuilder: (context, eIndex) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Test(
                                        videoUrl:
                                            _episodes[index].getVideoUrl(),
                                        thumbnailUrl: _episodes[index]
                                            .getVideoThumbnail(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 20,
                                  child: Text('Episode${eIndex + 1}'),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
