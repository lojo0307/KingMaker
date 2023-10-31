import 'package:flutter/material.dart';
import 'package:kingmaker/widget/profile/profile_calendar_widget.dart';
import 'package:kingmaker/widget/profile/profile_char_image_widget.dart';
import 'package:kingmaker/widget/profile/profile_kingdom_widget.dart';
import 'package:kingmaker/widget/profile/profile_score_widget.dart';
import 'package:kingmaker/widget/profile/profile_name_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return
        Scaffold(
        backgroundColor: const Color(0xFFEDF1FF),
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
