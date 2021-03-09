import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/screens/add_description_screen.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:io';
import '../services/upload_service.dart';
import 'package:path_provider/path_provider.dart';

String name;
File videoFile;
File videoThumbnail;
File copiedVideoFile;
String tempDir;
String videoUrl;

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {

  // @override
  // void initState() {
  //   getTemporaryDirectory().then((value) => tempDir = value.path);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
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
                copiedVideoFile = videoFile;
                videoUrl = await Provider.of<UploadService>(context, listen: false).uploadVideo(video: videoFile, name: "video101");
                final uint8list = await VideoThumbnail.thumbnailFile(
                  video: copiedVideoFile.path,
                  thumbnailPath: (await getTemporaryDirectory()).path,
                  imageFormat: ImageFormat.JPEG,
                  quality: 75,
                );
                videoThumbnail = File(uint8list);
                // to update the value of videoThumbnail and videoFile
                setState(() {});
              },
              child: Container(
                height: screenHeight * 0.3,
                width: screenWidth,
                color: Color(0xFF343837),
                child: videoThumbnail != null ?
                Image.file(videoThumbnail, fit: BoxFit.cover,) :
                Row(
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
                    CreateATitleWidget(screenHeight: screenHeight),
                    AddDescriptionWidget(
                        screenHeight: screenHeight, screenWidth: screenWidth),
                    AddToPlaylistWidget(screenHeight: screenHeight),
                    // This would be a drop down list
                    SelectGenreWidget(screenHeight: screenHeight),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UploadButtonWidget extends StatelessWidget {
  const UploadButtonWidget({
    Key key,
  }) : super(key: key);

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
        // String videoDownloadUrl =
        // await Provider.of<UploadService>(context, listen: false)
        //     .uploadVideo(video: videoFile, name: "video1");
        String thumbnailDownloadUrl = await Provider.of<UploadService>(context, listen: false)
            .uploadThumbnail(video: videoThumbnail, name: "video1Thumbnail");

        print("videThumbnail : $thumbnailDownloadUrl");
        //await UploadService().uploadVideo(video: videoFile, name: "video1");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Test(
                      videoUrl: videoUrl,
                    )));
      },
    );
  }
}

class CreateATitleWidget extends StatelessWidget {
  const CreateATitleWidget({
    Key key,
    @required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
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
}

class AddDescriptionWidget extends StatelessWidget {
  const AddDescriptionWidget({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddDescriptionScreen()));
        },
        child: Container(
          height: screenHeight * 0.1,
          padding: EdgeInsets.all(16.0),
          color: Color(0xFF1C1C1C),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                FontAwesomeIcons.pen,
                color: Colors.white38,
                size: 20.0,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                Provider.of<UploadService>(context, listen: true)
                    .returnVideoDescription() ==
                    ''
                    ? 'Add Description'
                    : Provider.of<UploadService>(context, listen: true)
                    .returnVideoDescription(),
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white38,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.35,
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white38,
                size: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddToPlaylistWidget extends StatelessWidget {
  const AddToPlaylistWidget({
    Key key,
    @required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0),
      child: Container(
        height: screenHeight * 0.1,
        padding: EdgeInsets.all(16.0),
        color: Color(0xFF1C1C1C),
        child: Row(
          children: [
            Icon(
              Icons.playlist_add,
              color: Colors.white38,
              size: 25.0,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Add to playlist',
              style: TextStyle(
                fontSize: 21.0,
                color: Colors.white38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectGenreWidget extends StatelessWidget {
  const SelectGenreWidget({
    Key key,
    @required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0),
      child: Container(
        height: screenHeight * 0.1,
        padding: EdgeInsets.all(16.0),
        color: Color(0xFF1C1C1C),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Genre',
              style: TextStyle(
                fontSize: 21.0,
                color: Colors.white38,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Colors.white38,
              size: 35.0,
            )
          ],
        ),
      ),
    );
  }
}
