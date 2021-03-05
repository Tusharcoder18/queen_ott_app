import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:queen_ott_app/screens/add_description_screen.dart';
import 'package:queen_ott_app/screens/upload_details_screen.dart';
import 'dart:io';
import '../services/upload_service.dart';

String name;

class UploadScreen extends StatelessWidget {
  final File videoFile;
  UploadScreen({this.videoFile});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Add details'),
              UploadButtonWidget(
                video: videoFile,
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              height: screenHeight * 0.3,
              width: screenWidth,
              color: Color(0xFF343837),
              child: Row(
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
  final File video;
  const UploadButtonWidget({
    Key key,
    this.video,
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
        String downloadUrl = await UploadService()
            .uploadVideo(video: File(video.path), name: "video1");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UploadDetailsPage(
                      videoUrl: downloadUrl,
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
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDescriptionScreen()));
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
                'Add Description',
                style: TextStyle(
                  fontSize: 21.0,
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
