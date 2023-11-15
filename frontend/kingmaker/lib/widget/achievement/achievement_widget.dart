import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:kingmaker/dto/reward_dto.dart';
import 'package:intl/intl.dart';

class AchievementWidget extends StatefulWidget {
  const AchievementWidget({super.key, required this.data});
  final RewardDto data;
  @override
  State<AchievementWidget> createState() => _AchievementWidgetState();
}

class _AchievementWidgetState extends State<AchievementWidget> {
  String formatTimestamp(String time) {
    DateTime dateTime = DateTime.parse(time);
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    // 위젯의 'achieved_yn' 값에 따라 배경색과 텍스트 내용을 결정합니다.
    final bool isAchieved = widget.data.achieved;
    final Color bgColor = isAchieved ? Colors.white : Colors.grey;
    final int rewardId = isAchieved ? widget.data.rewardId : 0;
    final String rewardNmtText = isAchieved ? widget.data.rewardNm : "미달성 업적";
    final String rewardContText = isAchieved ? widget.data.rewardCond : '${widget.data.rewardPercent}% 달성';
    final String rewardMsgText = isAchieved ? widget.data.rewardMsg : "달성을 위해 열심히 일정을 수행하세요!";
    final String rewardDateText = isAchieved ? '업적 달성일 : ${formatTimestamp(widget.data.modifiedAt)}' : " ";
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
            border: Border.all(width: 1, color: Colors.black26),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
               Flexible(
                  child: Image(
                    image: AssetImage('assets/achievement/${rewardId}.png'),
                    height: 100,
                    width: 100,
                    alignment: Alignment.centerLeft,
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
            border: Border.all(width: 1, color: Colors.black26),
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
                          Expanded(
                            child: Text(
                              '${rewardMsgText}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ),

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
