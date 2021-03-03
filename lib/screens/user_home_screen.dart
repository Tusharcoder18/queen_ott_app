import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queen_ott_app/constants.dart';
import 'package:queen_ott_app/modules/home_screen_widget.dart';
import 'package:queen_ott_app/screens/test_home_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: kWhiteColor);
  List<Widget> _widgetOptions = <Widget>[
    HomeScreenWidget(),
    Text(
      'Index 1: Trending',
      style: optionStyle,
    ),
    Text(
      'Index 2: Subscription',
      style: optionStyle,
    ),
    // Text(
    //   'Index 3: Settings',
    //   style: optionStyle,
    // )
    TestPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.trending_up),
            label: 'Trending',
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
        selectedItemColor: kWhiteColor,
        onTap: _onItemTapped,
      ),
      body: Container(
        child: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      ),
    );
  }
}
