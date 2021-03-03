import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class TrendingScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container to display trending videos only
          Container(
            height: 40,
            width: screenWidth,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Trending shows',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          TrendingVideoListWidget(),
        ],
      ),
    );
  }
}

class TrendingVideoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              VideoInfoWidget( imagePath: 'assets/movieThree.jpg'),
              VideoInfoWidget( imagePath: 'assets/movieTwo.jpg'),
              VideoInfoWidget( imagePath: 'assets/movieOne.jpg'),
              VideoInfoWidget( imagePath: 'assets/movieThree.jpg'),
              VideoInfoWidget( imagePath: 'assets/movieOne.jpg'),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoInfoWidget extends StatelessWidget {
  const VideoInfoWidget({
    @required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        height: 200,
        width: screenWidth,
        color: Colors.red,
        child: Image.asset(imagePath, fit: BoxFit.cover,),
      ),
    );
  }
}
