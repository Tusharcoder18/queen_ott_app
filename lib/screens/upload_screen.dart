import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/screens/content_creator_screen.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:queen_ott_app/widgets/add_description_widget.dart';
import 'package:queen_ott_app/widgets/add_series_button.dart';
import 'package:queen_ott_app/widgets/custom_button.dart';
import 'package:queen_ott_app/widgets/select_genre_widget.dart';
import 'dart:io';
import '../services/upload_service.dart';
import 'package:path_provider/path_provider.dart';

String name;
File videoFile;
File videoThumbnail;
String tempDir;
String genre;
bool isLoading = false;

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  temp(String value) => setState(() {
        genre = value;
      });

  @override
  void initState() {
    super.initState();
    getTemporaryDirectory().then((d) => tempDir = d.path);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ContentCreatorScreen()),
              (Route<dynamic> route) => false);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Add details'),
                UploadButtonWidget(),
              ],
            ),
          ),
          body: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final file =
                      await ImagePicker().getVideo(source: ImageSource.gallery);
                  videoFile = File(file.path);
                },
                child: Container(
                  height: screenHeight * 0.3,
                  width: screenWidth,
                  color: Color(0xFF343837),
                  child: videoThumbnail != null
                      ? Image.file(
                          videoThumbnail,
                          fit: BoxFit.cover,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_sharp,
                              size: 34.0,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Choose Video from device',
                              style: TextStyle(fontSize: 23.0),
                            ),
                          ],
                        ),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView(
                    children: [
                      titleWidget(context, screenHeight),
                      addDescriptionWidget(context, screenHeight, screenWidth),
                      AddSeriesButton(),
                      // This would be a drop down list
                      SelectGenreWidget(
                        screenHeight: screenHeight,
                        temp: temp,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: CustomButton(
                          text: "Select Thumbnail",
                          icon: Icon(Icons.image),
                          color: Colors.blue,
                          onTap: () async {
                            final file = await ImagePicker()
                                .getImage(source: ImageSource.gallery);
                            setState(() {
                              videoThumbnail = File(file.path);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadButtonWidget extends StatefulWidget {
  const UploadButtonWidget({
    Key key,
  }) : super(key: key);

  @override
  _UploadButtonWidgetState createState() => _UploadButtonWidgetState();
}

class _UploadButtonWidgetState extends State<UploadButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 90,
        height: 40,
        color: Colors.blue,
        child: Center(
          child: Text(
            'UPLOAD',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      onTap: () async {
        isLoading = true;
        final urls = await Provider.of<UploadService>(context, listen: false)
            .uploadVideo(
          context,
          video: videoFile,
          thumbnail: videoThumbnail,
        );
        String videoUrl = urls[0];
        String thumbnailUrl = urls[1];
        isLoading = false;
        print(videoUrl);
        print(thumbnailUrl);

        Navigator.pop(context);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Test(
                      videoUrl: videoUrl,
                      thumbnailUrl: thumbnailUrl,
                    )));
      },
    );
  }
}

Widget titleWidget(BuildContext context, double screenHeight) {
  return Padding(
    padding: const EdgeInsets.only(top: 4.0),
    child: Container(
        height: screenHeight * 0.1,
        padding: EdgeInsets.all(15.0),
        color: Color(0xFF1C1C1C),
        child: TextField(
          style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w300),
          decoration: InputDecoration(
            hintText: 'Create a title',
            hintStyle: TextStyle(fontSize: 21.0),
            border: InputBorder.none,
          ),
          autofocus: false,
          onChanged: (value) {
            name = value;
            Provider.of<UploadService>(context, listen: false)
                .getVideoTitle(value);
          },
        )
        //Text('Crete a title', style: TextStyle(fontSize: 20.0),),
        ),
  );
}
