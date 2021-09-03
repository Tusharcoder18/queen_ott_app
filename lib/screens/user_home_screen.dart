import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/constants.dart';
import 'package:queen_ott_app/pages/home_screen_page.dart';
import 'package:queen_ott_app/pages/menu_page.dart';
import 'package:queen_ott_app/pages/movies_page.dart';
import 'package:queen_ott_app/pages/no_internet_page.dart';
import 'package:queen_ott_app/pages/shows_page.dart';
import 'package:queen_ott_app/pages/upcoming_page.dart';
import 'package:queen_ott_app/screens/subscription_screen.dart';
import 'package:queen_ott_app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSubscribed = false;
  int _selectedIndex = 0;
  bool _internet = false;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreenWidget(),
    ShowsPage(),
    MoviesPage(),
    UpcomingPage(),
    MenuPage(
      isCreator: false,
    ),
  ];
  List<Widget> _widgetOptionsNoInternet = <Widget>[
    NoInternetPage(),
    NoInternetPage(),
    NoInternetPage(),
    NoInternetPage(),
    MenuPage(
      isCreator: false,
    ),
  ];
  List<String> _plans = ['Monthly', 'Quaterly', 'Half Yearly', 'Yearly'];
  List<int> _prices = [49, 120, 150, 250];

  Future<void> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        _internet = true;
        setState(() {});
      } else {
        _internet = false;
      }
    } on SocketException catch (_) {
      print('not connected');
      _internet = false;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool checkSub(AuthBase auth) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.userId())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.data()['subscribed']) {
        print("True");
      }
    });
    return false;
  }

  @override
  void initState() {
    super.initState();
    _checkInternet().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final screenHeight = MediaQuery.of(context).size.height;
    final authService = Provider.of<AuthBase>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                FontAwesomeIcons.bell,
                color: kGoldenColor,
                size: 28,
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        padding: EdgeInsets.all(0),
                        height: screenHeight * 0.25,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // set the type of notification on tap(observe the naming convention for preference value)
                            ListTile(
                              onTap: () {
                                prefs.setString('notificationsType', 'all');
                                Navigator.of(context).pop();
                              },
                              title: Text('All'),
                            ),
                            ListTile(
                              onTap: () {
                                prefs.setString(
                                  'notificationsType',
                                  'coming_soon',
                                );
                                Navigator.of(context).pop();
                              },
                              title: Text('Coming Soon'),
                            ),
                            ListTile(
                              onTap: () {
                                prefs.setString(
                                  'notificationsType',
                                  'updates',
                                );
                                Navigator.of(context).pop();
                              },
                              title: Text('Updates'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: 8,
                left: _isSubscribed
                    ? MediaQuery.of(context).size.width * 0.14
                    : MediaQuery.of(context).size.width * 0.01,
              ),
              height: 50,
              child: Image.asset('assets/logo.png'),
            ),
            !checkSub(authService)
                ? MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubscriptionScreen(
                            plans: _plans,
                            prices: _prices,
                          ),
                        ),
                      );
                    },
                    color: kGoldenColor,
                    child: Text(
                      'Subscribe',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : Container(),
            Container(
              padding: EdgeInsets.all(0),
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: kGoldenColor,
                  size: 28,
                ),
                onPressed: () {
                  // showSearch(
                  //     context: context,
                  //     delegate: SearchScreeenDelegate(context));
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.slideshow),
            label: 'Shows',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kGoldenColor,
        onTap: _onItemTapped,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          print('refresh');
          return _checkInternet();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(),
            Container(
              child: Center(
                child: _internet
                    ? _widgetOptions.elementAt(_selectedIndex)
                    : _widgetOptionsNoInternet.elementAt(_selectedIndex),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
