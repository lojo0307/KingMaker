import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/page/todo_detail_page.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:provider/provider.dart';
class CalendarTodoCard extends StatelessWidget {
  const CalendarTodoCard({super.key, required this.data});
  final Map<String, String> data;
  @override
  Widget build(BuildContext context) {
    final Color bgColor = data['achieved']=='0' ? WHITE_COLOR : LIGHT_GREY_COLOR;
    return GestureDetector(
      onTap: () async{
        await Provider.of<ScheduleProvider>(context, listen: false).getDetail(int.parse(data['id']!), data['type']!);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TodoDetailPage())
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
        ),
        // padding: EdgeInsetsDirectional.symmetric(vertical: 10),
        margin: EdgeInsetsDirectional.symmetric(vertical: 5),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Container(
                child: Image.asset('assets/character/calendarlist/${data['category']}.gif',scale: 1.1),
                width: 80,
                height: 56,
                margin: EdgeInsets.only(right: 1),
              ),
            ),
            Expanded(
              child: Text(
                '${data['title']}',
                style: TextStyle(fontSize: 16),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
