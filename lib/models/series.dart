import 'package:queen_ott_app/models/season.dart';

class Series {
  String _seriesTitle;
  String _seriesDescription;
  String _seriesThumbnail;
  List<String> _seriesGenre;
  List<Season> _seriesSeasons;

  Series(this._seriesTitle, this._seriesDescription, this._seriesThumbnail,
      this._seriesGenre, this._seriesSeasons);

  String getSeriesTitle() {
    return _seriesTitle;
  }

  String getSeriesDescription() {
    return _seriesDescription;
  }

  String getSeriesThumbnail() {
    return _seriesThumbnail;
  }

  List<String> getSeriesGenre() {
    return _seriesGenre;
  }

  List<Season> getSeriesSeasons() {
    return _seriesSeasons;
  }
}
