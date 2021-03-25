import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:queen_ott_app/services/upload_service.dart';

class HomeVideoListWidget extends StatefulWidget {
  @override
  _HomeVideoListWidgetState createState() => _HomeVideoListWidgetState();
}

class _HomeVideoListWidgetState extends State<HomeVideoListWidget> {
  bool isLoading = true;
  List<DocumentSnapshot> documents = [];

  Future<void> getDetails() async {
    documents = await Provider.of<UploadService>(context, listen: false)
        .getCurrentUrls();
  }

  void updateDetails() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDetails().whenComplete(
        () => updateDetails()); // Call this after layout is complete
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.4,
      child: GridView.count(
        // Creates a 2 row scrollable listview
        crossAxisCount: 2,
        scrollDirection: Axis.horizontal,
        childAspectRatio: 1.2,
        children: List.generate(documents.length, (index) {
          final videoUrl = documents[index].data()['videoUrl'];
          final thumbnailUrl = documents[index].data()['thumbnailUrl'];
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


// ListView.builder(
//             itemCount: 6,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               // final videoUrl = documents[index].data()['videoUrl'];
//               // final thumbnailUrl = documents[index].data()['thumbnailUrl'];
//               return GestureDetector(
//                 onTap: () {
//                   // Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //         builder: (context) => Test(
//                   //               videoUrl: videoUrl,
//                   //               thumbnailUrl: thumbnailUrl,
//                   //             )));
//                 },
//                 child: Container(
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: screenWidth * 0.015,
//                             right: screenWidth * 0.015),
//                         child: Container(
//                           width: screenWidth * 0.3,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             color: Colors.pink,
//                           ),
//                           // child: thumbnailUrl != null
//                           //     ? Image.network(
//                           //         thumbnailUrl,
//                           //         fit: BoxFit.cover,
//                           //         height: screenWidth * 0.54,
//                           //       )
//                           //     : Container(),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(8.0),
//                             child: Image.asset(
//                               'assets/movieTwo.jpg',
//                               fit: BoxFit.cover,
//                               height: screenWidth * 0.35,
//                               width: screenWidth * 0.3,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),