import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/screens/add_description_screen.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:queen_ott_app/widgets/custom_button.dart';
import 'dart:io';
import '../services/upload_service.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
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
                // await generateThumbnail();
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
                    CreateATitleWidget(screenHeight: screenHeight),
                    AddDescriptionWidget(
                        screenHeight: screenHeight, screenWidth: screenWidth),
                    AddToPlaylistWidget(screenHeight: screenHeight),
                    // This would be a drop down list
                    SelectGenreWidget(screenHeight: screenHeight),
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
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        child: Text("Temp next Page for player"),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Test()));
                        },
                      ),
                    )
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
          name: "video1",
          genre: genre,
        );
        String videoUrl = urls[0];
        String thumbnailUrl = urls[1];
        isLoading = false;
        print(videoUrl);
        print(thumbnailUrl);
        setState(() {});

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
                Provider.of<UploadService>(context, listen: false)
                            .returnVideoDescription() !=
                        ''
                    ? Provider.of<UploadService>(context, listen: false)
                        .returnVideoDescription()
                    : 'Add Description',
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

class SelectGenreWidget extends StatefulWidget {
  const SelectGenreWidget({
    Key key,
    @required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  _SelectGenreWidgetState createState() => _SelectGenreWidgetState();
}

class _SelectGenreWidgetState extends State<SelectGenreWidget> {
  bool showOptions = false;
  IconData arrowIcon = Icons.keyboard_arrow_down_sharp;

  void changeShowOptions() {
    if (!showOptions) {
      showOptions = true;
      arrowIcon = Icons.keyboard_arrow_up_sharp;
    } else {
      showOptions = false;
      arrowIcon = Icons.keyboard_arrow_down_sharp;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0),
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              height: widget.screenHeight * 0.1,
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
                    arrowIcon,
                    color: Colors.white38,
                    size: 35.0,
                  )
                ],
              ),
            ),
            onTap: () {
              changeShowOptions();
            },
          ),
          showOptions == false
              ? Container()
              : Column(
                  children: [
                    CheckBoxListVale(
                      itemName: 'Action',
                    ),
                    CheckBoxListVale(
                      itemName: 'Animation',
                    ),
                    CheckBoxListVale(
                      itemName: 'Crime',
                    ),
                    CheckBoxListVale(
                      itemName: 'Comedy',
                    ),
                    CheckBoxListVale(
                      itemName: 'Drama',
                    ),
                    CheckBoxListVale(
                      itemName: 'Fantasy',
                    ),
                    CheckBoxListVale(
                      itemName: 'Historical',
                    ),
                    CheckBoxListVale(
                      itemName: 'Horror',
                    ),
                    CheckBoxListVale(
                      itemName: 'Romance',
                    ),
                  ],
                )
        ],
      ),
    );
  }
}

class CheckBoxListVale extends StatefulWidget {
  CheckBoxListVale({this.itemName});

  final String itemName;

  @override
  _CheckBoxListValeState createState() => _CheckBoxListValeState();
}

class _CheckBoxListValeState extends State<CheckBoxListVale> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.itemName),
      value: _checked,
      onChanged: (bool value) {
        setState(() {
          if (!_checked) {
            _checked = true;
            genre = widget.itemName;
            print(widget.itemName);
          } else {
            _checked = false;
            genre = "";
          }
        });
      },
    );
  }
}
