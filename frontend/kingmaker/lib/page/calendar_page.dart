import 'package:flutter/material.dart';
import 'package:kingmaker/widget/calendar/%20calendar_main.dart';
import 'package:kingmaker/widget/common/header.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFEDF1FF),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Header(title: '캘린더'),
          CalendarMain(),
        ],
      ),
    );
  }
}

