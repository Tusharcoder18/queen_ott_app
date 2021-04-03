import 'package:flutter/material.dart';
import 'package:queen_ott_app/screens/temp_season_show_Screen.dart';
import 'package:queen_ott_app/screens/upload_screen.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';

class ShowGridViewWidget extends StatelessWidget {
  ShowGridViewWidget({this.seriesThumbnailList, this.seriesList});

  final List<String> seriesThumbnailList;
  final List<dynamic> seriesList;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 12,
      children: List.generate(seriesThumbnailList.length, (index) {
        return InkWell(
          onTap: () async{
            await context.read<SeriesFetchingService>().getSeasonAneEpisodeInfo(inputDocument: seriesList[index]);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TempSeasonShowScreen(
                  videoThumbnail: seriesThumbnailList[index],
                  indexNumber: index,
                  consumerDocument: seriesList[index].toString(),
                ),
              ),
            );
          },
          child: Container(
            height: 300,
            child: Hero(
              tag: 'imageHero$index',
              child: Image.network(
                seriesThumbnailList[index],
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      }),
    );
  }
}
