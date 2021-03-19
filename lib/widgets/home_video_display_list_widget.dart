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
    getDetails().whenComplete(() => updateDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: documents.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final videoUrl = documents[index].data()['videoUrl'];
          final thumbnailUrl = documents[index].data()['thumbnailUrl'];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Test(
                            videoUrl: videoUrl,
                            thumbnailUrl: thumbnailUrl,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 100,
                width: 200,
                child: thumbnailUrl != null
                    ? Image.network(
                        thumbnailUrl,
                        fit: BoxFit.fitWidth,
                      )
                    : Container(),
              ),
            ),
          );
        },
      ),
    );
  }
}
