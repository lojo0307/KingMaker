import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/dto/alarm_dto.dart';
import 'package:kingmaker/provider/alarm_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/widget/alarm/alarm_list.dart';
import 'package:provider/provider.dart';
class AlarmMain extends StatefulWidget {
  const AlarmMain({super.key});
  @override
  State<AlarmMain> createState() => _AlarmMainState();
}
class _AlarmMainState extends State<AlarmMain> {
  static const myTabs = [
    { 'text': '전체', 'type': 0,},
    {'text': '할일', 'type': 1,},
    {'text': '루틴', 'type': 2,},
  ];
  static bool delFlag = false;
  @override
  void initState() {
    int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
    Provider.of<AlarmProvider>(context, listen: false).getAlarm(memberId!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<AlarmDto> list = context.watch<AlarmProvider>().list;
    return DefaultTabController(
          length: myTabs.length,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                children:[
                  (delFlag)?
                  TextButton(onPressed: () {
                    delFlag = false;
                    setState(() {});
                  }, child: SvgPicture.asset('assets/icon/ic_left.svg', height: 24.0,)
                  )
                      : const SizedBox.shrink(),
                  Spacer(),
                  (delFlag)? TextButton(onPressed: () async {
                    int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
                    await Provider.of<AlarmProvider>(context, listen: false).deleteAll();
                    delFlag = false;
                    setState(() {});
                    }, child: Text('전체삭제   ', style: TextStyle(fontSize: 12.0, color: DARKER_GREY_COLOR),),)
                      : TextButton( onPressed: () {
                        delFlag = true;
                        setState(() {});
                          }, child: SvgPicture.asset('assets/icon/ic_trash.svg', height: 24.0,),),
                  ],
                ),
                // const SizedBox(height: 30),
                Expanded(
                  child: AlarmList(list: list, delFlag: delFlag,),
                ),
              ],
            ),
        )
    );
  }
}

