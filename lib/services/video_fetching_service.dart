import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideoFetchingService extends ChangeNotifier {
  VideoFetchingService(this._firebaseFirestore);

  FirebaseFirestore _firebaseFirestore;

  final String videoInfo = "VideoInfo";
  List<dynamic> _videoList = [];
  List<String> _videoThumbnail = [];
  List<String> _videoUrlList = [];
  List<String> _videoNameList = [];
  List<String> _videoDescriptionList = [];

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
    _videoList = [];
    _videoThumbnail = [];
    _videoUrlList = [];
    _videoNameList = [];
    _videoDescriptionList = [];
    final collection = await _firebaseFirestore.collection(videoInfo).get();
    final List<DocumentSnapshot> documents = collection.docs;

    documents.forEach((element) {
      _videoList.add(element.id.toString());
      _videoThumbnail.add(element.data()["thumbnailUrl"]);
      _videoUrlList.add(element.data()["videoUrl"]);
      _videoNameList.add(element.data()["title"]);
      _videoDescriptionList.add(element.data()["description"]);
    });
  }

  List<dynamic> returnVideoList() {
    return _videoList;
  }

  List<String> returnVideoThumbnail() {
    return _videoThumbnail;
  }

  List<String> returnVideoUrlList() {
    return _videoUrlList;
  }

  List<String> returnVideoNameList() {
    return _videoNameList;
  }

  List<String> returnVideoDescriptionList() {
    return _videoDescriptionList;
  }

  /// To fetch the genreFrom the database
  // Future<void> fetchGenreList() async{
  //   int i = 0;
  //   _genreList = [];
  //   List<String> _documentList = [];
  //   _genreCollectionList.forEach((element) async{
  //     print("Genre collection is called $element");
  //     _documentList = [];
  //     final collection = await _firebaseFirestore.collection(element).get();
  //     final List<DocumentSnapshot> documents = collection.docs;
  //     documents.forEach((elementSub) {
  //       print("This document is called");
  //       _documentList.add(elementSub.data()["videoRef"]);
  //     });
  //     _genreList.add(_documentList);
  //   });
  //   print(_genreList);
  // }


  Future<List<String>> fetchGivenGenreList({ String collectionName}) async{
    List<String> fetchList = [];
    final collection = await _firebaseFirestore.collection(collectionName).get();
    final List<DocumentSnapshot> documents = collection.docs;

    documents.forEach((element) {
      fetchList.add(element.data()["videoRef"]);
    });

    return fetchList;
  }

  Future<void> fetchAllGenre() async{
    _actionList = await fetchGivenGenreList(collectionName: _videoActionCollection);
    _animationList = await fetchGivenGenreList(collectionName: _videoAnimationCollection);
    _crimeList = await fetchGivenGenreList(collectionName: _videoCrimeCollection);
    _comedyList = await fetchGivenGenreList(collectionName: _videoComedyCollection);
    _dramaList = await fetchGivenGenreList(collectionName: _videoDramaCollection);
    _fantasyList = await fetchGivenGenreList(collectionName: _videoFantasyCollection);
    _historicalList = await fetchGivenGenreList(collectionName: _videoHistoricalCollection);
    _horrorList = await fetchGivenGenreList(collectionName: _videoHorrorCollection);
    _romanceList = await fetchGivenGenreList(collectionName: _videoRomanceCollection);
    print(_actionList);
    print(_animationList);
    print(_romanceList);
    print(_horrorList);
    print(_comedyList);
  }


  Future<void> fetchActionGenre() async{
    _actionList = [];
    final collection = await _firebaseFirestore.collection(_videoActionCollection).get();
    final List<DocumentSnapshot> documents = collection.docs;

    documents.forEach((element) {
      _actionList.add(element.data()["videoRef"]);
    });
    print(_actionList);
    await fetchAnimationGenre();
  }

  Future<void> fetchAnimationGenre() async{
    _animationList = [];
    final collection = await _firebaseFirestore.collection(_videoAnimationCollection).get();
    final List<DocumentSnapshot> documents = collection.docs;

    documents.forEach((element) {
      _animationList.add(element.data()["videoRef"]);
    });
    print(_animationList);
  }
}
