import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kingmaker/page/signup/make_myname_widget.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:provider/provider.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  List<String> imgList = ["assets/signup/story1.png", "assets/signup/story2.png", "assets/signup/story3.png"];
  List<String> storyList = [
    " 약속장소로 급하게 뛰어가던 당신 ",
    " 핸들이 고장난 8톤 트럭에 부딪히는데... ",
    "눈을 뜬 당신 앞에 등장한 여신... ",
    '이세계에 가서 규칙적인 삶을 산다면... ',
    '너는 왕이 될 것이다! '];
  int imgIdx = 0;
  int storyIdx = 0;
  int idx = 0;
  String viewString = "";
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    roof();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {clickPage();},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: 100),
            Image(image: AssetImage(imgList[imgIdx]), height: 300),
            Container(height: 100),
            SizedBox(
              height: 100,
              child: Text(
                viewString,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: storyIdx == 3 || storyIdx == 4 ? const Color(0xFFFF0000) : Colors.white,
                ),
              ),
            ),
            Container(height: 100),
          ],
        ),
      ),
    );
  }
  void roof() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        viewString = storyList[storyIdx].substring(0, idx++);
        if (storyList[storyIdx].length == idx) {
          _timer.cancel();
        }
      });
    });
  }

  clickPage() async{
    if (storyIdx == 4 && storyList[storyIdx].length == idx){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<MemberProvider>(context, listen: false).setNickName("");
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MakeMynamePage())
      );
    }
    else if (storyList[storyIdx].length == idx){
      if (storyIdx == 0 || storyIdx == 1){
        imgIdx++;
      }
      viewString = "";
      storyIdx++;
      idx = 0;
      roof();
    }else{
      viewString = storyList[storyIdx];
      idx = storyList[storyIdx].length;
      _timer.cancel();
      setState(() {});
    }
  }
}
