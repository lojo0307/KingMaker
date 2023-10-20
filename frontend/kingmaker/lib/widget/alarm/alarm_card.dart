import 'package:flutter/material.dart';
class AlarmCard extends StatelessWidget {
  const AlarmCard({super.key, required this.data});
  final data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(data['text']),
        Text(data['time'])
      ],
    );
  }
}
