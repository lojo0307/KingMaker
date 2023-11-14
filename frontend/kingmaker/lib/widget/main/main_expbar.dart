import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/dto/kingdom_dto.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ExpBar extends StatefulWidget {
  const ExpBar({super.key});

  @override
  State<ExpBar> createState() => _ExpBarState();
}

class _ExpBarState extends State<ExpBar> {
  @override
  Widget build(BuildContext context) {
    KingdomDto? kingdomDto = context.watch<KingdomProvider>().kingdomDto;
    int leftMonster = context.watch<ScheduleProvider>().leftMonster;
    return LayoutBuilder(builder: (context, constraints) {
      final double maxWidth = constraints.maxWidth;
      return Container(
        margin: EdgeInsets.fromLTRB(10, 55, 10, 0),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

        width: maxWidth,
        height: 55,
        // padding: EdgeInsets.only(top: 25),

        decoration: BoxDecoration(
          color: Colors.white, // 배경색을 하얀색으로 설정합니다.
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
              margin: EdgeInsets.symmetric(vertical: 15),
              padding: EdgeInsets.only(left: 10),

              //bar
              child: LinearPercentIndicator(
                width: 220.0,
                animation: true,
                animationDuration: 100,
                lineHeight: 50.0,

                //백성 수 연결하기!
                //백성 수/100000 을 나타내기
                percent: kingdomDto!.citizen/100000 > 1.0 ? 1.0 : kingdomDto!.citizen/100000,
                center: Text("${kingdomDto?.citizen}명"),

                progressColor: Colors.green,
                barRadius: Radius.circular(10),
              ),

              //img
              // width: maxWidth-150, // Container의 너비를 조절합니다.
              // height: 100,
              // child: Image.asset('assets/images/expbar/1_expbar.png', height: 70,),
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

              child: Text('X $leftMonster', style: TextStyle(fontSize: 20),),
            ),

          ],
        ),


      );
    });
  }
}
