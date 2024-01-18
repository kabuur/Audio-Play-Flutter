import 'package:audio/isplaying.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Audio extends StatefulWidget {
  final Audio_name;
  const Audio({super.key, required this.Audio_name});

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  final audio = IsPlaying.audio;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  bool isPlaying = IsPlaying.isPlaying;

  String formatTime(int seconds) {
    return '${Duration(seconds: seconds)}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void initState() {
    super.initState();

    audio.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audio.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audio.onPositionChanged.listen((newPosiont) {
      setState(() {
        position = newPosiont;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("play Now"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // slider

          Slider(
              value: position.inSeconds.toDouble(),
              min: 0,
              max: duration.inSeconds.toDouble(),
              onChanged: ((value) {
                final changePosition = Duration(seconds: value.toInt());
                audio.seek(changePosition);
                audio.resume();
              })),
          // row of modifing buttons

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatTime(position.inSeconds)),
                Text(formatTime((duration - position).inSeconds)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // rewind icon to speed the Audio
              CircleAvatar(
                radius: 25,
                child: IconButton(
                    onPressed: () {
                      final changePosition =
                          Duration(seconds: position.inSeconds - 2);
                      audio.seek(changePosition);
                    },
                    icon: Icon(Icons.fast_rewind)),
              ),

              SizedBox(
                width: 20,
              ),

              //play and pause iconButtons
              CircleAvatar(
                radius: 25,
                child: IconButton(
                    onPressed: () {
                      isPlaying
                          ? audio.pause()
                          : audio.play(AssetSource(widget.Audio_name['name']));
                    },
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow)),
              ),

              SizedBox(
                width: 20,
              ),

              // forward icon to speed the Audio
              CircleAvatar(
                radius: 25,
                child: IconButton(
                    onPressed: () {
                      if ((duration - position).inSeconds > 2) {
                        final changePosition =
                            Duration(seconds: position.inSeconds + 2);
                        audio.seek(changePosition);
                      }
                    },
                    icon: Icon(Icons.fast_forward)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
