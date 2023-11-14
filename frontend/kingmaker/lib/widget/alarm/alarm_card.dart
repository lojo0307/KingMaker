import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/dto/alarm_dto.dart';
import 'package:kingmaker/provider/alarm_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:provider/provider.dart';
class AlarmCard extends StatelessWidget {
  const AlarmCard({super.key, required this.data, required this.delFlag, required this.lastIdx});
  final AlarmDto data;
  final delFlag;
  final bool lastIdx;
  static const type = ['전체', '아침 알림' ,'할일 알림', '루틴 알림', '저녁 알림'];
  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: lastIdx ? Border() : Border(
            bottom: BorderSide(
              color: DARKER_GREY_COLOR,
              width: 0.3,
            ),
          ),

        ),
        margin: EdgeInsets.fromLTRB(0.0,2.0,0.0,2.0),
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                    height: 40,
                    width: 40,
                    child: Image.asset('assets/images/notification/noti_butler_${data.notificationTypeId}.png')),
                SizedBox(width: 12,),
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(type[data.notificationTypeId], style: const TextStyle(fontSize: 16, color: BLUE_BLACK_COLOR),),
                        Text(data.sendtime, style: const TextStyle(fontSize: 12, color: DARK_GREY_COLOR ),),
                        (delFlag)? GestureDetector(
                          onTap: () async {
                            int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
                            await Provider.of<AlarmProvider>(context, listen: false).deleteAlarm(data.notificationId);
                            Provider.of<AlarmProvider>(context, listen: false).getAlarm(memberId!);
                          }, child: SvgPicture.asset('assets/icon/ic_delete.svg', height: 20,),
                        ): const SizedBox.shrink()
                      ],
                    ),
                    SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Container(child: Text(data.message, style: const TextStyle(fontSize: 12, color: DARKER_GREY_COLOR),),),),
                      ],
                    ),
                  ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }
}
