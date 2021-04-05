import 'package:flutter/material.dart';

class AnalyticsCard extends StatelessWidget {
  const AnalyticsCard(
      {Key key,
      @required this.screenHeight,
      @required this.screenWidth,
      @required this.title,
      @required this.subtitle1,
      this.subtitle2,
      this.value})
      : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: screenHeight * 0.15,
      width: screenWidth,
      color: Color(0xff313131),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    subtitle1,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(color: Colors.white38),
                  ),
                  Text(
                    subtitle2,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(color: Colors.white38),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
                child: Text(
              value.toString(),
              style: TextStyle(color: Colors.white, fontSize: 30),
            )),
          ),
        ],
      ),
    );
  }
}
