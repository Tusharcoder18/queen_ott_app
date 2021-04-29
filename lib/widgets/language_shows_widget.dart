import 'package:flutter/material.dart';

class LanguageShowsWidget extends StatelessWidget {
  final List<String> languages = [
    'Hindi',
    'English',
    'Punjabi',
    'Telugu',
    'Bengali',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.2,
      width: screenWidth,
      child: ListView.builder(
          itemCount: languages.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: screenHeight*0.2,
                width: screenWidth*0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.green, Colors.lightBlueAccent]),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    languages[index],
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
