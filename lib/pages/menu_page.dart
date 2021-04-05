import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:queen_ott_app/pages/settings_page.dart';
import 'package:queen_ott_app/screens/subscription_screen.dart';
import 'package:settings_ui/settings_ui.dart';

class MenuPage extends StatelessWidget {
  final bool isCreator;
  MenuPage({this.isCreator});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SettingsList(
        sections: [
          CustomSection(
            child: SettingsTile(
              title: 'Music',
              leading: Icon(FontAwesomeIcons.music),
              onPressed: (context) {},
            ),
          ),
          CustomSection(
            child: SettingsTile(
              title: 'Genres',
              leading: Icon(Icons.disc_full),
              onPressed: (context) {},
            ),
          ),
          CustomSection(
            child: SettingsTile(
              title: 'Refer and Earn',
              leading: Icon(Icons.attach_money),
              onPressed: (context) {},
            ),
          ),
          CustomSection(
            child: SettingsTile(
              title: 'Rate Us',
              leading: Icon(Icons.star_rate),
              onPressed: (context) {},
            ),
          ),
          CustomSection(
            child: SettingsTile(
              title: 'Support/Help',
              leading: Icon(Icons.help),
              onPressed: (context) {},
            ),
          ),
          CustomSection(
            child: SettingsTile(
              title: 'Subscribe',
              leading: Icon(Icons.subscriptions),
              onPressed: (context) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubscriptionScreen()));
              },
            ),
          ),
          CustomSection(
            child: SettingsTile(
              title: 'Settings',
              leading: Icon(Icons.settings),
              onPressed: (context) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage(
                              isCreator: isCreator,
                            )));
              },
            ),
          ),
        ],
      ),
    );
  }
}
