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
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListView.builder(
          itemCount: languages.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: screenWidth * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.green, Colors.lightBlueAccent]),
                ),
                child: Center(
                    child: Text(
                  languages[index],
                  style: Theme.of(context).textTheme.headline1,
                )),
              ),
            );
          }),
    );
  }
}
