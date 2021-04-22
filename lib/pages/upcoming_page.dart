import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/models/series.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';
import 'package:queen_ott_app/widgets/image_carousel_widget.dart';
import 'package:queen_ott_app/widgets/series_grid_widget.dart';

class UpcomingPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<UpcomingPage> {
  List<Series> _seriesList;

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
      'Upcoming Shows',
      'Upcoming Movies',
      'Upcoming Series',
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
            itemCount: banners.length,
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
                  ],
                ),
              );
            }),
      ],
    );
  }
}
