import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';

class AchievementWidget extends StatefulWidget {
  const AchievementWidget({super.key, required this.data});
  final Map<String, String> data;
  @override
  State<AchievementWidget> createState() => _AchievementWidgetState();
}

class _AchievementWidgetState extends State<AchievementWidget> {
  @override
  Widget build(BuildContext context) {
    // 위젯의 'achieved_yn' 값에 따라 배경색과 텍스트 내용을 결정합니다.
    final bool isAchieved = widget.data['achieved_yn'] == '1';
    final Color bgColor = isAchieved ? Colors.white : Colors.grey;
    final String? rewardNmtText = isAchieved ? widget.data['reward_nm'] : "미달성 업적";
    final String? rewardContText = isAchieved ? widget.data['reward_msg'] : widget.data['reward_cont'];
    final String rewardDateText = isAchieved ? '업적 달성일 : ${widget.data['modified_at']}' : " ";
    final con = FlipCardController();
    return FlipCard(
        controller: con,
        rotateSide: RotateSide.right,
        onTapFlipping: true,
        axis: FlipAxis.horizontal,
        frontWidget: Container(
          height: 80,
          margin: EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
            color: bgColor, // 조건에 따른 배경색 설정
            border: Border.all(width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              const Flexible(
                  child: Image(
                    image: AssetImage('assets/achievement/sample.png'),
                    height: 100,
                    width: 100,
                    // color: Colors.red,
                  )
              ),
              Flexible(
                  child: Container(
                    // decoration: BoxDecoration(color: Colors.blue),
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${rewardNmtText}', style: TextStyle(fontSize: 20)),//업적이름/미달성 업적
                        Text('${rewardContText}'), // 조건에 따른 텍스트 내용 설정
                        Text('${rewardDateText}',  style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
        backWidget: Container(
          height: 80,
          margin: EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
            color: bgColor, // 조건에 따른 배경색 설정
            border: Border.all(width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Flexible(
                  child: Container(
                    // decoration: BoxDecoration(color: Colors.blue),
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text('${rewardNmtText}', style: TextStyle(fontSize: 20)),//업적이름/미달성 업적
                        Center(
                          child: Text('${rewardContText}',
                                style: TextStyle(fontSize: 30,
                                      color: Colors.black)
                                  ),
                        )
                        // Text('${rewardDateText}',  style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),

    );
  }
}
