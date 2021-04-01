import 'package:flutter/material.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';
import 'package:queen_ott_app/widgets/banner_widget.dart';
import 'package:queen_ott_app/widgets/video_grid_widget.dart';
import 'package:provider/provider.dart';

class ShowsPage extends StatefulWidget {
  @override
  _ShowsPageState createState() => _ShowsPageState();
}

class _ShowsPageState extends State<ShowsPage> {
  List<String> imageList = [
    'assets/movieOne.jpg',
    'assets/movieTwo.jpg',
    'assets/movieThree.jpg',
    'assets/movieOne.jpg',
    'assets/movieTwo.jpg',
    'assets/movieThree.jpg',
    'assets/movieOne.jpg',
    'assets/movieTwo.jpg',
    'assets/movieThree.jpg',
    'assets/movieOne.jpg',
    'assets/movieTwo.jpg',
    'assets/movieThree.jpg',
  ];

  List<String> _seriesThumbnail = [];

  Future<void> fetchSeries() async{
    await context.read<SeriesFetchingService>().fetchSeriesList();
    _seriesThumbnail = context.read<SeriesFetchingService>().returnSeriesThumbnail();
    print(_seriesThumbnail);
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    fetchSeries();
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
      'Popular Shows',
      'Top Rated Shows',
      'Premium Shows',
    ];
    return ListView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: _seriesThumbnail.length,
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
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                VideoGridWidget(
                  physics: NeverScrollableScrollPhysics(),
                  count: 6,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BannerWidget(
                    _seriesThumbnail[index],
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
