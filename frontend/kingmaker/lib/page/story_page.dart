import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
          AutoSizeText(
            storyList[0],
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            maxLines: 1,
          ),
          AutoSizeText(
            storyList[1],
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            maxLines: 2,
          ),
          AutoSizeText(
            storyList[2],
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            maxLines: 2,
          ),
          AutoSizeText(
            storyList[3],
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

