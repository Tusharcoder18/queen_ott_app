import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/screens/content_creator_screen.dart';
import 'package:queen_ott_app/screens/sign_in_screen.dart';
import 'package:queen_ott_app/screens/user_home_screen.dart';
import 'package:queen_ott_app/services/authentication_service.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final bool isCreator;

  SettingsPage({this.isCreator});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool explicit;
  bool notificationsEnabled;
  bool globeNews;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getPreferences().whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    explicit = prefs.getBool('explicit') ?? false;
    notificationsEnabled = prefs.getBool('notificationsEnabled') ?? false;
    globeNews = prefs.getBool('globeNews') ?? false;
  }

  updatePreferences(String setting, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(setting, value);

    // Type of notifications(There are three types of notifications:- 1)all 2)coming_soon 3)updates)
    // By default the user should receive all notifications
    await prefs.setString('notificationsType', 'all');

    setState(() {
      print('Settings saved successfully');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 30),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: SettingsList(
                sections: [
                  CustomSection(
                    child: SettingsTile(
                      title: 'User Name',
                      leading: Icon(FontAwesomeIcons.user),
                      subtitle: 'Update Profile',
                      trailing: Icon(Icons.edit),
                      onPressed: (context) {},
                    ),
                  ),
                  SettingsSection(
                    title: 'Account',
                    tiles: [
                      SettingsTile(
                        title: widget.isCreator
                            ? 'Switch to Consumer'
                            : 'Switch to Creator',
                        leading: Icon(FontAwesomeIcons.creativeCommons),
                        onPressed: (context) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            if (widget.isCreator) {
                              return HomeScreen();
                            } else {
                              return ContentCreatorScreen();
                            }
                          }));
                        },
                      ),
                      SettingsTile(title: 'Email', leading: Icon(Icons.email)),
                    ],
                  ),
                  SettingsSection(
                    title: 'Common',
                    tiles: [
                      SettingsTile(
                        title: 'Language',
                        subtitle: 'English',
                        leading: Icon(Icons.language),
                        onPressed: (context) {},
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: 'Security',
                    tiles: [
                      SettingsTile(
                        title: 'Password',
                        leading: Icon(Icons.lock),
                        onPressed: (context) {},
                      ),
                      SettingsTile.switchTile(
                        title: 'Allow Notifications',
                        leading: Icon(Icons.notifications_active),
                        switchValue: notificationsEnabled,
                        onToggle: (value) {
                          setState(() {
                            notificationsEnabled = value;
                            updatePreferences('notificationsEnabled', value);
                          });
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: 'Misc',
                    tiles: [
                      SettingsTile.switchTile(
                        title: 'Explicit',
                        leading: Icon(Icons.explicit),
                        switchValue: explicit,
                        onToggle: (bool value) {
                          setState(() {
                            explicit = value;
                            updatePreferences('explicit', value);
                          });
                        },
                      ),
                      SettingsTile.switchTile(
                        title: 'The Globe News Channel',
                        leading: Icon(Icons.new_releases_sharp),
                        switchValue: globeNews,
                        onToggle: (bool value) {
                          setState(() {
                            globeNews = value;
                            updatePreferences('globeNews', value);
                          });
                        },
                      ),
                      SettingsTile(
                          title: 'Legal', leading: Icon(Icons.description)),
                      SettingsTile(
                          title: 'Terms of Services',
                          leading: Icon(Icons.description_outlined)),
                      SettingsTile(
                        title: 'Sign out',
                        leading: Icon(Icons.exit_to_app),
                        onPressed: (context) {
                          Provider.of<AuthenticationService>(context,
                                  listen: false)
                              .signOutFromAll();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()),
                              (Route<dynamic> route) => false);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
