import 'package:flutter/material.dart';

class MusicPlayerScreen extends StatefulWidget {
  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Queen Music Player'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
      ),
    );
  }
}
