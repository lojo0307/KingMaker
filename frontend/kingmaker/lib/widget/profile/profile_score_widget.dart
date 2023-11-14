import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/achievement_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class ProfileScoreWidget extends StatefulWidget {
  const ProfileScoreWidget({super.key});

  @override
  State<ProfileScoreWidget> createState() => _ProfileScoreWidgetState();
}

class _ProfileScoreWidgetState extends State<ProfileScoreWidget> {
  @override
  Widget build(BuildContext context) {

    String maxCategory = context.watch<AchievementProvider>().maxCategory;
    String minCategory = context.watch<AchievementProvider>().minCategory;
    int dailyRate = context.watch<AchievementProvider>().dailyRate;
    int monthlyRate = context.watch<AchievementProvider>().monthlyRate;
    int yearRate = context.watch<AchievementProvider>().yearRate;
    return LayoutBuilder(builder: (ctx, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: constraints.maxWidth - 40,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: WHITE_COLOR,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('몬스터 리포트',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    child: Column(
                      children: [
                        Row(children: [
                          Text("일간  ", style: TextStyle(fontSize: 14                                                                                    ),),
                          SimpleAnimationProgressBar(
                            height: 10,
                            width: constraints.maxWidth*0.6,
                            backgroundColor: GREY_COLOR,
                            foregrondColor: BLUE_COLOR,
                            ratio: 0.01*dailyRate,
                            direction: Axis.horizontal,
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(seconds: 3),
                            borderRadius: BorderRadius.circular(10),
                            gradientColor: const LinearGradient(
                                colors: [LIGHT_BLUE_COLOR, BLUE_COLOR]),
                          ),
                          Text('  $dailyRate%', style: TextStyle(fontSize: 12),),
                        ],),
                        Row(children: [
                          Text("월간  ", style: TextStyle(fontSize: 14),),
                          SimpleAnimationProgressBar(
                            height: 10,
                            width: constraints.maxWidth*0.6,
                            backgroundColor: GREY_COLOR,
                            foregrondColor: DARK_BLUE_COLOR,
                            ratio: 0.01*monthlyRate,
                            direction: Axis.horizontal,
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(seconds: 3),
                            borderRadius: BorderRadius.circular(10),
                            gradientColor: const LinearGradient(
                                colors: [BLUE_COLOR, DARK_BLUE_COLOR]),
                          ),
                          Text('  $monthlyRate%', style: TextStyle(fontSize: 12),),
                        ],
                        ),
                        Row(children: [
                          Text("연간  ", style: TextStyle(fontSize: 14),),
                          SimpleAnimationProgressBar(
                            height: 10,
                            width: constraints.maxWidth*0.6,
                            backgroundColor: GREY_COLOR,
                            foregrondColor: DARKER_BLUE_COLOR,
                            ratio: 0.01*yearRate,
                            direction: Axis.horizontal,
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(seconds: 3),
                            borderRadius: BorderRadius.circular(10),
                            gradientColor: const LinearGradient(
                                colors: [DARK_BLUE_COLOR, DARKER_BLUE_COLOR]),
                          ),
                          Text('  $yearRate%', style: TextStyle(fontSize: 12),),
                        ],),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('가장 강력한 몬스터',
                          style: TextStyle(
                            fontSize: 14,
                          ),),
                        Text(maxCategory,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'EsamanruMedium',
                            color: Color(0xFFFA5959),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('가장 약한 몬스터',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(minCategory,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'EsamanruMedium',
                            color: Color(0xFF54B08F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )],
      );
    });
  }
}
