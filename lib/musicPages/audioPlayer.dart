import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';

MediaControl playControl = MediaControl(
    androidIcon: 'drawable/play_arrow',
    label: "Play",
    action: MediaAction.play);

MediaControl pauseControl = MediaControl(
    androidIcon: 'drawable/pause', label: "Pause", action: MediaAction.pause);

MediaControl skipToNextControl = MediaControl(
    androidIcon: 'drawable/skip_to_next',
    label: "Next",
    action: MediaAction.skipToNext);

MediaControl skipToPreviousControl = MediaControl(
    androidIcon: 'drawable/skip_to_prev',
    label: "Previous",
    action: MediaAction.skipToPrevious);

MediaControl stopControl = MediaControl(
    androidIcon: 'drawable/stop', label: "Stop", action: MediaAction.stop);

class AudioPlayerTask extends BackgroundAudioTask {
  final _queue = <MediaItem>[
    MediaItem(
      id: "https://firebasestorage.googleapis.com/v0/b/queenapp-81e7b.appspot.com/o/music%2FmusicOne.mp3?alt=media&token=93280c4a-c4f8-4934-a76b-1669823d3c09",
      album: "Science Friday",
      title: "A salute to Head-scratching Science",
      artist: "Science Friday and WNYC Studios",
      duration: Duration(seconds: 248),
    ),
    MediaItem(
      id: "https://firebasestorage.googleapis.com/v0/b/queenapp-81e7b.appspot.com/o/music%2FmusicTwo.mp3?alt=media&token=bcd8c6b7-c7a8-4c3f-b839-4699f01a7a70",
      album: "Science Friday",
      title: "From Cat Rheology To Operatic Incompetence",
      artist: "Science Friday and WNYC Studios",
      duration: Duration(seconds: 168),
    ),
  ];

  int _queueIndex = -1;
  AudioPlayer _audioPlayer = AudioPlayer();
  AudioProcessingState _audioProcessingState;
  bool _playing;

  bool get hasNext => _queueIndex + 1 < _queue.length;

  bool get hasPrevious => _queueIndex > 0;

  MediaItem get mediaItem => _queue[_queueIndex];

  StreamSubscription<PlaybackState> _playerStateSubscription;
  StreamSubscription<PlaybackEvent> _eventSubscription;

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    super.onStart(params);

  }

  @override
  Future<void> onStop() async{
    _playing = false;
    await _audioPlayer.stop();
    await _audioPlayer.dispose();
    _playerStateSubscription.cancel();
    _eventSubscription.cancel();
    return await super.onStop();
  }



  @override
  Future<void> onPlay() async{
    if (null == _audioProcessingState) {
      _playing = true;
      _audioPlayer.play();
    }
  }

  @override
  Future<void> onPause() async {
    _playing = false;
    _audioPlayer.pause();
  }

  @override
  Future<void> onSkipToNext() async {
    skip(1);
  }

  @override
  Future<void> onSkipToPrevious() async {
    skip(-1);
  }

  void skip(int offset) async {
    int newPos = _queueIndex + offset;
    if (!(newPos >= 0 && newPos < _queue.length)) {
      return;
    }
    if (null == _playing) {
      _playing = true;
    } else if (_playing) {
      await _audioPlayer.stop();
    }
    _queueIndex = newPos;
    _audioProcessingState = offset > 0
        ? AudioProcessingState.skippingToNext
        : AudioProcessingState.skippingToPrevious;
    AudioServiceBackground.setMediaItem(mediaItem);
    await _audioPlayer.setUrl(mediaItem.id);
    _audioProcessingState = null;
    if (_playing) {
      onPlay();
    } else {
      _setState(processingState: AudioProcessingState.ready);
    }
  }

  @override
  Future<void> onSeekTo(Duration position) {
    // TODO: implement onSeekTo
    return super.onSeekTo(position);
  }

  @override
  Future<void> onClick(MediaButton button) {
    // TODO: implement onClick
    return super.onClick(button);
  }

  @override
  Future<void> onFastForward() {
    // TODO: implement onFastForward
    return super.onFastForward();
  }

  @override
  Future<void> onRewind() {
    // TODO: implement onRewind
    return super.onRewind();
  }

  Future<void> _setState(
      {AudioProcessingState processingState,
      Duration position,
      Duration bufferedPosition}) async {
    if (null == position) {
      position = _audioPlayer.playbackEvent.bufferedPosition;
    }

    await AudioServiceBackground.setState(
      controls: getControls(),
      systemActions: [MediaAction.seekTo],
      processingState:
          processingState ?? AudioServiceBackground.state.processingState,
      playing: _playing,
      position: position,
      speed: _audioPlayer.speed,
    );
  }

  List<MediaControl> getControls() {
    if (_playing) {
      return [
        skipToPreviousControl,
        pauseControl,
        stopControl,
        skipToNextControl,
      ];
    } else {
      return [
        skipToPreviousControl,
        playControl,
        stopControl,
        skipToNextControl,
      ];
    }
  }
}
