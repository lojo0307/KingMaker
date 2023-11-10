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
  void initState() {
    DateTime now = DateTime.now();
    int? memberId = Provider.of<MemberProvider>(context,listen: false).member?.memberId;
    Provider.of<ScheduleProvider>(context, listen: false).getList(memberId!, now.year, now.month, now.day);
    super.initState();
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
              gameFactory:()=> MyGame(context,)
          ),
          ExpBar(),
        ],
      )
    );
  }
}

