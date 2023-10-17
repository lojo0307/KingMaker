import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:kingmaker/widget/common/bottom_nav_bar.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    String img = "assets/signup/story1.png";
    List<String> storyList = [
      "약속장소로 급하게 뛰어가던 당신 ",
      "핸들이 고장난 8t 트럭에 부딪히는데...",
      "눈을 뜬 당신 앞에 등장한 여신...",
      '“이세계에 가서 규칙적인 삶을 산다면..."',
      '"당신은 왕이 될 것이다!"'];
    return Scaffold(
      backgroundColor: Colors.black,
      body:GestureDetector(
        onTap: (){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavBar()), (route) => false
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage(img), height: 300),
            const SizedBox(height: 200),
            SizedBox(
              height: 100,
              child: AnimatedTextKit(
                animatedTexts: [
                  ...List.generate(storyList.length, (index) =>
                      TypewriterAnimatedText(
                        storyList[index],
                        textAlign: TextAlign.center,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        speed: const Duration(milliseconds: 150),
                      ),
                  ),
                ],
                repeatForever: false,
                isRepeatingAnimation: false,
                displayFullTextOnTap: true,
                stopPauseOnTap: false,
                pause: const Duration(milliseconds: 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

