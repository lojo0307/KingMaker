import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpBar extends StatefulWidget {
  const ExpBar({super.key});

  @override
  State<ExpBar> createState() => _ExpBarState();
}

class _ExpBarState extends State<ExpBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double maxWidth = constraints.maxWidth; // 최대 폭 사용 가능
      // final double maxHeight = constraints.maxHeight; // 최대 높이 사용 가능
      // Row 위젯을 사용하여 Stack 안에 이미지를 채워 넣습니다.
      return Container(
        width: maxWidth, // Container가 전체 폭을 사용하도록 설정합니다.
        height: 65, // 또는 필요한 높이로 조절합니다.
        padding: EdgeInsets.only(top: 25),
        decoration: BoxDecoration(
          color: Colors.white, // 배경색을 하얀색으로 설정합니다.
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)), // 테두리를 둥글게 설정합니다.
        ),
        child:
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                // Container의 너비를 조절합니다.
                width: 40,
                height: 40,
                // color: Colors.white70,
                child: Image.asset('assets/images/expbar/expicon.png', height: 10, width: 10,),
              ),
              Container(
                width: maxWidth-150, // Container의 너비를 조절합니다.
                height: 100,
                // color: Colors.white70,
                child: Image.asset('assets/images/expbar/1_expbar.png', height: 70,),
              ),

              Container(
                padding: EdgeInsets.only(left: 10),
                // Container의 너비를 조절합니다.
                width: 40,
                height: 40,
                // color: Colors.white70,
                child: Image.asset('assets/images/expbar/monstericon.png', height: 10, width: 10,),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 10,top: 3),
                // color: Colors.red,
                // Container의 너비를 조절합니다.
                height: 40,
                // color: Colors.white70,
                child: Text('X 10', style: TextStyle(fontSize: 20),),
              ),
              // Stack의 다른 자식 위젯들이 있다면 여기에 추가합니다.
            ],
          ),
          // Row의 다른 자식 위젯들이 있다면 여기에 추가합니다.

      );
    });
  }
}
