import 'package:flutter/material.dart';
import 'package:kingmaker/page/story_page.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/widget/common/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../api/fcm_api.dart';
import '../../provider/kingdom_provider.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MemberProvider>(context);
    final providerKing = Provider.of<KingdomProvider>(context);
    final FcmApi fcmApi=FcmApi();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 60),
              const Image(image: AssetImage('assets/login/kingMaker.png'), height: 150),
              const SizedBox(height: 160),
              GestureDetector(
                onTap: () async{
                  int flag = await provider.GoogleLogin();
                  if(flag != 0){
                     Provider.of<KingdomProvider>(context, listen: false).getKingdom(flag);
                  }
                  print("로그인 위젯 플래그 값 : ${flag}");
                  movPage(flag, context, provider.member!.memberId, providerKing);
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: const Image(image: AssetImage('assets/login/googleLogin.png'))
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async{
                  int flag = await provider.KakaoLogin();
<<<<<<< bd255d85a702689ee2bbe942e61ab82d48f54788
                  if(flag != 0){
                    Provider.of<KingdomProvider>(context, listen: false).getKingdom(flag);
                  }
                  print(flag);
                  movPage(flag, context);
=======
                  movPage(flag, context, provider.member!.memberId, providerKing);
>>>>>>> e4b3a8d3f8dab1d6d1cbcea9c099f1b19c5340dc
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: const Image(
                        image: AssetImage('assets/login/kakaoLogin.png')),
                ),
              ),
            ],
        ),
      ),
    );
  }

  void movPage(int flag, BuildContext context, int memberId, KingdomProvider providerKing) {
    if (flag == -1)
      return;
    if (flag == 1){
      providerKing.getKingdom(memberId!);
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => (flag == 0 ? StoryPage() : BottomNavBar())), (route) => false
    );
  }
}
