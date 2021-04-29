import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';

class MyAppAudio extends StatefulWidget {
  MyAppAudio({this.musicList, this.currentIndex});

  final List<List<String>> musicList;
  final int currentIndex;

  @override
  _MyAppAudioState createState() => _MyAppAudioState();
}

class _MyAppAudioState extends State<MyAppAudio> {
  //final assetsAudioPlayer = AssetsAudioPlayer();
  AudioManager _audioManagerInstance = AudioManager.instance;
  bool isPlaying = false;
  Duration _duration;
  Duration _position;
  double _slider = 0;
  double _sliderVolume;
  String _error;
  num curIndex = 0;
  int _currentIndex = 0;
  PlayMode playMode = AudioManager.instance.playMode;

  List list = [];

  void makeList() {
    widget.musicList.forEach((element) {
      list.add({
        "title": element[0],
        "url": element[2],
        "desc": "",
        "coverUrl": element[1]
      });
    });
    _currentIndex = widget.currentIndex;
  }

  @override
  void initState() {
    super.initState();
    makeList();
    onScreenSetUpAudio();

    if (_currentIndex + 1 < list.length) {
      _audioManagerInstance.next();
      _audioManagerInstance.previous();
    }

    if (_currentIndex + 1 == list.length) {
      _audioManagerInstance.previous();
      _audioManagerInstance.next();
    }

    if (_audioManagerInstance.isPlaying == true) {
      setState(() {
        _slider = _audioManagerInstance.duration.inMilliseconds.toDouble();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _audioManagerInstance.release();
  }

  ///increment the list by on number
  void nextAudio() {
    _currentIndex += 1;
    setState(() {});
  }

  void previousAudio() {
    _currentIndex -= 1;
    setState(() {});
  }

  Future<void> onScreenSetUpAudio() async {
    List<AudioInfo> _list = [];
    list.forEach(
      (element) {
        _list.add(
          AudioInfo(
            element["url"],
            title: element["title"],
            desc: element["desc"],
            coverUrl: element["coverUrl"],
          ),
        );
      },
    );
    _audioManagerInstance.audioList = _list;
    _audioManagerInstance.intercepter = true;
    _audioManagerInstance.play(auto: true, index: _currentIndex);

    _audioManagerInstance.onEvents((events, args) {
      print("$events, $args");
      switch (events) {
        case AudioManagerEvents.start:
          print(
              "start load data callback, curIndex is ${_audioManagerInstance.curIndex}");
          _position = _audioManagerInstance.position;
          _duration = _audioManagerInstance.duration;
          _slider = 0;
          setState(() {});
          break;
        case AudioManagerEvents.ready:
          print("ready to play");
          _error = null;
          _sliderVolume = _audioManagerInstance.volume;
          _position = _audioManagerInstance.position;
          _duration = _audioManagerInstance.duration;
          setState(() {});
          // if you need to seek times, must after AudioManagerEvents.ready event invoked
          // AudioManager.instance.seekTo(Duration(seconds: 10));
          break;
        case AudioManagerEvents.seekComplete:
          _position = _audioManagerInstance.position;
          _slider = _position.inMilliseconds / _duration.inMilliseconds;
          setState(() {});
          print("seek event is completed. position is [$args]/ms");
          break;
        case AudioManagerEvents.buffering:
          print("buffering $args");
          break;
        case AudioManagerEvents.playstatus:
          isPlaying = _audioManagerInstance.isPlaying;
          setState(() {});
          break;
        case AudioManagerEvents.timeupdate:
          _position = _audioManagerInstance.position;
          _slider = _position.inMilliseconds / _duration.inMilliseconds;
          setState(() {});
          _audioManagerInstance.updateLrc(args["position"].toString());
          break;
        case AudioManagerEvents.error:
          _error = args;
          setState(() {});
          break;
        case AudioManagerEvents.ended:
          _audioManagerInstance.next();
          break;
        case AudioManagerEvents.volumeChange:
          _sliderVolume = _audioManagerInstance.volume;
          setState(() {});
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _audioManagerInstance == null
            ? Container()
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: volumeFrame(),
                    ),
                    Center(
                      child: Container(
                        height: 300,
                        width: 300,
                        child: Image.network(list[_currentIndex]["coverUrl"]),
                      ),
                    ),
                    Column(
                      children: [
                        Center(
                            child: Text(_error != null
                                ? ''
                                : "${_audioManagerInstance.info.title}  ${_formatDuration(_position)}")),
                        bottomPanel(),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget bottomPanel() {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: songProgress(context),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                icon: getPlayModeIcon(playMode),
                onPressed: () {
                  playMode = _audioManagerInstance.nextMode();
                  setState(() {});
                }),
            IconButton(
                iconSize: 36,
                icon: Icon(
                  Icons.skip_previous,
                  color: _currentIndex > 0 ? Colors.white : Colors.white38,
                ),
                onPressed: () {
                  if (_currentIndex > 0) {
                    previousAudio();
                    _audioManagerInstance.play(index: _currentIndex);
                  }
                }),
            IconButton(
              onPressed: () async {
                bool playing = _audioManagerInstance.isPlaying;
                if (playing == true) {
                  _audioManagerInstance.toPause();
                } else {
                  _audioManagerInstance.play(index: _currentIndex);
                }
                print("await -- $playing");

                // assetsAudioPlayer.open(
                //   Audio.network(
                //     list[_currentIndex]["url"],
                //     metas: Metas(
                //       title: 'Random Title',
                //       artist: 'Random Artist',
                //       album: "Random Album",
                //       image:
                //           MetasImage.network(list[_currentIndex]["coverUrl"]),
                //     ),
                //   ),
                //   showNotification: true,
                // );
              },
              padding: const EdgeInsets.all(0.0),
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 48.0,
                color: Colors.white,
              ),
            ),
            IconButton(
                iconSize: 36,
                icon: Icon(
                  Icons.skip_next,
                  color: _currentIndex + 1 < list.length
                      ? Colors.white
                      : Colors.white38,
                ),
                onPressed: () async {
                  if (_currentIndex + 1 < list.length) {
                    nextAudio();
                    _audioManagerInstance.play(index: _currentIndex);
                  }
                }),
            IconButton(
                icon: Icon(
                  Icons.stop,
                  color: Colors.white,
                ),
                onPressed: () {
                  _audioManagerInstance.stop();
                  _slider = 0;
                  setState(() {});
                }),
          ],
        ),
      ),
    ]);
  }

  Widget getPlayModeIcon(PlayMode playMode) {
    switch (playMode) {
      case PlayMode.sequence:
        return Icon(
          Icons.repeat,
          color: Colors.white,
        );
      case PlayMode.shuffle:
        return Icon(
          Icons.shuffle,
          color: Colors.white,
        );
      case PlayMode.single:
        return Icon(
          Icons.repeat_one,
          color: Colors.white,
        );
    }
    return Container();
  }

  Widget songProgress(BuildContext context) {
    var style = TextStyle(color: Colors.white);
    return Row(
      children: <Widget>[
        Text(
          _formatDuration(_position),
          style: style,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2,
                  thumbColor: Colors.white,
                  overlayColor: Colors.red[100],
                  thumbShape: RoundSliderThumbShape(
                    disabledThumbRadius: 5,
                    enabledThumbRadius: 5,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 10,
                  ),
                  activeTrackColor: Colors.red,
                  inactiveTrackColor: Colors.grey,
                ),
                child: Slider(
                  value: _slider > 0 ? _slider : 0,
                  onChanged: (value) {
                    setState(() {
                      _slider = value;
                    });
                  },
                  onChangeEnd: (value) {
                    if (_duration != null) {
                      Duration msec = Duration(
                          milliseconds:
                              (_duration.inMilliseconds * value).round());
                      _audioManagerInstance.seekTo(msec);
                    }
                  },
                )),
          ),
        ),
        Text(
          _formatDuration(_duration),
          style: style,
        ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }

  Widget volumeFrame() {
    return Row(children: <Widget>[
      IconButton(
          padding: EdgeInsets.all(0),
          icon: Icon(
            Icons.audiotrack,
            color: Colors.white,
          ),
          onPressed: () {
            _audioManagerInstance.setVolume(0);
          }),
      Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Slider(
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
                value: _sliderVolume ?? 0,
                onChanged: (value) {
                  setState(() {
                    _sliderVolume = value;
                    _audioManagerInstance.setVolume(value, showVolume: true);
                  });
                },
              )))
    ]);
  }
}
