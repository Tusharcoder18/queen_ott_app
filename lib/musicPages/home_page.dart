import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 50,),
              MusicHorizontalScrollWidget(headingText: 'Trending Playlist',),
              SizedBox(height: 50,),
              MusicHorizontalScrollWidget(headingText: 'Featured This week',),
              SizedBox(height: 50,),
              MusicHorizontalScrollWidget(headingText: 'New Arrival',),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}

class MusicHorizontalScrollWidget extends StatelessWidget {

  MusicHorizontalScrollWidget({@required this.headingText});

  final String headingText;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(headingText),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/musicImage1.jpg'),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/musicImage2.jpg'),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/musicImage3.jpg'),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/musicImage4.jpg'),
                ),
                SizedBox(width: 10,),
              ],
            ),
          ),
        )
      ],
    );
  }
}
