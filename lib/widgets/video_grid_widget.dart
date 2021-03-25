import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:queen_ott_app/services/upload_service.dart';

class VideoGridWidget extends StatefulWidget {
  Function
      fetchVideoDetails; // We can use this to fetch future video types such as recommended, continue watching, language based, etc.
  VideoGridWidget({this.fetchVideoDetails});
  @override
  _VideoGridWidgetState createState() => _VideoGridWidgetState();
}

class _VideoGridWidgetState extends State<VideoGridWidget> {
  bool isLoading = true;
  List<DocumentSnapshot> documents = [];

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
      documents.length = 7;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String videoUrl, thumbnailUrl;
    return Container(
      height: screenHeight * 0.4,
      child: GridView.count(
        // Creates a 2 row scrollable listview
        crossAxisCount: 2,
        scrollDirection: Axis.horizontal,
        childAspectRatio: 1.2,
        children: List.generate(documents.length, (index) {
          if (widget.fetchVideoDetails != null) {
            videoUrl = documents[index].data()['videoUrl'] ?? '';
            thumbnailUrl = documents[index].data()['thumbnailUrl'] ?? '';
          }
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Test(
                            videoUrl: videoUrl,
                            thumbnailUrl: thumbnailUrl,
                          )));
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
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.pink),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: thumbnailUrl != null
                            ? Image.network(
                                thumbnailUrl,
                                fit: BoxFit.cover,
                                height: screenWidth * 0.54,
                              )
                            : Image.asset(
                                'assets/movieTwo.jpg',
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
