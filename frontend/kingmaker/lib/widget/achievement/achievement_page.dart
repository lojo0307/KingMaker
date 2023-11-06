import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'achievement_widget.dart';

class AchievementPage extends StatefulWidget {
  const AchievementPage({super.key});

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  List<Map<String,String>> list = [
    {'reward_nm': '알린모찌맛있따','reward_cont':'알린모찌를 먹어봄','reward_msg':'맛있냐?','reward_id':'1','achieved_yn':'1','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따','reward_cont':'알린모찌를 먹어봄','reward_msg':'맛있냐?','reward_id':'1','achieved_yn':'1','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따','reward_cont':'알린모찌를 먹어봄','reward_msg':'맛있냐?','reward_id':'1','achieved_yn':'0','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따','reward_cont':'알린모찌를 먹어봄','reward_msg':'맛있냐?','reward_id':'1','achieved_yn':'0','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따','reward_cont':'알린모찌를 먹어봄','reward_msg':'맛있냐?','reward_id':'1','achieved_yn':'0','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따','reward_cont':'알린모찌를 먹어봄','reward_msg':'맛있냐?','reward_id':'1','achieved_yn':'0','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따','reward_cont':'알린모찌를 먹어봄','reward_msg':'맛있냐?','reward_id':'1','achieved_yn':'0','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따','reward_cont':'알린모찌를 먹어봄','reward_msg':'맛있냐?','reward_id':'1','achieved_yn':'0','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따','reward_cont':'알린모찌를 먹어봄','reward_msg':'맛있냐?','reward_id':'1','achieved_yn':'0','modified_at':'2023-02-01 03:10'},
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      return Scaffold(
        backgroundColor: Color(0xFFEDF1FF),
        appBar: AppBar(
          backgroundColor: Color(0xFFEDF1FF),
          leading: IconButton(
            icon: const Icon(Icons.navigate_before,),
            tooltip: '이전 페이지',
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
          title: const Text('업적'),
          centerTitle: true,
        ),
        body:Container( // Wrap ListView in a Container
        // height: 0, // Fixed height for horizontal ListView
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10),
          itemCount:list.length,
          itemBuilder: (context, index) {
              return AchievementWidget(data: list[index]); // Return AchievementWidget
          },
        ),
      ),
      );
    });
  }
}
