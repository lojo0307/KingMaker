import 'package:flutter/material.dart';
import 'package:kingmaker/widget/alarm/alarm_card.dart';
class AlarmList extends StatefulWidget {
  const AlarmList({super.key, required this.type, required this.list});
  final type;
  final list;
  @override
  State<AlarmList> createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children:
        [Text('123')],
        // widget.list.map ((data) {
        //   print(data['type'].toString());
        //   if (widget.type == 0 || widget.type.toString() == data['type'].toString()) {
        //     return Text('123');
        //       AlarmCard(data: data);
        //   }else {
        //     return null;
        //   }
        // }).toList(),
      ),
    );
  }
}
