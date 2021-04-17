import 'package:flutter/material.dart';
import 'package:queen_ott_app/widgets/banner_widget.dart';
import 'package:queen_ott_app/widgets/series_grid_widget.dart';

// This Widget contains all the shows to be displayed under recommended shows
class RecommendedShowWidget extends StatefulWidget {
  @override
  _RecommendedShowWidgetState createState() => _RecommendedShowWidgetState();
}

class _RecommendedShowWidgetState extends State<RecommendedShowWidget> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                ),
              ],
            ),
          );
        });
  }
}
