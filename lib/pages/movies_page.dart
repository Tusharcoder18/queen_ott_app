import 'package:flutter/material.dart';
import 'package:queen_ott_app/widgets/custom_staggered_grid_view.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
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
    return CustomStaggeredWidget(imageList: imageList, count: imageList.length);
  }
}
