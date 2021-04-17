import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:queen_ott_app/GuitarLessons/guitar_lessons.dart';
import 'package:queen_ott_app/pages/settings_page.dart';
import 'package:queen_ott_app/screens/subscription_screen.dart';
import 'package:settings_ui/settings_ui.dart';

import '../screens/music_home_screen.dart';

class MenuPage extends StatelessWidget {
  final bool isCreator;
  MenuPage({this.isCreator});

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
      Container(),
      Container(),
      Container(),
      SubscriptionScreen(
        plans: _premiumPlans,
        prices: _premiumPrices,
      ),
      SettingsPage(isCreator: isCreator),
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
        // [
        //   CustomSection(
        //     child: SettingsTile(
        //       title: 'Music',
        //       leading: Icon(FontAwesomeIcons.music),
        //       onPressed: (context) {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => MusicHomeScreen(),
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        //   CustomSection(
        //     child: SettingsTile(
        //       title: 'Genres',
        //       leading: Icon(Icons.disc_full),
        //       onPressed: (context) {},
        //     ),
        //   ),
        //   CustomSection(
        //     child: SettingsTile(
        //       title: 'Refer and Earn',
        //       leading: Icon(Icons.attach_money),
        //       onPressed: (context) {},
        //     ),
        //   ),
        //   CustomSection(
        //     child: SettingsTile(
        //       title: 'Rate Us',
        //       leading: Icon(Icons.star_rate),
        //       onPressed: (context) {},
        //     ),
        //   ),
        //   CustomSection(
        //     child: SettingsTile(
        //       title: 'Support/Help',
        //       leading: Icon(Icons.help),
        //       onPressed: (context) {},
        //     ),
        //   ),
        //   CustomSection(
        //     child: SettingsTile(
        //       title: 'Subscribe',
        //       leading: Icon(Icons.subscriptions),
        //       onPressed: (context) {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => SubscriptionScreen()));
        //       },
        //     ),
        //   ),
        //   CustomSection(
        //     child: SettingsTile(
        //       title: 'Settings',
        //       leading: Icon(Icons.settings),
        //       onPressed: (context) {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => SettingsPage(
        //                       isCreator: isCreator,
        //                     )));
        //       },
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
