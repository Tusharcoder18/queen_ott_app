import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/models/series.dart';
import 'package:queen_ott_app/screens/series_details_screen.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';

class SeriesGridWidget extends StatefulWidget {
  SeriesGridWidget({
    this.physics,
  });

  final ScrollPhysics physics;

  @override
  _SeriesGridWidgetState createState() => _SeriesGridWidgetState();
}

class _SeriesGridWidgetState extends State<SeriesGridWidget> {
  List<Series> gridContents = [];

  @override
  void initState() {
    super.initState();
    // print('init');
    // context
    //     .read<SeriesFetchingService>()
    //     .fetchSeriesList(context)
    //     .whenComplete(() {
    //   setState(() {
    gridContents = context.read<SeriesFetchingService>().getSeriesList();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.42,
      child: GridView.count(
        // Creates a 2 row scrollable listview
        crossAxisCount: 3,
        physics: widget.physics,
        childAspectRatio: 0.8,
        children: List.generate(gridContents.length, (index) {
          // print(gridContents[index].getSeriesTitle());
          return GestureDetector(
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SeriesDetailScreen(gridContents[index]);
              }));
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: screenWidth * 0.37,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.pink),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          gridContents[index].getSeriesThumbnail(),
                          fit: BoxFit.cover,
                          height: screenWidth * 0.54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
