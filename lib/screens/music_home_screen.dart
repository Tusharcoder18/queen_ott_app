import 'package:flutter/material.dart';
import 'package:queen_ott_app/musicPages/home_page.dart';
import 'package:queen_ott_app/musicPages/music_search_page.dart';

/// This is the home screen for the music

class MusicHomeScreen extends StatefulWidget {
  @override
  _MusicHomeScreenState createState() => _MusicHomeScreenState();
}

class _MusicHomeScreenState extends State<MusicHomeScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOption = <Widget>[
    HomePage(),
    SearchPage(),
    //LibraryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: _widgetOption.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'search',
            ),

            // BottomNavigationBarItem(
            //   icon: Icon(Icons.audiotrack_rounded),
            //   label: 'Library',
            // ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
