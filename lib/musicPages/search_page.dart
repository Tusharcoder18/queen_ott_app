import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final double sizedBoxHeight = 20.0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: sizedBoxHeight,
            ),

            /// This is for the search textbox
            Text(
              'Search',
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0),
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),

            /// For the search bar
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 50,
              width: screenWidth * 0.92,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                child: TextField(
                  style: TextStyle(fontFamily: 'OpenSans', color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Songs',
                      fillColor: Colors.black,
                      focusColor: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),

            /// This is for the genre part
            Text(
              'Search By Genre',
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),
            Expanded(
              flex: 1,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10.0),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  GridViewGenreWidget(
                    color1: Colors.green,
                    color2: Colors.blue,
                    text: 'Pop',
                  ),
                  GridViewGenreWidget(
                    color1: Colors.pink,
                    color2: Colors.deepOrange,
                    text: 'Indie',
                  ),
                  GridViewGenreWidget(
                    color1: Colors.redAccent,
                    color2: Colors.deepPurple,
                    text: 'Bollywood',
                  ),
                  GridViewGenreWidget(
                    color1: Colors.lightBlue,
                    color2: Colors.tealAccent,
                    text: 'Punjabi',
                  ),
                  GridViewGenreWidget(
                    color1: Colors.deepOrange,
                    color2: Colors.greenAccent,
                    text: 'Party',
                  ),
                  GridViewGenreWidget(
                    color1: Colors.blue,
                    color2: Colors.pinkAccent,
                    text: 'Indian Classical',
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

class GridViewGenreWidget extends StatelessWidget {
  GridViewGenreWidget(
      {@required this.color1, @required this.color2, @required this.text});

  final Color color1;
  final Color color2;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 22.0),
        ),
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color1, color2]),
          borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
