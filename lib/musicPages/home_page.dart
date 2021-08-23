import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/constants.dart';
import 'package:queen_ott_app/musicPages/musicService/music_fetching_service.dart';
import 'package:queen_ott_app/musicPages/my_app_audio.dart';
import 'package:queen_ott_app/widgets/loading_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  List<List<String>> _musicList = [];
  List<List<String>> _musicThisWeekList = [];
  List<List<String>> _musicNewArrivalList = [];
  Future<void> getMusicInfo() async {
    final list = await context
        .read<MusicFetchingService>()
        .getMusicInfo(collectionName: 'MusicInformation');
    _musicList = list;

    _musicThisWeekList =
        context.read<MusicFetchingService>().returnThisWeekList();
    _musicNewArrivalList =
        context.read<MusicFetchingService>().returnNewArrivalList();

    if ((_musicList.length > 0) &&
        (_musicThisWeekList.length > 0) &&
        (_musicNewArrivalList.length > 0)) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    getMusicInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? LoadingWidget()
        : ListView(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            color: kGoldenColor,
                            fontFamily: 'OpenSans',
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    MusicHorizontalScrollWidget(
                      headingText: 'Trending Playlist',
                      musicList: _musicList,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    MusicHorizontalScrollWidget(
                      headingText: 'Featured This week',
                      musicList: _musicThisWeekList,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    MusicHorizontalScrollWidget(
                      headingText: 'New Arrival',
                      musicList: _musicNewArrivalList,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ]);
  }
}

class MusicHorizontalScrollWidget extends StatefulWidget {
  MusicHorizontalScrollWidget(
      {@required this.headingText, @required this.musicList});

  final String headingText;
  final List<List<String>> musicList;

  @override
  _MusicHorizontalScrollWidgetState createState() =>
      _MusicHorizontalScrollWidgetState();
}

class _MusicHorizontalScrollWidgetState
    extends State<MusicHorizontalScrollWidget> {
  List<List<String>> _musicList = [];

  Future<void> getMusicListInformation() async {
    _musicList = widget.musicList;
    setState(() {});
  }

  @override
  void initState() {
    getMusicListInformation();
    super.initState();
  }

  /// index 0 -> name of the music
  /// index 1 -> image location
  /// index 2 -> file location

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.headingText,
          style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _musicList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyAppAudio(
                            musicList: _musicList,
                            currentIndex: index,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.14,
                            child: CachedNetworkImage(
                              imageUrl: _musicList[index][1],
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _musicList[index][0],
                            style: TextStyle(fontFamily: 'OpenSans'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
