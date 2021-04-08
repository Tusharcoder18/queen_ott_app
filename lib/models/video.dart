class Video {
  String _videoTitle;
  String _videoDescription;
  String _thumbnailUrl;
  String _videoUrl;

  Video(this._videoTitle, this._videoDescription, this._thumbnailUrl,
      this._videoUrl);

  String getVideoTitle() {
    return _videoTitle;
  }

  String getVideoDescription() {
    return _videoDescription;
  }

  String getVideoThumbnail() {
    return _thumbnailUrl;
  }

  String getVideoUrl() {
    return _videoUrl;
  }
}
