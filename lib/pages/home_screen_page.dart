import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/authentication_service.dart';
import 'package:queen_ott_app/widgets/continue_watching_widget.dart';
import 'package:queen_ott_app/widgets/image_carousel_widget.dart';
import 'package:queen_ott_app/widgets/language_shows_widget.dart';
import 'package:queen_ott_app/widgets/recommended_shows_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenWidget extends StatelessWidget {
  // This is to give font style to the different headings
  // on the screen

  // This will be called every time the app starts and if the notifications are not enabled
  showDialogIfNoNotifications(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool notificationsEnabled = prefs.getBool('notificationsEnabled');
    bool isFirstLoaded = prefs.getBool('isFirstLoaded');
    if (isFirstLoaded == null && notificationsEnabled != true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Queen would like to send notifications"),
            content: new Text(
                "Notifications may include alerts, sounds, etc. These can be changed in Settings later."),
            actions: <Widget>[
              TextButton(
                child: new Text("Allow"),
                onPressed: () {
                  Navigator.of(context).pop();
                  prefs.setBool('notificationsEnabled', true);
                  prefs.setString('notificationsType', 'all');
                  prefs.setBool('isFirstLoaded', false);
                },
              ),
              TextButton(
                child: new Text("Don't Allow"),
                onPressed: () {
                  Navigator.of(context).pop();
                  prefs.setBool('notificationsEnabled', false);
                  prefs.setBool('isFirstLoaded', false);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    User _user = Provider.of<AuthenticationService>(context).currentUser;
    String _name = _user.displayName ?? 'User';
    _name = _name.split(" ")[0];

    Future.delayed(Duration.zero, () => showDialogIfNoNotifications(context));
    return DefaultTabController(
      length: 4,
      child: Container(
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome $_name',
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 20),
            ),
            Container(
              height: screenHeight * 0.2,
              width: screenWidth,
              color: Colors.pink,
              child: ImageCarousel(),
            ),
            SizedBox(
              height: screenHeight * 0.06,
              child: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: 'Continue Watching',
                    ),
                    Tab(
                      text: 'Recommended',
                    ),
                    Tab(
                      text: 'Language',
                    ),
                    Tab(
                      text: 'The Globe @ World Own News Channel',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ContinueWatchingWidget(),
                  RecommendedShowWidget(),
                  LanguageShowsWidget(),
                  Center(
                    child: Text('The Globe @ World Own News Channel'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
