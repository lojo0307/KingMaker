import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/achievement/achievement_page.dart';
import 'package:kingmaker/widget/profile/profile_achievement_icon_widget.dart';

class ProfileAchievementWidget extends StatefulWidget {
  const ProfileAchievementWidget({super.key});

  @override
  State<ProfileAchievementWidget> createState() => _ProfileAchievementWidgetState();
}

class _ProfileAchievementWidgetState extends State<ProfileAchievementWidget> {
  List<Map<String,String>> list = [
    {'award_nm': '알린모찌호소인1','award_img': 'sample'},
    {'award_nm': '알린모찌호소인2','award_img': 'sample'},
    {'award_nm': '알린모찌호소인3','award_img': 'sample'}
  ];


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: constraints.maxWidth - 40,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('달성한 업적',
                        style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              // backgroundColor: Colors.blue
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AchievementPage())
                                );
                              },
                            child: const Text('더보기', style: TextStyle(fontSize: 12),),
                          ),
                          Container(
                            width: 26,
                            height: 26,
                            // decoration: BoxDecoration(color: Colors.red),
                            child: IconButton(
                              // color: Colors.red,
                              icon: Image.asset('assets/icon/tight_right.png',
                                scale: 1.4,),
                              // padding: EdgeInsets.only(left: -10),
                              onPressed: () {
                                print("click");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AchievementPage())
                                );
                              },
                              iconSize: 10,
                            ),
                          )
                        ],
                      )

                    ],
                  ),
                ),

                //이 부분에 위젯이 들어가야해
                Wrap(
                  spacing: 11.0, // 각 아이콘 사이의 가로 간격
                  runSpacing: 7.0, // 각 아이콘 줄 사이의 세로 간격
                  children: list.map((Map<String, String> info) {
                    return ProfileAchievementIconWidget(data: info);
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
