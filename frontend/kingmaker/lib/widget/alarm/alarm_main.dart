import 'package:flutter/material.dart';
import 'package:kingmaker/widget/alarm/alarm_list.dart';
class AlarmMain extends StatelessWidget {
  const AlarmMain({super.key});

  static const myTabs = [
    { 'text': '전 체', 'type': 0,},
    {'text': '할 일', 'type': 1,},
    {'text': '루 틴', 'type': 2,},
  ];
  static const List<Map<String, String>>data =[
    {
      'title' : '빨래널기1',
      'type' : '1',
      'time' : '1시간전',
    },
    {
      'title' : '빨래널기2',
      'type' : '2',
      'time' : '2시간전',
    },
    {
      'title' : '빨래널기3',
      'type' : '2',
      'time' : '12시간전',
    },
    {
      'title' : '빨래널기4',
      'type' : '1',
      'time' : '19시간 전',
    },
    {
      'title' : '빨래널기5',
      'type' : '1',
      'time' : '하루 전',
    },
    {
      'title' : '빨래널기6',
      'type' : '2',
      'time' : '하루 전',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:DefaultTabController(
          length: myTabs.length,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                TabBar(
                  dividerColor: Colors.red,
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
                Expanded(
                  child: TabBarView(
                    children:
                      myTabs.map((obj) {
                        final String type = '$obj["type"].toString()';
                        return AlarmList(type: type, list: List<Map<String, String>>.from(data),);
                      }).toList(),
                  ),
                ),
              ],
            ),
        )
      )
    );
  }
}

