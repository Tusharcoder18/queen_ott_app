import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String noInternetAsset = 'assets/error1.svg';
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: () {
        print('refresh');
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.3,
              width: screenWidth * 0.8,
              child: SvgPicture.asset(
                noInternetAsset,
                semanticsLabel: 'No Internet',
              ),
            ),
            Text(
              'No Internet!',
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              'Check your internet connection!',
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
    );
  }
}
