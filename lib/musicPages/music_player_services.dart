import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';

class MusicPlayerServices extends ChangeNotifier {
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
}
