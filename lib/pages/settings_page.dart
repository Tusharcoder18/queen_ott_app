import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/authentication_service.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  title: 'Switch to Creator',
                  leading: Icon(FontAwesomeIcons.creativeCommons)),
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
              SettingsTile.switchTile(
                title: 'Explicit',
                leading: Icon(Icons.explicit),
                switchValue: false,
                onToggle: (bool value) {},
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
                enabled: true,
                leading: Icon(Icons.notifications_active),
                switchValue: true,
                onToggle: (value) {},
              ),
            ],
          ),
          SettingsSection(
            title: 'Misc',
            tiles: [
              SettingsTile(
                  title: 'Terms of Service', leading: Icon(Icons.description)),
              SettingsTile(
                  title: 'Open source licenses',
                  leading: Icon(Icons.collections_bookmark)),
              SettingsTile(
                title: 'Sign out',
                leading: Icon(Icons.exit_to_app),
                onPressed: (context) {
                  Provider.of<AuthenticationService>(context, listen: false)
                      .signOutFromAll();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
