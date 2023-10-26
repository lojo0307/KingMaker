import 'package:flutter/material.dart';
import 'package:kingmaker/page/story_page.dart';
import 'package:kingmaker/widget/common/bottom_nav_bar.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                  await kakaoLogin();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          // builder: (context) => SignupPage()), (route) => false
                          builder: (context) => BottomNavBar()), (route) => false
                  );
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: const Image(
                        image: AssetImage(
                            'assets/login/googleLogin.png'))),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async{
                  await kakaoLogin();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoryPage()), (route) => false
                  );
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: const Image(
                        image: AssetImage(
                            'assets/login/kakaoLogin.png'))),
              ),
            ],
        ),
      ),
    );
  }

  kakaoLogin() {

  }
  GoogleLogin(){

  }
}
