import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/dto/reward_dto.dart';
import 'package:kingmaker/provider/achievement_provider.dart';
import 'package:kingmaker/widget/common/header.dart';
import 'package:provider/provider.dart';

// import 'achievement_modal.dart';
import 'achievement_widget.dart';

class AchievementPage extends StatefulWidget {
  const AchievementPage({super.key});

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  List<Map<String,String>> list = [
    {'reward_nm': '알린모찌맛있따1','reward_cont':'알린모찌를 먹어봄','reward_msg':'알린모찌 맛있냐?','reward_id':'1','achieved_yn':'1','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따2','reward_cont':'알린모찌를 먹어봄','reward_msg':'알린모찌 맛있냐?','reward_id':'1','achieved_yn':'0','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따3','reward_cont':'알린모찌를 먹어봄','reward_msg':'알린모찌 맛있냐?','reward_id':'1','achieved_yn':'0','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따4','reward_cont':'알린모찌를 먹어봄','reward_msg':'알린모찌 맛있냐?','reward_id':'1','achieved_yn':'0','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따5','reward_cont':'알린모찌를 먹어봄','reward_msg':'알린모찌 맛있냐?','reward_id':'1','achieved_yn':'0','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따6','reward_cont':'알린모찌를 먹어봄','reward_msg':'알린모찌 맛있냐?','reward_id':'1','achieved_yn':'1','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따7','reward_cont':'알린모찌를 먹어봄','reward_msg':'알린모찌 맛있냐?','reward_id':'1','achieved_yn':'0','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따8','reward_cont':'알린모찌를 먹어봄','reward_msg':'알린모찌 맛있냐?','reward_id':'1','achieved_yn':'0','modified_at':'2023-02-01 03:10'},
    {'reward_nm': '알린모찌맛있따9','reward_cont':'알린모찌를 먹어봄','reward_msg':'알린모찌 맛있냐?','reward_id':'1','achieved_yn':'0','modified_at':'2023-02-01 03:10'},
  ];

  @override
  void initState() {
    super.initState();
    // 'achieved_yn'이 '1'인 항목을 위로 정렬합니다.
    list.sort((a, b) {
      // 'achieved_yn'이 '1'인 항목을 위로 정렬합니다.
      int aVal = a['achieved_yn'] == '1' ? 0 : 1;
      int bVal = b['achieved_yn'] == '1' ? 0 : 1;
      return aVal.compareTo(bVal);
    });
  }

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
