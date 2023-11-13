import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
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
      backgroundColor: LIGHTEST_BLUE_COLOR,
      body: SafeArea(
          child: Column(
            children: [
              Header(title: '캘린더'),
              CalendarMain(),
            ],
          ),
      ),
    );
  }
}

