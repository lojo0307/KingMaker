import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/widget/common/add_content.dart';
import 'package:kingmaker/widget/schedule/schedule_main.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LIGHTEST_BLUE_COLOR,
      body: SafeArea(
        child: Stack(
          children: [
            ScheduleMain(),
            AddContent(),
          ],
        ),
      ),
    );
  }
}
