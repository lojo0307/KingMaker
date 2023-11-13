import 'package:flutter/material.dart';
import 'package:kingmaker/page/todo_detail_page.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:provider/provider.dart';
class CalendarTodoCard extends StatelessWidget {
  const CalendarTodoCard({super.key, required this.data});
  final Map<String, String> data;
  @override
  Widget build(BuildContext context) {
    print('CalendarTodoCard : $data');
    final Color bgColor = data['achieved']=='0' ? Colors.white : Colors.grey;
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
        padding: EdgeInsetsDirectional.symmetric(vertical: 10),
        margin: EdgeInsetsDirectional.symmetric(vertical: 5),
        child: Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
              child: Container(
                child: Image.asset('assets/character/calendarlist/${data['category']}.gif',scale: 1.1),
                width: 40,
                height: 40,
                margin: EdgeInsets.only(right: 1),
              ),
            ),
            Expanded(
              child: Text(
                '${data['title']}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
