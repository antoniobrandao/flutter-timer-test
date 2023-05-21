import 'dart:async';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'top_controls.dart';
import 'bottom_controls.dart';

int maxBeatsPerMinute = 300;
int minBeatsPerMinute = 1;
int maxBeats = 24;
int minBeats = 1;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> beats = [
    'B',
    'A',
    'A',
    'B',
    'A',
    'A',
    'B',
    'A',
    'B',
    'A',
    'B',
    'A'
  ];
  int beatsPerMinute = 220;
  int beatsPerMinuteWhenStarted = 220;
  String toneType = 'organic';
  bool isPlaying = false;
  Timer? localTimer;
  int currentBeat = 1;

  @override
  void initState() {
    super.initState();
    loadAudios();
  }

  Future<void> loadAudios() async {
    print('loading audios');
    await FlameAudio.audioCache.loadAll([
      'pi1.wav',
      'pi2.wav',
      'pi3.wav',
      'pi1_organic.wav',
      'pi2_organic.wav',
      'pi3_organic.wav'
    ]);
  }

  // timer method
  void startTimer() {
    print('starting timer');
    if (isPlaying) {
      return;
    }
    double millisecondsTime = (60 / beatsPerMinute) * 1000;
    int count = 1;
    playSound(beats[0]);
    localTimer = Timer.periodic(
        Duration(milliseconds: millisecondsTime.round()), (timer) {
      setState(() {
        if (beatsPerMinuteWhenStarted != beatsPerMinute) {
          restartTimer();
          return;
        }
        if (beats.length == 1) {
          playSound(beats[0]);
        } else {
          if (count >= beats.length) {
            count = 0;
          }
          playSound(beats[count]);
          count++;
          if (count >= beats.length) {
            count = 0;
          }
        }
      });
    });
    setState(() {
      isPlaying = true;
      beatsPerMinuteWhenStarted = beatsPerMinute;
    });
  }

  void stopTimer() {
    localTimer?.cancel();
    //isPlaying = false;
    setState(() {
      isPlaying = false;
    });
  }

  void restartTimer() {
    stopTimer();
    startTimer();
  }

  void playSound(beatType) {
    //print('beatType: $beatType');
    switch (beatType) {
      case 'A':
        if (toneType == 'digital') {
          FlameAudio.play('pi1.wav');
        } else {
          FlameAudio.play('pi1_organic.wav');
        }
        break;
      case 'B':
        if (toneType == 'digital') {
          FlameAudio.play('pi2.wav');
        } else {
          FlameAudio.play('pi2_organic.wav');
        }
        break;
      case 'C':
        if (toneType == 'digital') {
          FlameAudio.play('pi3.wav');
        } else {
          FlameAudio.play('pi3_organic.wav');
        }
        break;
    }
  }

  void setCurrentBeat(index) {
    setState(() {
      currentBeat = index + 1;
    });
  }

  void changeToneType() {
    setState(() {
      if (toneType == 'digital') {
        toneType = 'organic';
      } else {
        toneType = 'digital';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
              TopControls(
                startTimer: startTimer,
                stopTimer: stopTimer,
                beatsPerMinute: beatsPerMinute,
                beats: beats,
              ),
              Stack(alignment: AlignmentDirectional.topStart, children: [
                BottomControls(
                  toneButtonString:
                      toneType == 'digital' ? 'digital' : 'organic',
                  toneType: toneType,
                  changeToneType: changeToneType,
                ),
              ])
            ])));
  }
}
