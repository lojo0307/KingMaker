import 'package:flutter/material.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
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
      'type' : '1',
      'category' : '2',
      'start' : '9시 40분',
      'end' : '11시 23분',
      'achieved' : '0',
    },
    {
      'title' : '빨래널기3',
      'type' : '1',
      'category' : '3',
      'start' : '9시 40분',
      'end' : '11시 23분',
      'achieved' : '0',
    },
    {
      'title' : '빨래널기4',
      'type' : '2',
      'category' : '4',
      'start' : '9시 40분',
      'end' : '11시 23분',
      'achieved' : '1',
    },
    {
      'title' : '빨래널기5',
      'type' : '2',
      'category' : '5',
      'start' : '9시 40분',
      'end' : '11시 23분',
      'achieved' : '1',
    },
    {
      'title' : '빨래널기6',
      'type' : '2',
      'category' : '6',
      'start' : '9시 40분',
      'end' : '11시 23분',
      'achieved' : '1',
    },
  ];
  @override
  Widget build(BuildContext context) {
    Provider.of<ScheduleProvider>(context, listen: false).getList();
    List<Map<String, String>>data = Provider.of<ScheduleProvider>(context, listen: false).list;
    return DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              SizedBox(height: 20,),
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
    );
  }
}
