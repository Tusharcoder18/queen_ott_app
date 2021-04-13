import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:queen_ott_app/models/season.dart';
import 'package:queen_ott_app/models/series.dart';
import 'package:queen_ott_app/models/video.dart';
import 'package:queen_ott_app/screens/test.dart';

class SeasonDetailScreen extends StatefulWidget {
  SeasonDetailScreen(
    this.series,
  );

  final Series series;

  /// this is the series document

  @override
  _SeasonDetailScreenState createState() => _SeasonDetailScreenState();
}

class _SeasonDetailScreenState extends State<SeasonDetailScreen> {
  Series _series;

  @override
  void initState() {
    super.initState();
    _series = widget.series;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
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
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
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
              physics: NeverScrollableScrollPhysics(),
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
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _episodes.length,
                            itemBuilder: (context, eIndex) {
                              final _episode = _episodes[eIndex];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Test(
                                          videoUrl: _episode.getVideoUrl(),
                                          thumbnailUrl:
                                              _episode.getVideoThumbnail(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 20,
                                    child: Text(_episode.getVideoTitle()),
                                  ),
                                ),
                              );
                            },
                          ),
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
