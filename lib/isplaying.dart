import 'package:audioplayers/audioplayers.dart';

class IsPlaying{

  static final audio = AudioPlayer();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;



   static bool isPlaying = false;
}