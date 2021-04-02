import 'package:flutter/material.dart';
import 'package:queen_ott_app/services/add_series_services.dart';
import 'package:provider/provider.dart';

class SeasonListScreen extends StatefulWidget {
  @override
  _SeasonListScreenState createState() => _SeasonListScreenState();
}

class _SeasonListScreenState extends State<SeasonListScreen> {
  List<Widget> _seasonList = [];

  void initialiseLIst() {
    _seasonList = <Widget>[
      SeasonListInfo(
        indexNumber: 1,
        episodeNumber: context.read<AddSeriesServices>().returnEpisodeNumber(),
      )
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    initialiseLIst();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seasons',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: ListView.builder(
                  itemCount: _seasonList.length,
                  itemBuilder: (context, index) {
                    return _seasonList[index];
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            /// Create new series button
            GestureDetector(
              onTap: () {
                print("Add new season pressed");
                print(_seasonList.length);
                setState(() {
                  _seasonList.add(
                    SeasonListInfo(
                      textInfo: "Season " + (_seasonList.length + 1).toString(),
                      episodeNumber: context
                          .read<AddSeriesServices>()
                          .returnEpisodeNumber(),
                      indexNumber: _seasonList.length + 1,
                    ),
                  );
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 80,
                width: MediaQuery.of(context).size.width,
                color: Color(0xFF121212),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Text(
                        'Add new season',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
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

class SeasonListInfo extends StatefulWidget {
  SeasonListInfo(
      {this.textInfo = "Season 1", this.indexNumber, this.episodeNumber});

  final String textInfo;
  final int indexNumber;
  final int episodeNumber;

  @override
  _SeasonListInfoState createState() => _SeasonListInfoState();
}

class _SeasonListInfoState extends State<SeasonListInfo> {
  List<dynamic> _seasonEpisodeList = <dynamic>[];
  bool _checked = false;

  Future<void> setSeasonList() async {
    print("This function is called");
    _seasonEpisodeList = await context.read<AddSeriesServices>().getEpisodeInfo(
        indexNumber: widget.indexNumber, episodeNumber: widget.episodeNumber);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      setSeasonList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _seasonEpisodeList.length.toDouble() * 60,
      child: Column(
        children: [
          CheckboxListTile(
            title: Text(
              widget.textInfo,
              style: Theme.of(context).textTheme.headline1,
            ),
            value: _checked,
            onChanged: (bool value) {
              setState(() {
                if (_checked)
                  _checked = false;
                else
                  _checked = true;
              });
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: _seasonEpisodeList.length.toDouble() * 40,
            child: ListView.builder(
                itemCount: _seasonEpisodeList.length,
                itemBuilder: (context, index) {
                  return SeasonEpisodeNameWidget(
                      episodeName: _seasonEpisodeList[index]);
                }),
          ),
        ],
      ),
    );
  }
}

class SeasonEpisodeNameWidget extends StatelessWidget {
  SeasonEpisodeNameWidget({@required this.episodeName});

  final dynamic episodeName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.height,
      child: Center(
        child: Text(
          episodeName,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
