import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/dto/alarm_dto.dart';
import 'package:kingmaker/provider/alarm_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:provider/provider.dart';
class AlarmCard extends StatelessWidget {
  const AlarmCard({super.key, required this.data, required this.delFlag});
  final AlarmDto data;
  final delFlag;
  static const type = ['전체', '아침 알림' ,'할일 알림', '루틴 알림', '저녁 알림'];
  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.black45,
              width: 1.0,
            ),
          ),
        ),
        margin: EdgeInsets.fromLTRB(0.0,2.0,0.0,2.0),
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 20,
                        width: 30,
                        child: Image.asset('assets/images/Slime.png')),
                    Text(type[data.type], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: BLUE_BLACK_COLOR),),
                  ],
                ),
                Row(
                  children: [
                    Text(data.sendtime, style: const TextStyle(fontSize: 14, color: DARK_GREY_COLOR ),),
                    (delFlag)? TextButton( onPressed: () async {
                      int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
                      await Provider.of<AlarmProvider>(context, listen: false).deleteAlarm(data.notificationId);
                      Provider.of<AlarmProvider>(context, listen: false).getAlarm(memberId!);
                    }, child: Image.asset('assets/icon/delete.png',), ): const SizedBox.shrink()
                  ],
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(data.message, style: const TextStyle(fontSize: 13, color: BLUE_BLACK_COLOR
            ),),
          ],
        ),
      );
  }
}
