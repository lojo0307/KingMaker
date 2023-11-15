import 'package:flutter/material.dart';

class ScheduleInfo extends StatelessWidget {
  const ScheduleInfo({super.key, required this.data});
  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _truncateText(data['title'].toString(), 10),
              style: TextStyle(
                fontSize: 16,
                decoration: (data['achieved'] == '1') ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
            SizedBox(height: 4,),
            Text(data['start'].toString() + " ~ " + data['end'].toString(), style: TextStyle(fontSize: 9),),
          ],
        ),
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