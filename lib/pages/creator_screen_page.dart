import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:queen_ott_app/screens/upload_screen.dart';
import '../widgets/custom_button.dart';
import '../services/upload_service.dart';
import '../screens/upload_screen.dart';

// This is for the upload video section for content creator
class CreatorScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: screenHeight * 0.2,
            width: screenWidth,
            child: CustomButton(
              text: "UPLOAD",
              icon: Icon(FontAwesomeIcons.upload),
              color: Colors.blue[600],
              onTap: () {
                Provider.of<UploadService>(context, listen: false)
                    .videoInfoNull();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UploadScreen()));
              },
            ),
          ),
          SizedBox(
            height: screenHeight * 0.022,
          ),
          Container(
            height: 20,
            width: screenWidth,
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Uploads',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.022,
          ),
          UserUploads(),
        ],
      ),
    );
  }
}

class UserUploads extends StatefulWidget {
  @override
  _UserUploadsState createState() => _UserUploadsState();
}

class _UserUploadsState extends State<UserUploads> {
  bool isLoading = true;
  List<DocumentSnapshot> documents = [];

  Future<void> getDetails() async {
    documents = await Provider.of<UploadService>(context, listen: false)
        .getCurrentUrls();
    for (int i = 0; i < documents.length; i++) {
      print(documents[i].data()['title']);
    }
  }

  void updateDetails() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDetails().whenComplete(() => updateDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : RefreshIndicator(
                  onRefresh: getDetails,
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final videoUrl = documents[index].data()['videoUrl'];
                      final thumbnailUrl =
                          documents[index].data()['thumbnailUrl'];
                      final title = documents[index].data()['title'];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Test(
                                        videoUrl: videoUrl ?? '',
                                        thumbnailUrl: thumbnailUrl ?? '',
                                      )));
                        },
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.30,
                              child: thumbnailUrl != null
                                  ? Image.network(
                                      thumbnailUrl ?? '',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/movieThree.jpg',
                                      fit: BoxFit.cover,
                                    ),
                              width: double.infinity,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(12, 12, 16, 15),
                                  child: CircleAvatar(
                                    child: Icon(FontAwesomeIcons.user),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        title ?? '',
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.more_vert),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
