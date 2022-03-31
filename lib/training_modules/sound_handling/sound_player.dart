import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';

final pathToReadAudio = 'default.aac';

class SoundPlayer {
  FlutterSoundPlayer? _audioPlayer;


  Future init() async {
    _audioPlayer = FlutterSoundPlayer();

    await _audioPlayer!.openAudioSession();
  }


  Future dispose() async {
    _audioPlayer!.closeAudioSession();
    _audioPlayer = null;
  }


  Future _play(VoidCallback whenFinished) async {
    await _audioPlayer!.startPlayer(
    fromURI: pathToReadAudio,
      whenFinished: whenFinished,
    );
  }

  Future _stop() async {
    await _audioPlayer!.stopPlayer();
  }

  Future togglePlaying({required VoidCallback whenFinished}) async {
    if (_audioPlayer!.isStopped) {
      await _play(whenFinished);
    } else {
      await _stop();
    }
  }
}