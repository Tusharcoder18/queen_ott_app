import 'package:flutter/material.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';
import 'package:provider/provider.dart';

class TempSeasonShowScreen extends StatefulWidget {
  TempSeasonShowScreen(
      {this.videoThumbnail, this.indexNumber, this.consumerDocument});

  final String videoThumbnail;
  final int indexNumber;
  final String consumerDocument;

  @override
  _TempSeasonShowScreenState createState() => _TempSeasonShowScreenState();
}

class _TempSeasonShowScreenState extends State<TempSeasonShowScreen> {
  List<dynamic> _seasonList = [];

  void getSeasonList() {
    _seasonList =
        context.read<SeriesFetchingService>().returnSeasonAndEpisodeInfo();
    print(_seasonList);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSeasonList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Hero(
                  tag: 'imageHero${widget.indexNumber}',
                  child: Image.network(
                    widget.videoThumbnail,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blueGrey,
                  child: ListView.builder(
                    itemCount: _seasonList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 200,
                        width: 300,
                        color: Colors.black,
                        child: Column(
                          children: [
                            Text('Season ${index + 1}'),
                            Container(
                              height: _seasonList[index].length.toDouble() * 40,
                              child: ListView.builder(
                                itemCount: _seasonList[index].length,
                                itemBuilder: (context, eIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () async {
                                        final videoUrl = await context
                                            .read<SeriesFetchingService>()
                                            .getUrl(
                                                videoDocument:
                                                    _seasonList[index][eIndex]
                                                        .toString());
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Test(
                                              videoUrl: videoUrl.toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 30,
                                        child: Text('Episode${eIndex + 1}'),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    },
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
