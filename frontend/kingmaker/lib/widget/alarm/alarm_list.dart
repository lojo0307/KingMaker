import 'package:flutter/material.dart';
import 'package:kingmaker/dto/alarm_dto.dart';
import 'package:kingmaker/widget/alarm/alarm_card.dart';
class AlarmList extends StatefulWidget {
  const AlarmList({super.key, required this.list, required this.delFlag});
  final delFlag;
  final List<AlarmDto> list;
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
          widget.list.map ((AlarmDto res){
              return AlarmCard(data: res, delFlag: widget.delFlag,);
          }).toList(),

        ),
      ),
    );

  }
}
