import 'package:flutter/material.dart';
import 'package:queen_ott_app/screens/season_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/series_fetching_service.dart';

class ShowGridViewWidget extends StatelessWidget {
  ShowGridViewWidget({this.seriesThumbnailList, this.seriesList});

  final List<String> seriesThumbnailList;
  final List<dynamic> seriesList;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        child: GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 0.8,
          crossAxisSpacing: 6,
          mainAxisSpacing: 10,
          children: List.generate(seriesThumbnailList.length,(index) {
            return InkWell(
              onTap: () async{
                await context.read<SeriesFetchingService>().getSeasonAneEpisodeInfo(inputDocument: seriesList[index]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeasonDetailScreen(
                      videoThumbnail: seriesThumbnailList[index],
                      indexNumber: index,
                      consumerDocument: seriesList[index].toString(),
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: FadeInImage(
                    placeholder: NetworkImage(seriesThumbnailList[index]),
                    image: NetworkImage(seriesThumbnailList[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}


