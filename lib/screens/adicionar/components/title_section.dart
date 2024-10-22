import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  final String title;

  TitleSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }
}
