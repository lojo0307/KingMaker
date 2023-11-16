import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/dto/reward_dto.dart';
import 'package:kingmaker/provider/achievement_provider.dart';
import 'package:kingmaker/widget/achievement/achievement_page.dart';
import 'package:kingmaker/widget/profile/profile_achievement_icon_widget.dart';
import 'package:provider/provider.dart';

class ProfileAchievementWidget extends StatefulWidget {
  const ProfileAchievementWidget({super.key});

  @override
  State<ProfileAchievementWidget> createState() =>
      _ProfileAchievementWidgetState();
}

class _ProfileAchievementWidgetState extends State<ProfileAchievementWidget> {
  @override
  Widget build(BuildContext context) {
    List<RewardDto> list = context.watch<AchievementProvider>().list;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: WHITE_COLOR,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '달성한 업적',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AchievementPage()));
                        },
                        child: Row(
                          children: [
                            Text(
                              '더보기',
                              style: TextStyle(fontSize: 12, color: BLUE_BLACK_COLOR),
                            ),
                            SvgPicture.asset('assets/icon/ic_right.svg')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                //이 부분에 위젯이 들어가야해
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: getMyRewardFour(list),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  getMyRewardFour(List<RewardDto> list) {
    List<Widget> resList = [];
    if (list.isEmpty) {
      return [Container()];
    }
    for (int i = 0; i < 4; i++) {
      RewardDto now = list.elementAt(i);
      if (now.achieved) {
        resList.add(ProfileAchievementIconWidget(data: now));
      } else {
        resList.add(SizedBox(width: MediaQuery.of(context).size.width / 4 - 36,));
      }
    }
    if (resList.isEmpty) {
      return [Container()];
    }
    return resList;
  }
}
