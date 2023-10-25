import 'package:flutter/material.dart';
import 'package:kingmaker/widget/schedule/schedule_set.dart';

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
  static const List<Map<String, String>>data =[
    {
      'title' : '빨래널기1',
      'type' : '1',
      'category' : '1',
      'start' : '9시 40분',
      'end' : '11시 23분',
      'achieved' : '0',
    },
    {
      'title' : '빨래널기2',
      'type' : '2',
      'category' : '1',
      'start' : '9시 40분',
      'end' : '11시 23분',
      'achieved' : '0',
    },
    {
      'title' : '빨래널기3',
      'type' : '3',
      'category' : '1',
      'start' : '9시 40분',
      'end' : '11시 23분',
      'achieved' : '0',
    },
    {
      'title' : '빨래널기4',
      'type' : '4',
      'category' : '1',
      'start' : '9시 40분',
      'end' : '11시 23분',
      'achieved' : '1',
    },
    {
      'title' : '빨래널기5',
      'type' : '5',
      'category' : '1',
      'start' : '9시 40분',
      'end' : '11시 23분',
      'achieved' : '1',
    },
    {
      'title' : '빨래널기6',
      'type' : '6',
      'category' : '1',
      'start' : '9시 40분',
      'end' : '11시 23분',
      'achieved' : '1',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                labelStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: myTabs.map((obj) {
                  String title = obj['text'].toString();
                  return Tab(
                    text: title,
                    height: 50,
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
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
    );
  }
}
