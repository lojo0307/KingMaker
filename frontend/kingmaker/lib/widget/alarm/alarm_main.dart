import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/alarm/alarm_list.dart';
class AlarmMain extends StatefulWidget {
  const AlarmMain({super.key});
  @override
  State<AlarmMain> createState() => _AlarmMainState();
}
class _AlarmMainState extends State<AlarmMain> {
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
      'message' : 'Your Majesty, 몬스터들이 습격해오고 있습니다. 얼른 [ 빨래널기1 ] 를 수행해 놈들을 막아주십시오.',
    },
    {
      'title' : '빨래널기2',
      'type' : '2',
      'time' : '2시간전',
      'message' : '저으어어엉너ㅓ하 몬스터들이 습격해오고 있습니다. 얼른 [ 빨래널기2 ] 를 수행해 놈들을 막아주  십시오.',
    },
    {
      'title' : '빨래널기3',
      'type' : '2',
      'time' : '12시간전',
      'message' : '저으어어엉너ㅓ하 몬스터들이 습격해오고 있습니다. 얼른 [ 빨래널기3 ] 를 수행해 놈들을 막아주  십시오.',
    },
    {
      'title' : '빨래널기4',
      'type' : '1',
      'time' : '19시간 전',
      'message' : '저으어어엉너ㅓ하 몬스터들이 습격해오고 있습니다. 얼른 [ 빨래널기4 ] 를 수행해 놈들을 막아주  십시오.',
    },
    {
      'title' : '빨래널기5',
      'type' : '1',
      'time' : '하루 전',
      'message' : 'Your Majesty, 몬스터들이 습격해오고 있습니다. 얼른 [ 빨래널기5 ] 를 수행해 놈들을 막아주십시오.',
    },
    {
      'title' : '빨래널기6',
      'type' : '2',
      'time' : '하루 전',
      'message' : 'Your Majesty, 몬스터들이 습격해오고 있습니다. 얼른 [ 빨래널기6 ] 를 수행해 놈들을 막아주십시오.',
    },
  ];
  static bool delFlag = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: myTabs.length,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  (delFlag)?
                  TextButton(onPressed: () {
                    delFlag = false;
                    setState(() {});
                  }, child: const Icon(CupertinoIcons.back))
                      : const SizedBox.shrink(),
                  Spacer(),
                  (delFlag)? TextButton(onPressed: () {
                    delFlag = false;
                    setState(() {});
                    }, child: Text('전체삭제'))
                      : TextButton( onPressed: () {
                        delFlag = true;
                        setState(() {});
                          }, child: const Icon(CupertinoIcons.delete), ),
                  ],
                ),
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
                        return AlarmList(type: type, list: data, delFlag: delFlag,);
                      }).toList(),
                  ),
                ),
              ],
            ),
        )
    );
  }
}

