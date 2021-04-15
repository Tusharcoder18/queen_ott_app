import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:queen_ott_app/pages/home_screen_page.dart';
import 'package:queen_ott_app/pages/menu_page.dart';
import 'package:queen_ott_app/pages/movies_page.dart';
import 'package:queen_ott_app/pages/no_internet_page.dart';
import 'package:queen_ott_app/pages/shows_page.dart';
import 'package:queen_ott_app/pages/upcoming_page.dart';
import 'package:queen_ott_app/screens/subscription_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  Future<void> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        _internet = true;
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 20,
              child: Icon(FontAwesomeIcons.bell),
            ),
            // Text(
            //   'QUEEN',
            //   style:
            //       Theme.of(context).textTheme.headline1.copyWith(fontSize: 30),
            // ),
            Container(
              height: 50,
              child: Image.asset(
                'assets/logo2.png',
                fit: BoxFit.fill,
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubscriptionScreen()));
              },
              color: Colors.blue,
              child: Text(
                'Subscribe',
                style: Theme.of(context).textTheme.headline1,
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
        selectedItemColor: Colors.blue[600],
        onTap: _onItemTapped,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _checkInternet();
        },
        child: Container(
          child: Center(
            child: _internet
                ? _widgetOptions.elementAt(_selectedIndex)
                : _widgetOptionsNoInternet.elementAt(_selectedIndex),
          ),
        ),
      ),
    );
  }
}
