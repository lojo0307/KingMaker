import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/main/main_expbar.dart';
import 'package:kingmaker/widget/main/main_game.dart';
import 'package:provider/provider.dart';

import '../provider/member_provider.dart';
import '../provider/schedule_provider.dart';
import '../widget/bgm/mute_button.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future< List<Map<String, String>>>? _loadDataFuture;
  @override
  void initState()  {

    super.initState();
    _loadDataFuture = _loadData();
  }
  @override
  void dispose() {
    super.dispose();
  }
  Future< List<Map<String, String>>> _loadData() async {
    DateTime now = DateTime.now();
    int? memberId = await Provider.of<MemberProvider>(context, listen: false).member?.memberId;
    if (memberId != null) {
      await Provider.of<ScheduleProvider>(context, listen: false).getMainList(memberId, now.year, now.month, now.day);
      List<Map<String, String>> data =await Provider.of<ScheduleProvider>(context, listen: false).list;
      return data;
    }
    throw Exception('Member ID is null');
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FutureBuilder< List<Map<String, String>>>(
        future: _loadDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // print('### homepage_build : $snapshot.data');
            return Stack(
              children: [
                GameWidget.controlled(
                  gameFactory: () => MyGame(context, snapshot.data!),
                ),

                Container(
                  margin: EdgeInsets.only(top: 110, left: 7),
                  child: MuteButton(),
                ),
                ExpBar(),
              ],
            );
          } else {
            // 데이터 로딩에 실패했거나, 아직 데이터가 없을 때
            return Text('No data available');
          }
        },
      ),

    );
  }

}

