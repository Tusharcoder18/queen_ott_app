import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:queen_ott_app/pages/settings_page.dart';
import 'package:queen_ott_app/screens/referral_screen.dart';
import 'package:queen_ott_app/screens/subscription_screen.dart';
import 'package:settings_ui/settings_ui.dart';

import '../screens/music_home_screen.dart';

class MenuPage extends StatefulWidget {
  final bool isCreator;
  MenuPage({this.isCreator});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<String> _premiumPlans = ['Monthly', 'Quaterly', 'Half Yearly', 'Yearly'];

  List<int> _premiumPrices = [49, 120, 150, 250];

  List<String> _guitarPlans = [
    '1 Lesson',
    '8 Lessons',
    '16 Lessons',
    '32 Lessons'
  ];

  List<int> _guitarPrices = [15, 99, 149, 249];

  @override
  Widget build(BuildContext context) {
    List<String> _titles = [
      'Music',
      'Guitar Lessons',
      'Genres',
      'Refer and Earn',
      'Rate Us',
      'Support/Help',
      'Subscribe',
      'Settings',
    ];
    List<IconData> _leadingIcon = [
      FontAwesomeIcons.music,
      FontAwesomeIcons.guitar,
      Icons.disc_full,
      Icons.attach_money,
      Icons.star_rate,
      Icons.help,
      Icons.subscriptions,
      Icons.settings,
    ];
    List<Widget> _pushTo = [
      MusicHomeScreen(),
      SubscriptionScreen(plans: _guitarPlans, prices: _guitarPrices),
      Container(),
      ReferAndEarnScreen(),
      Container(),
      Container(),
      SubscriptionScreen(
        plans: _premiumPlans,
        prices: _premiumPrices,
      ),
      SettingsPage(isCreator: widget.isCreator),
    ];
    return Container(
      child: SettingsList(
        sections: List.generate(_titles.length, (index) {
          return CustomSection(
            child: SettingsTile(
              title: _titles[index],
              leading: Icon(_leadingIcon[index]),
              onPressed: (context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _pushTo[index],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
