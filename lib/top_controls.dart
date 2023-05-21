import 'package:flutter/material.dart';

class TopControls extends StatefulWidget {
  const TopControls(
      {Key? key,
      required this.startTimer,
      required this.stopTimer,
      required this.beatsPerMinute,
      required this.beats})
      : super(key: key);
  final Function() startTimer;
  final Function() stopTimer;
  final int beatsPerMinute;
  final List<String> beats;
  @override
  State<TopControls> createState() => _TopControlsState();
}

class _TopControlsState extends State<TopControls> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(widget.beatsPerMinute.toString(),
          style: const TextStyle(fontSize: 50, color: Colors.white)),
      Text((widget.beats.length).toString(),
          style: const TextStyle(fontSize: 50, color: Colors.white)),
      MaterialButton(
        onPressed: () => widget.startTimer(),
        color: const Color(0xff393948),
        hoverColor: const Color(0xff393948),
        child: const Text('START',
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      MaterialButton(
        onPressed: () => widget.stopTimer(),
        color: const Color(0xff393948),
        hoverColor: const Color(0xff393948),
        child: const Text('STOP',
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    ]);
  }
}
