import 'package:queen_ott_app/models/video.dart';

class Season {
  int _seasonNumber;
  List<Video> _seasonEpisodes;

  Season(this._seasonNumber, this._seasonEpisodes);

  int getSeasonNumber() {
    return _seasonNumber;
  }

  List<Video> getSeasonEpisodes() {
    return _seasonEpisodes;
  }
}
