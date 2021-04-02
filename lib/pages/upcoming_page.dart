import 'package:flutter/material.dart';
import 'package:queen_ott_app/widgets/banner_widget.dart';
import 'package:queen_ott_app/widgets/video_grid_widget.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
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
    return ListView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
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
                VideoGridWidget(
                  physics: NeverScrollableScrollPhysics(),
                  count: 6,
                ),
                BannerWidget(
                  banners[index],
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                ),
              ],
            ),
          );
        });
  }
}
