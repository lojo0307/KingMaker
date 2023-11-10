import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/main/main_expbar.dart';
import 'package:kingmaker/widget/main/main_game.dart';
import 'package:provider/provider.dart';

import '../provider/member_provider.dart';
import '../provider/schedule_provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState()  {

    super.initState();
    loadData();
  }
  void loadData() {
    DateTime now = DateTime.now();
    int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
    // memberId가 null이 아닐 때만 getList를 호출합니다.
    if (memberId != null) {
      Provider.of<ScheduleProvider>(context, listen: false)
          .getList(memberId, now.year, now.month, now.day)
          .then((_) {
            print('getList 완료 !!!!!!!!!!!');
            setState(() {
            });
        // 데이터 로딩이 완료된 후 수행할 작업을 여기에 넣습니다.
        // 예를 들어, setState를 호출하여 UI를 업데이트할 수 있습니다.
      }).catchError((error) {
        // 여기에서 에러를 처리합니다.
      });
    }
  }
  // print(Provider);
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> data = context.watch<ScheduleProvider>().list;
    print('_HomePageState -data :  $data');
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [

          GameWidget.controlled(
              gameFactory:()=> MyGame(context, data),
          ),
          ExpBar(),
        ],
      )
    );
  }
}

