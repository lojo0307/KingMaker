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
        width: double.infinity,
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
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Container(
                   margin: EdgeInsets.fromLTRB(0.0,2.0,10.0,2.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Container(
                         margin: EdgeInsets.fromLTRB(7.0,0.0,7.0,0.0),
                         padding: EdgeInsets.all(7),
                         decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                           height: 60,
                           width: 60,
                           child: Image.asset('assets/images/notification/noti_butler_${data.notificationTypeId}.png')),
                     ],
                   )
                ),
              ],
            ),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(type[data.notificationTypeId], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: BLUE_BLACK_COLOR),),
                    Text(data.sendtime, style: const TextStyle(fontSize: 15, color: DARK_GREY_COLOR ),),
                    (delFlag)? TextButton( onPressed: () async {
                      int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
                      await Provider.of<AlarmProvider>(context, listen: false).deleteAlarm(data.notificationId);
                      Provider.of<AlarmProvider>(context, listen: false).getAlarm(memberId!);
                    }, child: Image.asset('assets/icon/delete.png',), ): const SizedBox.shrink()
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Container(child: Text(data.message, style: const TextStyle(fontSize: 14, color: BLUE_BLACK_COLOR),),),),
                  ],
                ),
              ],
              ),
            ),
          ],
        ),
      );
  }
}
