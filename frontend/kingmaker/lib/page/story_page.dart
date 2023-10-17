import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    String img = "assets/signup/story1.png";
    List<String> storyList = [
      "약속을 까먹고 급하게 뛰어가던 000 ",
      "핸들이 고장난 8톤 트럭에 부딫히고 마는데...",
      "눈을 뜬 000 앞에 등장한 여신...",
      '“이세계에 가서 규칙적인 삶을 산다면 너는 왕이 될 것이다!"'];
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage(img), height: 300),
          SizedBox(
            height: 200,
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  '약속을 까먹고 급하게 뛰어가던 000\n핸들이 고장난 8톤 트럭에 부딫히고 마는데...\n눈을 뜬 000 앞에 등장한 여신...\n“이세계에 가서 규칙적인 삶을 산다면 너는 왕이 될 것이다!"',
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  speed: const Duration(milliseconds: 150),
                ),
              ],
              repeatForever: false,
              isRepeatingAnimation: false,
              pause: const Duration(),
              displayFullTextOnTap: true,
              stopPauseOnTap: false,
            ),
          ),
        ],
      ),
    );
  }
}

