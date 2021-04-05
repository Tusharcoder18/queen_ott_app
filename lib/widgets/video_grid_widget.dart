import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:queen_ott_app/screens/season_details_screen.dart';

class VideoGridWidget extends StatefulWidget {
  final Function
      fetchVideoDetails; // We can use this to fetch future video types such as recommended, continue watching, language based, etc.
  final int count;
  final ScrollPhysics physics;
  VideoGridWidget({this.fetchVideoDetails, this.count, this.physics});
  @override
  _VideoGridWidgetState createState() => _VideoGridWidgetState();
}

class _VideoGridWidgetState extends State<VideoGridWidget> {
  bool isLoading = true;
  String videoUrl;
  String thumbnailUrl;
  List<DocumentSnapshot> documents = [];
  List<String> temp = [
    'assets/movieOne.jpg',
    'assets/movieThree.jpg',
    'assets/movieTwo.jpg',
    'assets/movieOne.jpg',
    'assets/movieThree.jpg',
    'assets/movieTwo.jpg',
    'assets/movieTwo.jpg',
    'assets/movieOne.jpg',
    'assets/movieThree.jpg',
    'assets/movieTwo.jpg',
    'assets/movieOne.jpg',
    'assets/movieThree.jpg',
    'assets/movieOne.jpg',
    'assets/movieThree.jpg',
  ];

  Future<void> getDetails() async {
    documents = await widget.fetchVideoDetails();
  }

  void updateDetails() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.fetchVideoDetails != null) {
      getDetails().whenComplete(
          () => updateDetails()); // Call this after layout is complete
    } else {
      documents.length = widget.count;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.42,
      child: GridView.count(
        // Creates a 2 row scrollable listview
        crossAxisCount: 3,
        physics: widget.physics,
        childAspectRatio: 0.8,
        children: List.generate(documents.length, (index) {
          if (widget.fetchVideoDetails != null) {
            videoUrl = documents[index].data()['videoUrl'] ?? '';
            thumbnailUrl = documents[index].data()['thumbnailUrl'] ?? '';
          }
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SeasonDetailScreen()));
            },
            child: Container(
              // margin: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: screenWidth * 0.37,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.pink),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: (thumbnailUrl != null && thumbnailUrl != '')
                            ? Image.network(
                                thumbnailUrl,
                                fit: BoxFit.cover,
                                height: screenWidth * 0.54,
                              )
                            : Image.asset(
                                temp[index],
                                fit: BoxFit.cover,
                                height: screenWidth * 0.37,
                                width: screenWidth * 0.3,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
