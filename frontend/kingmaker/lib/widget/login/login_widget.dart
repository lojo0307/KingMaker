import 'package:flutter/material.dart';
import 'package:kingmaker/page/story_page.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/widget/common/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MemberProvider>(context);
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
                  print("로그인 위젯 플래그 값 : ${flag}");
                  movPage(flag, context);
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
                  print(flag);
                  movPage(flag, context);
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

  void movPage(int flag, BuildContext context) {
    if (flag == -1)
      return;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => (flag == 0 ? StoryPage() : BottomNavBar())), (route) => false
    );
  }
}
