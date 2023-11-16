import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/dto/reward_dto.dart';
import 'package:kingmaker/provider/achievement_provider.dart';
import 'package:provider/provider.dart';

import 'achievement_widget.dart';

class AchievementPage extends StatefulWidget {
  const AchievementPage({super.key});

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  @override
  Widget build(BuildContext context) {
    List<RewardDto> list = context.watch<AchievementProvider>().list;
    return LayoutBuilder(builder: (context, constraints){
      return Scaffold(
        backgroundColor: LIGHTEST_BLUE_COLOR,
        appBar: AppBar(
          backgroundColor: LIGHTEST_BLUE_COLOR,
          leading: IconButton(
            icon: SvgPicture.asset('assets/icon/ic_left.svg', height: 24,),
            tooltip: '이전 페이지',
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
          title: Text('업적', style: TextStyle(fontSize: 16, fontFamily: 'EsamanruMedium', color: BLUE_BLACK_COLOR),),
          centerTitle: true,
          elevation: 0,
        ),
        body:Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 24),
          itemCount:list.length,
          itemBuilder: (context, index) {
              return AchievementWidget(data: list[index], firstIdx: index == 0,); // Return AchievementWidget
          },
        ),
      ),
      );
    });
  }
}
