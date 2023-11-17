import 'package:flutter/material.dart';
import 'package:kingmaker/widget/calendar/calendar_todo_card.dart';

class DayListSet extends StatefulWidget {
  const DayListSet({super.key, required this.list});
  final List<Map<String, String>> list;
  @override
  State<DayListSet> createState() => _DayListSetState();
}

class _DayListSetState extends State<DayListSet> {
  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
      scrollDirection:Axis.vertical,
      child: Column(
        children:
        widget.list.map ((Map<String, String> res){
          return CalendarTodoCard(data: res);
        }).toList(),
      ),
    );
  }
}
