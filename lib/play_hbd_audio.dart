import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class PlayHbdAudio extends StatefulWidget {
  const PlayHbdAudio({super.key});

  @override
  State<PlayHbdAudio> createState() => _PlayHbdAudioState();
}

class _PlayHbdAudioState extends State<PlayHbdAudio> {
  late final AudioPlayer _player;

  @override
  void initState() {
    _player = AudioPlayer();
    _player.setReleaseMode(ReleaseMode.loop);
    _playAudio();
    super.initState();
  }

  Future<void> _playAudio() async {
    try {
      if (false) {
        await _player.play(
          AssetSource('happy_birthday.mp3'),
        );
      }
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
