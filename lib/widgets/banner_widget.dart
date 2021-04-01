import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String image;

  BannerWidget(this.image,
      {@required this.screenWidth, @required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: screenWidth * 0.05, horizontal: screenWidth * 0.02),
      height: screenHeight * 0.17,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.pink,
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
      ),
    );
  }
}
