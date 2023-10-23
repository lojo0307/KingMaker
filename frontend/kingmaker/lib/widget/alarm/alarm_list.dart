import 'package:flutter/material.dart';
import 'package:kingmaker/widget/alarm/alarm_card.dart';
class AlarmList extends StatefulWidget {
  const AlarmList({super.key, required this.type, required this.list, required this.delFlag});
  final delFlag;
  final type;
  final List<Map<String, String>> list;
  @override
  State<AlarmList> createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children:
          widget.list.map ((Map<String, String> res){
            if (widget.type == '0' || widget.type == res['type']) {
              return AlarmCard(data: res, delFlag: widget.delFlag,);
            } else {
              return const SizedBox.shrink();
            }
          }).toList(),

        ),
      ),
    );

  }
}
