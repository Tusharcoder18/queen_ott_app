import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:queen_ott_app/pages/home_screen_page.dart';
import 'package:queen_ott_app/pages/settings_page.dart';
import 'package:queen_ott_app/screens/test_home_screen.dart';
import 'package:queen_ott_app/pages/trending_screen_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  List<Widget> _widgetOptions = <Widget>[
    HomeScreenWidget(),
    TrendingScreenWidget(),
    Text(
      'Index 2: Subscription',
      style: optionStyle,
    ),
    // TestPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
            Text(
              'QUEEN',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
                fontFamily: 'Roboto',
                fontSize: 25.0,
              ),
            ),
            Container(
              height: 50,
              child: Image.asset('assets/logo.png'),
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
            icon: Icon(Icons.search),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions_sharp),
            label: 'Subscription',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[600],
        onTap: _onItemTapped,
      ),
      body: Container(
        child: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      ),
    );
  }
}
