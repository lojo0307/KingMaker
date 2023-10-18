import 'package:flutter/material.dart';
import 'package:kingmaker/page/story/story_page.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

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
              const SizedBox(height: 100),
              const SizedBox(height: 60),
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
              const SizedBox(height: 20),
              SocialLoginButton(
                height: 53,
                backgroundColor: Colors.white,
                text: '구글 로그인',
                fontSize: 18,
                borderRadius: 5,
                width: 350,
                buttonType: SocialLoginButtonType.google,
                onPressed: () async {
                  await GoogleLogin();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StoryPage()), (route) => false
                  );
                },
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
