import 'package:flutter/material.dart';

class BottomControls extends StatelessWidget {
  const BottomControls(
      {Key? key,
      required this.toneButtonString,
      required this.toneType,
      required this.changeToneType})
      : super(key: key);
  final String toneButtonString;
  final String toneType;
  final Function() changeToneType;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              onPressed: () => changeToneType(),
              color: const Color(0xff393948),
              hoverColor: const Color(0xff393948),
              child: Text(toneButtonString,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 20, height: 1)),
            ),
          ])
        ]);
  }
}
