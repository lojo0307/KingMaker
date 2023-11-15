import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/dto/reward_dto.dart';
import 'package:intl/intl.dart';

class AchievementWidget extends StatefulWidget {
  const AchievementWidget({super.key, required this.data, required this.firstIdx});

  final RewardDto data;
  final bool firstIdx;

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
    final Color bgColor = isAchieved ? WHITE_COLOR : GREY_COLOR;
    final int rewardId = isAchieved ? widget.data.rewardId : 0;
    final String rewardNmtText = isAchieved ? widget.data.rewardNm : "미달성 업적";
    final String rewardContText = isAchieved
        ? widget.data.rewardCond
        : '${widget.data.rewardPercent}% 달성';
    final String rewardMsgText =
        isAchieved ? widget.data.rewardMsg : "달성을 위해 열심히 일정을 수행하세요!";
    final String rewardDateText = isAchieved
        ? '업적 달성일 : ${formatTimestamp(widget.data.modifiedAt)}'
        : " ";
    final con = FlipCardController();
    return FlipCard(
      controller: con,
      rotateSide: RotateSide.right,
      onTapFlipping: true,
      axis: FlipAxis.horizontal,
      frontWidget: Container(
        height: 80,
        margin: widget.firstIdx ? EdgeInsets.symmetric(vertical: 12) : EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: bgColor, // 조건에 따른 배경색 설정
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image(
                width: 88,
                height: 80,
                image: AssetImage('assets/achievement/${rewardId}.png'),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('${rewardNmtText}', style: TextStyle(fontSize: 16, color: BLUE_BLACK_COLOR)),
                      ),
                      SizedBox(height: 4,),
                      Text('${rewardContText}', style: TextStyle(fontSize: 12, color: BLUE_BLACK_COLOR)),
                      SizedBox(height: 4,),
                      isAchieved ? Text('${rewardDateText}', style: TextStyle(fontSize: 9, color: DARK_GREY_COLOR)) : SizedBox()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backWidget: Container(
        height: 80,
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: bgColor, // 조건에 따른 배경색 설정
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          children: [
            Flexible(
                child: Container(
              // decoration: BoxDecoration(color: Colors.blue),
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('${rewardNmtText}', style: TextStyle(fontSize: 20)),//업적이름/미달성 업적
                  Expanded(
                    child: Text(
                      '${rewardMsgText}',
                      style: TextStyle(
                        fontSize: 14,
                        color: BLUE_BLACK_COLOR,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Text('${rewardDateText}',  style: TextStyle(fontSize: 10)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
