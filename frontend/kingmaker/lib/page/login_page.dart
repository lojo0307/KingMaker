import 'package:flutter/material.dart';
import 'package:kingmaker/widget/login/login_widget.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/login/login.png'), // 배경 이미지
          ),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent, // 배경색을 투명으로 설정
          body: LoginWidget(),
        ),
      );
  }
}
