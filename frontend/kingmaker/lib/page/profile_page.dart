import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/achievement_provider.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/widget/profile/profile_calendar_widget.dart';
import 'package:kingmaker/widget/profile/profile_char_image_widget.dart';
import 'package:kingmaker/widget/profile/profile_kingdom_widget.dart';
import 'package:kingmaker/widget/profile/profile_score_widget.dart';
import 'package:kingmaker/widget/profile/profile_name_widget.dart';
import 'package:provider/provider.dart';

import '../widget/profile/profile_achievement_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    int? memberId = Provider.of<MemberProvider>(context,listen: false).member?.memberId;
    Provider.of<AchievementProvider>(context, listen: false).getAllData(memberId!);
    Provider.of<KingdomProvider>(context, listen: false).getKingdom(memberId!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int? data = context.watch<KingdomProvider>().kingdomDto?.level;
    return LayoutBuilder(builder: (ctx, constraints) {
      return
        Scaffold(
          backgroundColor: LIGHTEST_BLUE_COLOR,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Image(
                image: AssetImage('assets/castle/lv${data}.png'),fit: BoxFit.cover, width: constraints.maxWidth * 1,height: 300,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: const Column(
                  children: [
                    SizedBox(height: 225,),
                    ProfileCharImageWidget(),
                    SizedBox(height: 8,),
                    ProfileNameWidget(),
                    SizedBox(height: 24,),
                    ProfileKingdomWidget(),
                    SizedBox(height: 16,),
                    ProfileScoreWidget(),
                    SizedBox(height: 16,),
                    ProfileAchievementWidget(),
                    SizedBox(height: 16,),
                    ProfileCalendarWidget(),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ],
          ),
        ),

      );
    });
  }
}
