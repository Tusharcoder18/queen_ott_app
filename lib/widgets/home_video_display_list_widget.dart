import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:queen_ott_app/services/upload_service.dart';

class HomeVideoListWidget extends StatefulWidget {
  @override
  _HomeVideoListWidgetState createState() => _HomeVideoListWidgetState();
}

class _HomeVideoListWidgetState extends State<HomeVideoListWidget> {
  List<String> videoUrls = [];
  List<String> thumbnailUrls = [];
  bool isLoading = true;

  Future<void> getDetails() async {
    await Provider.of<UploadService>(context, listen: false).getCurrentUrls();
    videoUrls =
        Provider.of<UploadService>(context, listen: false).returnVideoUrls();
    thumbnailUrls = Provider.of<UploadService>(context, listen: false)
        .returnThumbnailUrls();
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
        itemCount: videoUrls.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Test(
                            videoUrl: videoUrls[index],
                            thumbnailUrl: thumbnailUrls[index],
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 100,
                width: 200,
                child: thumbnailUrls[index] != null
                    ? Image.network(
                        thumbnailUrls[index],
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
