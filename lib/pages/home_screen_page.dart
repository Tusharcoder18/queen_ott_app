import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/authentication_service.dart';
import 'package:queen_ott_app/widgets/continue_watching_widget.dart';
import 'package:queen_ott_app/widgets/image_carousel_widget.dart';
import 'package:queen_ott_app/widgets/language_shows_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenWidget extends StatefulWidget {
  // This is to give font style to the different headings
  // on the screen

  // This will be called every time the app starts and if the notifications are not enabled
  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
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

  List<String> _headingList = [
    'Continue Watching',
    'Recommended',
    'Language',
    'The Globe @ World Own News Channel'
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    User _user = Provider.of<AuthenticationService>(context).currentUser;
    String _name = _user.displayName ?? 'User';
    _name = _name.split(" ")[0];

    Future.delayed(Duration.zero, () => showDialogIfNoNotifications(context));
    return SingleChildScrollView(
      child: Container(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 0.2,
              width: screenWidth,
              color: Colors.pink,
              child: ImageCarousel(),
            ),
            HorizontalScrollHomeWidget(heading: _headingList[0], widget: ContinueWatchingWidget(),),
            HorizontalScrollHomeWidget(heading: _headingList[1], widget: ContinueWatchingWidget(),),
            HorizontalScrollHomeWidget(heading: _headingList[2], widget: LanguageShowsWidget(),),
            HorizontalScrollHomeWidget(heading: _headingList[3], widget: ContinueWatchingWidget(),),
          ],
        ),
      ),
    );
  }
}

class HorizontalScrollHomeWidget extends StatelessWidget {

  HorizontalScrollHomeWidget({@required this.heading, @required this.widget});

  final String heading;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(heading),
            widget,
          ],
        ),
      ),
    );
  }
}
