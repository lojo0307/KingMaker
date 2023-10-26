import 'package:flutter/material.dart';

class ScheduleInfo extends StatelessWidget {
  const ScheduleInfo({super.key, required this.data});
  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        // border: Border(
        //   left: BorderSide(color: Colors.black, width: 1),
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data['title'].toString(),
            style: TextStyle(
              fontSize: 20,
              decoration: (data['achieved'] == '1') ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          Text(data['start'].toString() + " ~ " + data['end'].toString(),),
        ],
      ),
    );
  }
}
