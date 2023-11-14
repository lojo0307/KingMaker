import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audioplayer_helper.dart';

class MuteButton extends StatefulWidget {
  const MuteButton({super.key});

  @override
  _MuteButtonState createState() => _MuteButtonState();
}

class _MuteButtonState extends State<MuteButton> {
  bool _isMuted = false;
  final _audioPlayerHelper = AudioPlayerHelper();

  @override
  void initState() {
    super.initState();
    _loadMuteStatus();
  }

  void _loadMuteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool currentMuteStatus = prefs.getBool('muteStatus') ?? false;
    if (!currentMuteStatus) {
      _audioPlayerHelper.playLoginMusic('mainBgm.wav'); // 음소거가 아니면 음악 재생
    }
    setState(() {
      _isMuted = currentMuteStatus;
    });
  }

  void _toggleMute() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isMuted = !_isMuted;
    });
    prefs.setBool('muteStatus', _isMuted);
    if (_isMuted) {
      _audioPlayerHelper.stopMusic();
    } else {
      _audioPlayerHelper.playLoginMusic('mainBgm.wav');
    }
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isMuted ? Icons.volume_off : Icons.volume_up,
        size: 30,
      ),
      onPressed: _toggleMute,
    );
  }
}
