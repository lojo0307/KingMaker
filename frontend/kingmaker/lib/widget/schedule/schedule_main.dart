import 'package:flutter/material.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:kingmaker/widget/schedule/schedule_set.dart';
import 'package:provider/provider.dart';

import '../common/header.dart';
class ScheduleMain extends StatefulWidget {
  const ScheduleMain({super.key});

  @override
  State<ScheduleMain> createState() => _ScheduleMainState();
}

class _ScheduleMainState extends State<ScheduleMain> {
  static const myTabs = [
    { 'text': '전 체', 'type': 0,},
    {'text': '할 일', 'type': 1,},
    {'text': '루 틴', 'type': 2,},
  ];
  @override
  void initState() {
    DateTime now = DateTime.now();
    int? memberId = Provider.of<MemberProvider>(context,listen: false).member?.memberId;
    Provider.of<ScheduleProvider>(context, listen: false).getList(memberId!, now.year, now.month, now.day);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> data = context.watch<ScheduleProvider>().list;
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child:  DefaultTabController(
              length: myTabs.length,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    Header(title: '일 정'),
                    TabBar(
                      indicatorColor: Colors.black,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      dividerColor: Colors.transparent,
                      labelStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: myTabs.map((obj) {
                        String title = obj['text'].toString();
                        return Tab(
                          text: title,
                        );
                      }).toList(),
                    ),
                    Expanded(
                      child: TabBarView(
                        children:
                        myTabs.map((obj) {
                          final String type = obj["type"].toString();
                          return ScheduleSet(type: type, list: data,);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      );
  }
}
