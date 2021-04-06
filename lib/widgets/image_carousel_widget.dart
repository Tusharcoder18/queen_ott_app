import 'dart:async';

import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentPage = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();
    try {
      Timer.periodic(Duration(seconds: 3), (Timer timer) {
        if (_currentPage < 2) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        }
      });
    } catch (e) {
      print('Exception:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Image.asset(
          'assets/moviePoster.jpg',
          fit: BoxFit.cover,
        ),
        Image.asset(
          'assets/movieOne.jpg',
          fit: BoxFit.cover,
        ),
        Image.asset(
          'assets/movieTwo.jpg',
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
