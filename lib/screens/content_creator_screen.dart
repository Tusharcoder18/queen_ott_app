import 'package:flutter/material.dart';
import 'package:queen_ott_app/pages/creator_screen_page.dart';
import 'package:queen_ott_app/pages/settings_page.dart';

class ContentCreatorScreen extends StatefulWidget {
  @override
  _ContentCreatorScreenState createState() => _ContentCreatorScreenState();
}

class _ContentCreatorScreenState extends State<ContentCreatorScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Analytics',
    ),
    CreatorScreenWidget(),
    Text(
      'Index 2: Monetization',
    ),
    // TestPage(),
    SettingsPage(
      isCreator: true,
    ),
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
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 30),
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
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection_sharp),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Monetization',
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
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
