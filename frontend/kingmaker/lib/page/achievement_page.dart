import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AchivementPage extends StatefulWidget {
  const AchivementPage({super.key});

  @override
  State<AchivementPage> createState() => _AchivementPageState();
}

class _AchivementPageState extends State<AchivementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEDF1FF),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children:[
                SizedBox(height: 20,),
                Stack(
                  children: [
                    Container(
                      height: 40,
                      child: IconButton(
                        icon: const Icon(Icons.navigate_before,),
                        tooltip: '이 전 페이지',
                        onPressed: () {
                          print("click");
                        },
                        iconSize: 30,
                      ),
                    ),
                    Container(
                      height: 44,
                      child: Center(child:Title(
                        color: Colors.black,
                        child: Text('몬스터 정보'),
                      ),
                      ),
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }
}
