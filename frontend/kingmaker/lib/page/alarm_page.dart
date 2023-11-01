import 'package:flutter/material.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/widget/alarm/alarm_main.dart';
import 'package:kingmaker/widget/common/header.dart';
import 'package:provider/provider.dart';
class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemberProvider>(
      builder: (context, provider, child) {
        return const Scaffold(
        backgroundColor: Color(0xFFEDF1FF),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20,),
                Header(title: '알 림'),
              ],
            ),
            AlarmMain(),
          ],
        ),
      );
    },
    );
  }
}

