import 'package:flutter/material.dart';
import 'package:kingmaker/widget/alarm/alarm_main.dart';
import 'package:kingmaker/widget/common/header1.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  String month = '10';
  String date = '29';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF1FF),
      body: Stack(
        children: [
          Header1(title: '$month 월 $date 일'),
          AlarmMain(),
        ],
      ),
    );
  }
}

