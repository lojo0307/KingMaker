import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
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
    {
      'text': '    전체    ',
      'type': 0,
    },
    {
      'text': '    할 일    ',
      'type': 1,
    },
    {
      'text': '    루틴    ',
      'type': 2,
    },
  ];

  @override
  void initState() {
    DateTime now = DateTime.now();
    int? memberId =
        Provider.of<MemberProvider>(context, listen: false).member?.memberId;
    Provider.of<ScheduleProvider>(context, listen: false)
        .getList(memberId!, now.year, now.month, now.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> data = context.watch<ScheduleProvider>().list;
    return DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          backgroundColor: LIGHTEST_BLUE_COLOR,
          body: SafeArea(
            child: Column(
              children: [
                Header(title: '일정'),
                SizedBox(
                  height: 10,
                ),
                TabBar(
                  overlayColor: MaterialStatePropertyAll(Colors.transparent),
                  indicatorColor: BLUE_BLACK_COLOR,
                  indicatorWeight: 0.0001,
                  labelColor: BLUE_BLACK_COLOR,
                  unselectedLabelColor: DARK_GREY_COLOR,
                  dividerColor: Colors.transparent,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'PretendardBold',
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  // indicatorWeight: 0.00005,
                  tabs: myTabs.map((obj) {
                    String title = obj['text'].toString();
                    return Tab(
                      text: title,
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Consumer<ScheduleProvider>(
                    builder: (BuildContext context, ScheduleProvider value,
                        Widget? child) {
                      return TabBarView(
                        children: myTabs.map((obj) {
                          final String type = obj["type"].toString();
                          return ScheduleSet(
                            type: type,
                            list: data,
                          );
                        }).toList(),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
