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
  bool isLoading = false;

  Future<void> fetchSeriesList() async {
    await context
        .read<SeriesFetchingService>()
        .fetchSeriesList(context)
        .whenComplete(() {
      setState(() {
        gridContents = context.read<SeriesFetchingService>().getSeriesList();
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    super.initState();
    print('init');
    fetchSeriesList();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: screenHeight * 0.2,
            width: screenWidth,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: gridContents.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SeriesDetailScreen(gridContents[index]);
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.pink),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        gridContents[index].getSeriesThumbnail(),
                        fit: BoxFit.cover,
                        height: screenHeight * 0.20,
                        width: screenWidth * 0.30,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
