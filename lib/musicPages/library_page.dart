import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final double sizedBoxHeight = 20.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Music',
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: sizedBoxHeight,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                child: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        text: 'Playlist',
                      ),
                      Tab(
                        text: 'Artists',
                      ),
                      Tab(
                        text: 'Albums',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    PlaylistDisplayWidget(),
                    ArtistsDisplayWidget(),
                    AlbumsDisplayWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// This is for the albums display widget
class AlbumsDisplayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          'You do not have any albums yet',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// This is for the Artist Section
class ArtistsDisplayWidget extends StatelessWidget {
  final List<Widget> _artistList = <Widget>[
    ArtistInfoWidget(),
    ArtistInfoWidget(),
    ArtistInfoWidget(),
    ArtistInfoWidget(),
    ArtistInfoWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _artistList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: _artistList[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ArtistInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/musicImage4.jpg',
                fit: BoxFit.fill,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              'Arijit Singh',
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

/// This is for the playlist Section
class PlaylistDisplayWidget extends StatelessWidget {
  final List<Widget> _playListWidget = <Widget>[
    PlayListInfoWidget(),
    PlayListInfoWidget(),
    PlayListInfoWidget(),
    PlayListInfoWidget(),
    PlayListInfoWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: _playListWidget.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _playListWidget[index],
                );
              },
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
            child: Center(
              child: Text(
                'Create A playlist',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PlayListInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/movieOne.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coding Mode',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                Text(
                  'by Random',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
