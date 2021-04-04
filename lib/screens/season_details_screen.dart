import 'package:flutter/material.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';
import 'package:provider/provider.dart';

class SeasonDetailScreen extends StatefulWidget {
  SeasonDetailScreen(
      {this.videoThumbnail, this.indexNumber, this.consumerDocument});

  final String videoThumbnail;
  final int indexNumber;
  final String consumerDocument;

  /// this is the series document

  @override
  _SeasonDetailScreenState createState() => _SeasonDetailScreenState();
}

class _SeasonDetailScreenState extends State<SeasonDetailScreen> {
  List<dynamic> _seasonList = [];
  String videoName = "";
  String seriesDescription = "";

  Future<void> getSeasonList() async {
    _seasonList =
        context.read<SeriesFetchingService>().returnSeasonAndEpisodeInfo();
    print(_seasonList);
    final name = await context
        .read<SeriesFetchingService>()
        .getSeriesName(documentName: widget.consumerDocument.toString());
    videoName = name.toString();
    final getSeriesDescription = await context
        .read<SeriesFetchingService>()
        .getSeriesDescription(documentName: _seasonList[0][0].toString());
    seriesDescription = getSeriesDescription.toString();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSeasonList();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(screenHeight, screenWidth),
          _episodesList(screenHeight, screenWidth)
        ],
      ),
    );
  }

  Widget _appBar(double screenHeight, double screenWidth) {
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
              Hero(
                tag: 'imageHero${widget.indexNumber}',
                child: FadeInImage(
                  placeholder: NetworkImage(widget.videoThumbnail),
                  image: NetworkImage(widget.videoThumbnail),
                  fit: BoxFit.cover,
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    // begin: FractionalOffset.topCenter,
                    // end: FractionalOffset.bottomCenter,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // stops: [0.1, 0.6, 1.0],
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
                        videoName,
                        style: TextStyle(
                            fontSize: screenHeight * 0.035,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        seriesDescription,
                        style: TextStyle(
                            fontSize: screenHeight * 0.019,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
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

  Widget _episodesList(double screenHeight, double screenWidth) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            height: 200,
            width: screenWidth,
            child: ListView.builder(
              itemCount: _seasonList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 200,
                  width: 300,
                  color: Colors.black,
                  child: Column(
                    children: [
                      Text('Season ${index + 1}'),
                      Container(
                        height: _seasonList[index].length.toDouble() * 40,
                        child: ListView.builder(
                          itemCount: _seasonList[index].length,
                          itemBuilder: (context, eIndex) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  final videoUrl = await context
                                      .read<SeriesFetchingService>()
                                      .getUrl(
                                          videoDocument: _seasonList[index]
                                                  [eIndex]
                                              .toString());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Test(
                                        videoUrl: videoUrl.toString(),
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

/// This row is for the genre
/// currently commented
//Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   children: [
//     SizedBox(
//       width: screenWidth * 0.17,
//       height: screenHeight * 0.04,
//       child: MaterialButton(
//         onPressed: () {},
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(18)),
//         child: Text(
//           'Action',
//           style: TextStyle(fontSize: 12),
//         ),
//         color: Colors.blueGrey,
//       ),
//     ),
//     SizedBox(
//       width: 5,
//     ),
//     SizedBox(
//       width: screenWidth * 0.17,
//       height: screenHeight * 0.04,
//       child: MaterialButton(
//         onPressed: () {},
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(18)),
//         child: Text(
//           'Drama',
//           style: TextStyle(fontSize: 12),
//         ),
//         color: Colors.blueGrey,
//       ),
//     ),
//     SizedBox(
//       width: 5,
//     ),
//     SizedBox(
//       width: screenWidth * 0.17,
//       height: screenHeight * 0.04,
//       child: MaterialButton(
//         onPressed: () {},
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(18)),
//         child: Text(
//           'Sci-fi',
//           style: TextStyle(fontSize: 12),
//         ),
//         color: Colors.blueGrey,
//       ),
//     )
//   ],
// ),
