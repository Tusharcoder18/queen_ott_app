import 'package:flutter/material.dart';
import 'package:queen_ott_app/widgets/analytics_card.dart';
import 'package:queen_ott_app/widgets/top_analytics_card.dart';

class AnalyticsPage extends StatelessWidget {
  final List<int> topViews = [2738, 2278, 1092, 678, 536];
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.0),
              height: screenHeight * 0.037,
              child: Text(
                'Analytics',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            AnalyticsCard(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              title: 'Realtime Views',
              subtitle1: 'Estimated Views',
              subtitle2: 'Past 48 hours',
              value: 800,
            ),
            AnalyticsCard(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              title: 'Total Views',
              subtitle1: 'Estimated Views',
              subtitle2: 'Lifetime',
              value: 9645,
            ),
            AnalyticsCard(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              title: 'Watch Time',
              subtitle1: 'Hours',
              subtitle2: 'Last 28 days',
              value: 385,
            ),
            AnalyticsCard(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              title: 'Revenue Estimate',
              subtitle1: 'INR',
              subtitle2: 'Last 28 days',
              value: 5746,
            ),
            TopAnalyticsCard(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                title: 'Top Performing Series',
                topViews: topViews)
          ],
        ),
      ),
    );
  }
}
