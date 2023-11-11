import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/widget/common/bottom_nav_bar.dart';
import 'package:kingmaker/widget/signup/gender_img.dart';

import 'package:kingmaker/widget/signup/select_gender.dart';
import 'package:kingmaker/widget/signup/signup_text.dart';
import 'package:kingmaker/widget/signup/signup_write_kingdom.dart';
import 'package:provider/provider.dart';
class MakeKingDomPage extends StatefulWidget {
  const MakeKingDomPage({super.key});

  @override
  State<MakeKingDomPage> createState() => _MakeKingDomPageState();
}

class _MakeKingDomPageState extends State<MakeKingDomPage> {
  int mainColor = 0xFFEDF1FF;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(mainColor),
      body: SingleChildScrollView(
        child:Stack(
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const GenderImg(),
                const SignupText(line1: '당신은 왕국의 태조입니다.', line2: '왕국의 이름은?',),
                const SignupWriteKingdom(),
                ElevatedButton(onPressed: () {
                  String kdName = Provider.of<KingdomProvider>(context, listen: false).kingdomName;
                  String error = Provider.of<KingdomProvider>(context, listen: false).errorMessage;
                  if (kdName != "" && error == " "){
                    print('건국하기 버튼 클릭 잘됨 if 안');
                    Provider.of<MemberProvider>(context, listen: false).signup(kdName);
                    Provider.of<KingdomProvider>(context, listen: false).makeKingdom();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavBar()), (route) => false
                    );
                  }
                }, child: const Text("건국하기")),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                ),
                TextButton(onPressed: () {
                  Navigator.pop(
                    context,
                  );
                }, child: Image.asset('assets/icon/left.png')),
              ],
            ),
          ],
        )
      ),
    );
  }
}