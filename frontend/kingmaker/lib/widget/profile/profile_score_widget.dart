import 'package:flutter/material.dart';
import 'package:kingmaker/provider/achievement_provider.dart';
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('달성률',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Row(children: [
                        Text("일간: "),
                        SimpleAnimationProgressBar(
                          height: 10,
                          width: constraints.maxWidth*0.6,
                          backgroundColor: Colors.grey.shade800,
                          foregrondColor: Colors.purple,
                          ratio: 0.01*dailyRate,
                          direction: Axis.horizontal,
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: const Duration(seconds: 3),
                          borderRadius: BorderRadius.circular(10),
                          gradientColor: const LinearGradient(
                              colors: [Colors.pink, Colors.purple]),
                        ),
                        Text('  $dailyRate%'),
                      ],),
                      Row(children: [
                        Text("월간: "),
                        SimpleAnimationProgressBar(
                          height: 10,
                          width: constraints.maxWidth*0.6,
                          backgroundColor: Colors.grey.shade800,
                          foregrondColor: Colors.teal,
                          ratio: 0.01*monthlyRate,
                          direction: Axis.horizontal,
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: const Duration(seconds: 3),
                          borderRadius: BorderRadius.circular(10),
                          gradientColor: const LinearGradient(
                              colors: [Colors.tealAccent, Colors.teal]),
                        ),
                        Text('  $monthlyRate%'),
                      ],
                      ),
                      Row(children: [
                        Text("연간: "),
                        SimpleAnimationProgressBar(
                          height: 10,
                          width: constraints.maxWidth*0.6,
                          backgroundColor: Colors.grey.shade800,
                          foregrondColor: Colors.indigo,
                          ratio: 0.01*yearRate,
                          direction: Axis.horizontal,
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: const Duration(seconds: 3),
                          borderRadius: BorderRadius.circular(10),
                          gradientColor: const LinearGradient(
                              colors: [Colors.indigoAccent, Colors.indigo]),
                        ),
                        Text('  $yearRate%'),
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                      Text(maxCategory,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(minCategory,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )],
      );
    });
  }
}
