import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LIGHTEST_BLUE_COLOR,
        body: SingleChildScrollView(
            child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  const GenderImg(),
                  SizedBox(
                    height: 80,
                  ),
                  const SignupText(
                    line1: '당신은 왕국의 태조입니다.',
                    line2: '왕국의 이름은?',
                  ),
                  SizedBox(height: 40,),
                  const SignupWriteKingdom(),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: Image.asset('assets/icon/left.png')),
              ],
            ),
          ],
        )),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 84),
          child: ElevatedButton(
              onPressed: () async {
                String kdName =
                  Provider.of<KingdomProvider>(context, listen: false)
                        .kingdomName;
                String error =
                  Provider.of<KingdomProvider>(context, listen: false)
                        .errorMessage;
                int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
                if (kdName != "" && error == " ") {
                  print('건국하기 버튼 클릭 잘됨 if 안');
                  await Provider.of<MemberProvider>(context, listen: false).signup(kdName);
                  await Provider.of<MemberProvider>(context, listen: false).getMember();
                  memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
                  Provider.of<KingdomProvider>(context, listen: false).getKingdom(memberId!);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavBar()),
                      (route) => false);
                }
              },
              child: const Text("건국하기",
                  style: TextStyle(color: WHITE_COLOR, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: BLUE_COLOR)),
        ),
      ),
    );
  }
}
