import 'package:flutter/material.dart';

class TopAnalyticsCard extends StatelessWidget {
  const TopAnalyticsCard({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.topViews,
    @required this.title,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final String title;
  final List<int> topViews;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: screenHeight * 0.25,
      width: screenWidth,
      color: Color(0xff313131),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  'Last 28 days',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.white38),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(5, (index) {
                        return Expanded(
                            child: Text(
                          'Series ${index + 1}',
                          style: Theme.of(context).textTheme.headline1,
                        ));
                      }),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(5, (index) {
                      return Expanded(
                          child: Text(
                        topViews[index].toString(),
                        style: Theme.of(context).textTheme.headline1,
                      ));
                    }),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
