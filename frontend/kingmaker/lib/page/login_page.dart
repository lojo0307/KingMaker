import 'package:flutter/material.dart';
import 'package:kingmaker/widget/login/login_widget.dart';

import '../widget/bgm/audioplayer_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AudioPlayerHelper _audioPlayerHelper = AudioPlayerHelper();

  @override
  void initState() {
    super.initState();
    _audioPlayerHelper.playLoginMusic('loginBgm.mp3'); // 배경음악 재생
  }

  @override
  void dispose() {
    _audioPlayerHelper.dispose(); // 리소스 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/login/login.png'),
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: LoginWidget(),
      ),
    );
  }
}
