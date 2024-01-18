import 'package:audio/isplaying.dart';
import 'package:audio/list_audio.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'audio.dart';

void main() {
  runApp(MaterialApp(home: startApp()));
}

class startApp extends StatefulWidget {
  const startApp({super.key});

  @override
  State<startApp> createState() => _startAppState();
}

class _startAppState extends State<startApp> {
  @override
  void initState() {
    super.initState();
  }

  final audio = AudioPlayer();

  push_audion(context, audio_details) async {
    await IsPlaying.audio.stop();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Audio(Audio_name: audio_details)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tafsiirka Quraanka ",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: ListAudio.Audios.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              push_audion(context, ListAudio.Audios[index]);
            },
            leading: Icon(Icons.book),
            title: Text(ListAudio.Audios[index]['name'].toString()),
          );
        },
      ),
    );
  }
}
