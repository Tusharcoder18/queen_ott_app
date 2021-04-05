import 'package:flutter/material.dart';
import 'package:queen_ott_app/widgets/analytics_card.dart';
import 'package:queen_ott_app/widgets/top_analytics_card.dart';

class MonetizationPage extends StatelessWidget {
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
                'Monetization',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            AnalyticsCard(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              title: 'Revenue Estimate',
              subtitle1: 'INR',
              subtitle2: 'Lifetime',
              value: 8900,
            ),
            AnalyticsCard(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              title: 'Transactions',
              subtitle1: 'Lifetime',
              subtitle2: 'Delayed 1 day',
              value: 14,
            ),
            TopAnalyticsCard(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                title: 'Top Earning Series',
                topViews: topViews)
          ],
        ),
      ),
    );
  }
}
