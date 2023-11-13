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
    return LayoutBuilder(builder: (ctx, constraints) {
      return
        Scaffold(
          backgroundColor: LIGHTEST_BLUE_COLOR,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Image(
                image: const AssetImage('assets/castle/castle.png'),fit: BoxFit.cover, width: constraints.maxWidth * 1,height: 300,
              ),
              const Column(
                children: [
                  SizedBox(height: 225,),
                  ProfileCharImageWidget(),
                  SizedBox(height: 5,),
                  ProfileNameWidget(),
                  SizedBox(height: 5,),
                  ProfileKingdomWidget(),
                  SizedBox(height: 5,),
                  ProfileScoreWidget(),
                  SizedBox(height: 5,),
                  ProfileAchievementWidget(),
                  SizedBox(height: 5,),
                  ProfileCalendarWidget(),
                  SizedBox(height: 20,),
                ],
              ),
            ],
          ),
        ),

      );
    });
  }
}
