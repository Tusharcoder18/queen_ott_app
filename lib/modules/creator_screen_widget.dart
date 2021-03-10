import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/screens/upload_screen.dart';
import '../widgets/custom_button.dart';
import '../services/upload_service.dart';
import '../screens/upload_screen.dart';
import 'package:image_picker/image_picker.dart';

// This is for the upload video section for content creator
class CreatorScreenWidget extends StatelessWidget {
  final TextStyle _textStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

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
                Provider.of<UploadService>(context, listen : false).videoInfoNull();
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
              style: _textStyle,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.022,
          ),
          uploads(),
        ],
      ),
    );
  }

  Widget uploads() {
    return Expanded(
      flex: 1,
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                child: Image.asset(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Video Name",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
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
              SizedBox(
                child: Image.asset(
                  'assets/movieOne.jpg',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Video Name",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
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
              SizedBox(
                child: Image.asset(
                  'assets/movieOne.jpg',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Video Name",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
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
        ),
      ),
    );
  }
}
