import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/models/season.dart';
import 'package:queen_ott_app/models/series.dart';
import 'package:queen_ott_app/services/video_fetching_service.dart';

class SeriesFetchingService extends ChangeNotifier {
  SeriesFetchingService(this._firebaseFirestore);

  FirebaseFirestore _firebaseFirestore;

  final String consumerSeries = "ConsumerSeries";
  List<Series> _seriesList = [];

  /// To fetch all the series that are there in the database
  Future<void> fetchSeriesList(BuildContext context) async {
    _seriesList = [];
    final collection =
        await _firebaseFirestore.collection(consumerSeries).get();
    final List<DocumentSnapshot> documents = collection.docs;

    documents.forEach((element) async {
      final seriesTitle = element.data()["SeriesName"];
      //Error here!
      final seriesDescription = 'Temporary description';
      final seriesThumbnail = element.data()["thumbnail"];
      final seriesGenre = ['Action', 'Animation'];
      final episodes = context.read<VideoFetchingService>().getVideos();
      final seriesSeasons = [Season(1, episodes)];

      Series series = Series(seriesTitle, seriesDescription, seriesThumbnail,
          seriesGenre, seriesSeasons);
      _seriesList.add(series);
    });
  }

  List<Series> getSeriesList() {
    return _seriesList;
  }

  List<dynamic> _seasonList = [];

  /// To get the number of seasons in a given series
  Future<void> getSeasonAndEpisodeInfo({String inputDocument}) async {
    _seasonList = [];
    final collection = await _firebaseFirestore
        .collection(consumerSeries)
        .doc(inputDocument)
        .collection("Seasons")
        .get();
    final List<DocumentSnapshot> documents = collection.docs;

    documents.forEach((element) {
      _seasonList.add(element.data()["Episodes"]);
    });

    print(_seasonList);
  }

  List<dynamic> returnSeasonAndEpisodeInfo() {
    return _seasonList;
  }
}
