import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  const Headline({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 8.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.black)
        ),
      );
  }
}