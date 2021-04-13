import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:queen_ott_app/models/video.dart';

class VideoFetchingService extends ChangeNotifier {
  VideoFetchingService(this._firebaseFirestore);

  FirebaseFirestore _firebaseFirestore;

  final String videoInfo = "VideoInfo";
  // List<dynamic> _videoList = [];
  // List<String> _videoThumbnail = [];
  // List<String> _videoUrlList = [];
  // List<String> _videoNameList = [];
  // List<String> _videoDescriptionList = [];
  List<Video> _videos = [];

  // List<List<String>> _genreList = [];
  // List<String> _genreCollectionList = [
  //   "VideoActionCollection",
  //   "VideoAnimationCollection",
  //   "VideoCrimeCollection",
  //   "VideoComedyCollection",
  //   "VideoDramaCollection",
  //   "VideoFantasyCollection",
  //   "VideoHistoricalCollection",
  //   "VideoHorrorCollection",
  //   "VideoRomanceCollection"
  // ];
  //
  // /// The list contains all the list for all the genre

  /// This is the list for all the genre
  List<String> _actionList = [];
  List<String> _animationList = [];
  List<String> _crimeList = [];
  List<String> _comedyList = [];
  List<String> _dramaList = [];
  List<String> _fantasyList = [];
  List<String> _historicalList = [];
  List<String> _horrorList = [];
  List<String> _romanceList = [];

  /// The variables are for the collection fetching
  String _videoActionCollection = "VideoActionCollection";
  String _videoAnimationCollection = "VideoAnimationCollection";
  String _videoCrimeCollection = "VideoCrimeCollection";
  String _videoComedyCollection = "VideoComedyCollection";
  String _videoDramaCollection = "VideoDramaCollection";
  String _videoFantasyCollection = "VideoFantasyCollection";
  String _videoHistoricalCollection = "VideoHistoricalCollection";
  String _videoHorrorCollection = "VideoHorrorCollection";
  String _videoRomanceCollection = "VideoRomanceCollection";

  /// To fetch all the videos that are there in the database
  Future<void> fetchVideoList() async {
    // _videoList = [];
    // _videoThumbnail = [];
    // _videoUrlList = [];
    // _videoNameList = [];
    // _videoDescriptionList = [];
    _videos = [];
    final collection = await _firebaseFirestore.collection(videoInfo).get();
    final List<DocumentSnapshot> documents = collection.docs;

    documents.forEach((element) {
      // _videoList.add(element.id.toString());
      // _videoThumbnail.add(element.data()["thumbnailUrl"]);
      // _videoUrlList.add(element.data()["videoUrl"]);
      // _videoNameList.add(element.data()["title"]);
      // _videoDescriptionList.add(element.data()["description"]);
      final videoTitle = element.data()["title"];
      final videoDescription = element.data()["description"];
      final thumbnailUrl = element.data()["thumbnailUrl"];
      final videoUrl = element.data()["videoUrl"];

      Video video = Video(videoTitle, videoDescription, thumbnailUrl, videoUrl);
      _videos.add(video);
    });
  }

  Future<void> fetchVideoListSubset(List<String> titles) async {
    // _videoThumbnail = [];
    // _videoUrlList = [];
    _videos = [];
    final collection = await _firebaseFirestore.collection(videoInfo).get();
    final List<DocumentSnapshot> documents = collection.docs;

    documents.forEach((element) {
      if (titles.contains(element.data()['title'])) {
        final videoTitle = element.data()["title"];
        final videoDescription = element.data()["description"];
        final thumbnailUrl = element.data()["thumbnailUrl"];
        final videoUrl = element.data()["videoUrl"];

        Video video =
            Video(videoTitle, videoDescription, thumbnailUrl, videoUrl);
        _videos.add(video);
      }
    });
  }

  List<Video> getVideos() {
    return _videos;
  }

  // List<dynamic> returnVideoList() {
  //   return _videoList;
  // }

  // List<String> returnVideoThumbnail() {
  //   return _videoThumbnail;
  // }

  // List<String> returnVideoUrlList() {
  //   return _videoUrlList;
  // }

  // List<String> returnVideoNameList() {
  //   return _videoNameList;
  // }

  // List<String> returnVideoDescriptionList() {
  //   return _videoDescriptionList;
  // }
}
