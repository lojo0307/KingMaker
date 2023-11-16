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
      padding: EdgeInsets.symmetric(horizontal: 24,),
      child: Center(
        child: Column(
          children:
          widget.list.asMap().entries.map((entry) {
            int idx = entry.key;
            AlarmDto res = entry.value;
            bool isLast = idx == widget.list.length - 1; // 마지막 요소인지 확인
            return AlarmCard(
              data: res,
              delFlag: widget.delFlag,
              lastIdx: isLast, // 마지막 요소일 경우 true 전달
            );
          }).toList(),
        ),
      ),
    );
  }
}
