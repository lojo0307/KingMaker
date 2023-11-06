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
      final double maxWidth = constraints.maxWidth;
      return Container(
        width: maxWidth,
        height: 72,
        padding: EdgeInsets.only(top: 25),
        decoration: BoxDecoration(
          color: Colors.white54, // 배경색을 하얀색으로 설정합니다.
          // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
        ),
        child:
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),

                width: 35,
                height: 35,

                child: Image.asset('assets/images/expbar/expicon.png', height: 10, width: 10,),
              ),
              Container(
                width: maxWidth-150, // Container의 너비를 조절합니다.
                height: 100,

                child: Image.asset('assets/images/expbar/1_expbar.png', height: 70,),
              ),

              Container(
                padding: EdgeInsets.only(left: 10),

                width: 45,
                height: 45,
                // color: Colors.white70,
                child: Image.asset('assets/images/expbar/monstericon.png', height: 10, width: 10,),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 10,top: 3),
                height: 40,

                child: Text('X 10', style: TextStyle(fontSize: 20),),
              ),

            ],
          ),


      );
    });
  }
}
