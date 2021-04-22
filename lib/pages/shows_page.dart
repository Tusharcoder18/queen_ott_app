import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/models/series.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';
import 'package:queen_ott_app/widgets/image_carousel_widget.dart';
import 'package:queen_ott_app/widgets/series_grid_widget.dart';

class ShowsPage extends StatefulWidget {
  @override
  _ShowsPageState createState() => _ShowsPageState();
}

class _ShowsPageState extends State<ShowsPage> {
  List<Series> _seriesList;
  // List<String> _seriesThumbnail = [];
  // List<dynamic> _seriesList = [];

  // Future<void> fetchSeries() async {
  //   await context.read<SeriesFetchingService>().fetchSeriesList();
  //   _seriesThumbnail =
  //       context.read<SeriesFetchingService>().returnSeriesThumbnail();
  //   _seriesList = context.read<SeriesFetchingService>().returnSeriesList();
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchSeries();
  // }

  @override
  void initState() {
    super.initState();

    context
        .read<SeriesFetchingService>()
        .fetchSeriesList(context)
        .whenComplete(() {
      _seriesList = context.read<SeriesFetchingService>().getSeriesList();
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
      'Popular Shows',
      'Top Rated Shows',
      'Premium Shows',
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
                    SeriesGridWidget(
                      physics: NeverScrollableScrollPhysics(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
