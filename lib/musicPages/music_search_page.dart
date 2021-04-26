import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/constants.dart';
import 'package:queen_ott_app/musicPages/musicService/music_fetching_service.dart';
import 'package:queen_ott_app/musicPages/my_app_audio.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<List<String>> musicList = [];
  List<String> musicNameList = [];

  void fetchList() {
    musicList = context.read<MusicFetchingService>().returnMusicList();
    musicList.forEach((element) {
      musicNameList.add(element[0]);
    });
    print(musicNameList);
  }

  @override
  void initState() {
    fetchList();
    super.initState();
  }
  final double sizedBoxHeight = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: sizedBoxHeight,
            ),

            /// This is for the search textbox
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search',
                    style: TextStyle(
                      color: kGoldenColor,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: kGoldenColor,
                      size: 32,
                    ),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: DataSearch(
                            musicList: musicList, musicNameList: musicNameList),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),

            /// This is for the genre part
            Text(
              'Search By Genre',
              style: TextStyle(
                color: kGoldenColor,
                  fontFamily: 'OpenSans',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),
            Expanded(
              flex: 1,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10.0),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  GridViewGenreWidget(
                    color1: Colors.green,
                    color2: Colors.blue,
                    text: 'Pop',
                  ),
                  GridViewGenreWidget(
                    color1: Colors.pink,
                    color2: Colors.deepOrange,
                    text: 'Indie',
                  ),
                  GridViewGenreWidget(
                    color1: Colors.redAccent,
                    color2: Colors.deepPurple,
                    text: 'Bollywood',
                  ),
                  GridViewGenreWidget(
                    color1: Colors.lightBlue,
                    color2: Colors.tealAccent,
                    text: 'Punjabi',
                  ),
                  GridViewGenreWidget(
                    color1: Colors.deepOrange,
                    color2: Colors.greenAccent,
                    text: 'Party',
                  ),
                  GridViewGenreWidget(
                    color1: Colors.blue,
                    color2: Colors.pinkAccent,
                    text: 'Indian Classical',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridViewGenreWidget extends StatelessWidget {
  GridViewGenreWidget(
      {@required this.color1, @required this.color2, @required this.text});

  final Color color1;
  final Color color2;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 22.0),
        ),
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color1, color2]),
          borderRadius: BorderRadius.circular(5.0)),
    );
  }
}

/// Search Functionality implementation
class DataSearch extends SearchDelegate<String> {
  DataSearch({@required this.musicList, @required this.musicNameList});

  final List<List<String>> musicList;
  final List<String> musicNameList;
  final List<String> recentMusic = [];
  int currentIndex = 0;

  @override
  List<Widget> buildActions(BuildContext context) {
    // What kind of actions you want to perform in the search bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyAppAudio(
                musicList: musicList,
                currentIndex: currentIndex,
              ),
            ),
          );
        },
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width * 0.97,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: Image.network(musicList[currentIndex][1]),
              ),
              SizedBox(
                width: 20,
              ),
              Text(musicList[currentIndex][0]),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something

    final suggestionList = query.isEmpty
        ? []
        : musicNameList.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          currentIndex = musicNameList.indexWhere(
            (p) => p.startsWith(query),
          );
          showResults(context);
        },
        leading: Icon(Icons.audiotrack),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey)),
              ]),
        ),
      ),
    );
  }
}
