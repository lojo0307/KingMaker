import 'package:assets_audio_player/assets_audio_player.dart';

class AudioPlayerHelper {
  static final AudioPlayerHelper _instance = AudioPlayerHelper._internal();
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

  factory AudioPlayerHelper() {
    return _instance;
  }

  AudioPlayerHelper._internal();

  void playLoginMusic(String title) {
    _assetsAudioPlayer.open(
      Audio("assets/audios/$title"),
      loopMode: LoopMode.playlist,
      autoStart: true,
      showNotification: false,
      volume: 0.9, // 볼륨 설정 (0.0 무음 ~ 1.0 최대 볼륨)
    );
  }

  void setVolume(double volume) {
    _assetsAudioPlayer.setVolume(volume);
  }

  void stopMusic() {
    _assetsAudioPlayer.stop();
  }

  void dispose() {
    _assetsAudioPlayer.dispose();
  }
}
