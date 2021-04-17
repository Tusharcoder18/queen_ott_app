import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';

class MyAppAudio extends StatefulWidget {
  @override
  _MyAppAudioState createState() => _MyAppAudioState();
}

class _MyAppAudioState extends State<MyAppAudio> {
  String _platformVersion = 'Unknown';
  AudioManager _audioManagerInstance = AudioManager.instance;
  bool isPlaying = false;
  Duration _duration;
  Duration _position;
  double _slider;
  double _sliderVolume;
  String _error;
  num curIndex = 0;
  int _currentIndex = 0;
  PlayMode playMode = AudioManager.instance.playMode;

  final list = [
    {
      "title": "Assets",
      "desc": "assets playback",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/queenapp-81e7b.appspot.com/o/music%2FmusicOne.mp3?alt=media&token=93280c4a-c4f8-4934-a76b-1669823d3c09",
      "coverUrl": "assets/movieOne.jpg"
    },
    {
      "title": "network",
      "desc": "network resouce playback",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/queenapp-81e7b.appspot.com/o/music%2FmusicTwo.mp3?alt=media&token=bcd8c6b7-c7a8-4c3f-b839-4699f01a7a70",
      "coverUrl": "https://homepages.cae.wisc.edu/~ece533/images/airplane.png"
    }
  ];

  @override
  void initState() {
    super.initState();

    //initPlatformState();
    //setupAudio();
    //loadFile();
    onScreenSetUpAudio();
  }

  @override
  void dispose() {
    AudioManager.instance.release();
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
    _audioManagerInstance.play(auto: true);

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
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: volumeFrame(),
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(list[index]["title"],
                            style: TextStyle(fontSize: 18)),
                        subtitle: Text(list[index]["desc"]),
                        onTap: () {
                          _currentIndex = index;
                          _audioManagerInstance.play(index: index);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: list.length),
              ),
              Center(
                  child: Text(_error != null
                      ? _error
                      : "${_audioManagerInstance.info.title} lrc text: ${_formatDuration(_position)}")),
              bottomPanel()
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
                  color: _currentIndex > 0 ? Colors.black : Colors.black12,
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
              },
              padding: const EdgeInsets.all(0.0),
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 48.0,
                color: Colors.black,
              ),
            ),
            IconButton(
                iconSize: 36,
                icon: Icon(
                  Icons.skip_next,
                  color: _currentIndex + 1 < list.length
                      ? Colors.black
                      : Colors.black12,
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
                  color: Colors.black,
                ),
                onPressed: () => _audioManagerInstance.stop()),
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
          color: Colors.black,
        );
      case PlayMode.shuffle:
        return Icon(
          Icons.shuffle,
          color: Colors.black,
        );
      case PlayMode.single:
        return Icon(
          Icons.repeat_one,
          color: Colors.black,
        );
    }
    return Container();
  }

  Widget songProgress(BuildContext context) {
    var style = TextStyle(color: Colors.black);
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
                  thumbColor: Colors.blueAccent,
                  overlayColor: Colors.blue,
                  thumbShape: RoundSliderThumbShape(
                    disabledThumbRadius: 5,
                    enabledThumbRadius: 5,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 10,
                  ),
                  activeTrackColor: Colors.blueAccent,
                  inactiveTrackColor: Colors.grey,
                ),
                child: Slider(
                  value: _slider ?? 0,
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
            color: Colors.black,
          ),
          onPressed: () {
            _audioManagerInstance.setVolume(0);
          }),
      Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Slider(
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

// Future<void> setupAudio() async {
//   List<AudioInfo> _list = [];
//   list.forEach((item) => _list.add(AudioInfo(item["url"],
//       title: item["title"], desc: item["desc"], coverUrl: item["coverUrl"])));
//
//   AudioManager.instance.audioList = _list;
//   AudioManager.instance.intercepter = true;
//   AudioManager.instance.play(auto: false);
//
//   AudioManager.instance.onEvents((events, args) {
//     print("$events, $args");
//     switch (events) {
//       case AudioManagerEvents.start:
//         print(
//             "start load data callback, curIndex is ${AudioManager.instance.curIndex}");
//         _position = AudioManager.instance.position;
//         _duration = AudioManager.instance.duration;
//         _slider = 0;
//         setState(() {});
//         break;
//       case AudioManagerEvents.ready:
//         print("ready to play");
//         _error = null;
//         _sliderVolume = AudioManager.instance.volume;
//         _position = AudioManager.instance.position;
//         _duration = AudioManager.instance.duration;
//         setState(() {});
//         // if you need to seek times, must after AudioManagerEvents.ready event invoked
//         // AudioManager.instance.seekTo(Duration(seconds: 10));
//         break;
//       case AudioManagerEvents.seekComplete:
//         _position = AudioManager.instance.position;
//         _slider = _position.inMilliseconds / _duration.inMilliseconds;
//         setState(() {});
//         print("seek event is completed. position is [$args]/ms");
//         break;
//       case AudioManagerEvents.buffering:
//         print("buffering $args");
//         break;
//       case AudioManagerEvents.playstatus:
//         isPlaying = AudioManager.instance.isPlaying;
//         setState(() {});
//         break;
//       case AudioManagerEvents.timeupdate:
//         _position = AudioManager.instance.position;
//         _slider = _position.inMilliseconds / _duration.inMilliseconds;
//         setState(() {});
//         AudioManager.instance.updateLrc(args["position"].toString());
//         break;
//       case AudioManagerEvents.error:
//         _error = args;
//         setState(() {});
//         break;
//       case AudioManagerEvents.ended:
//         AudioManager.instance.next();
//         break;
//       case AudioManagerEvents.volumeChange:
//         _sliderVolume = AudioManager.instance.volume;
//         setState(() {});
//         break;
//       default:
//         break;
//     }
//   });
// }

// Future<void> initPlatformState() async {
//   String platformVersion;
//   try {
//     platformVersion = await AudioManager.instance.platformVersion;
//   } on PlatformException {
//     platformVersion = 'Failed to get platform version.';
//   }
//   if (!mounted) return;
//
//   setState(() {
//     _platformVersion = platformVersion;
//   });
// }
