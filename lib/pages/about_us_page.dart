import 'package:flutter/material.dart';

/// This page would contain the about us information

class AboutUs extends StatelessWidget {
  final paragraphStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 14.0,
  );

  final headingStyle = TextStyle(
      fontFamily: 'OpenSans', fontSize: 16.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Queen (The division of Six String Entertainment Private Limited) is a video"
                  "streaming service that offers a wide variety of genres from drama, horror, "
                  "suspense, thriller to comedy & beyond. It is a division of Six String"
                  "Entertainment Private limited. Queen is the Group’s foray into the Digital"
                  "Entertainment space.",
                  style: paragraphStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'What is in store?',
                  style: headingStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Queen (Te division of Six String Entertainment Private Limited) offers fresh,"
                  "original and exclusive stories. Tailored especially for Indians across the globe,"
                  "the platform hosts premium, high quality shows featuring popular celebrities,"
                  "acclaimed writers, and award winning. ",
                  style: paragraphStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'How are we different from the other OTT Apps.',
                  style: headingStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "i) Its an excellent platform for talented, prodigious and award winning directors"
                    "to upload their content directly in the Queen App (Te division of Six String"
                    "Entertainment Private Limited) and earn huge revenues for themselves unlike"
                    "the other OTT Apps.\n\n"
                    "ii) Apart from just being a video streaming app, Queen (Te division of Six"
                    "String Entertainment Private Limited) has collaborated with Six String School"
                    "Of Music and Technology to integrate Online Music Lessons technology in the"
                    "Queen Portal making it fun for the subscribers of Queen App (Te division of"
                    "Six String Entertainment Private Limited) to learn music at throwaway price"
                    "just by subscribing in the App itself.\n\n"
                    "iii) Apart from just being a video streaming app, Queen (Te division of Six"
                    "String Entertainment Private Limited) has Collaborated with TeGlobe -"
                    "World Own news Channel (A Division Of Six String Entertainment Private"
                    "Limited) to cater Online, Trending, International and regional news at free of"
                    "cost.", style: paragraphStyle,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("How User-friendly are we ?", style: headingStyle,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Queen (Te division of Six String Entertainment Private Limited) will host"
                  "shows in various languages, catering to our regional language speakers, both in"
                  "India and abroad. It is valuable across multiple interfaces ranging from desktops,"
                  "laptops, tablets, smart-phones to internet-ready television. ", style: paragraphStyle,),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
