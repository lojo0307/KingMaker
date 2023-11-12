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
          Text(
            _truncateText(data['title'].toString(), 10),
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

  //10자가 넘어가면 ...으로 처리
  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + '...';
    }
  }
}

