import 'package:flutter/material.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';
import 'package:queen_ott_app/widgets/banner_widget.dart';
import 'package:queen_ott_app/widgets/show_grid_view_widget.dart';
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
    // 'assets/movieThree.jpg',
    // 'assets/movieOne.jpg',
    // 'assets/movieTwo.jpg',
    // 'assets/movieThree.jpg',
    // 'assets/movieOne.jpg',
    // 'assets/movieTwo.jpg',
    // 'assets/movieThree.jpg',
    // 'assets/movieOne.jpg',
    // 'assets/movieTwo.jpg',
    // 'assets/movieThree.jpg',
  ];

  List<String> _seriesThumbnail = [];
  List<dynamic> _seriesList = [];

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
    return SingleChildScrollView(
      child: Container(
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shows you may like'),
              SizedBox(height: 20,),
              ShowGridViewWidget(
                seriesThumbnailList: _seriesThumbnail,
                seriesList: _seriesList,
              ),
              SizedBox(height: 20,),
              Text('Action'),
              SizedBox(height: 20,),
              ShowGridViewWidget(
                seriesThumbnailList: _seriesThumbnail,
                seriesList: _seriesList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
