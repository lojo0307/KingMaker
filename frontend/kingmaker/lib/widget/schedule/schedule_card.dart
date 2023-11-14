import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/page/todo_detail_page.dart';
import 'package:kingmaker/provider/achievement_provider.dart';
import 'package:kingmaker/provider/calendar_provider.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:kingmaker/widget/schedule/schedule_info.dart';
import 'package:provider/provider.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({super.key, required this.data});

  final Map<String, String> data;

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Provider.of<ScheduleProvider>(context, listen: false)
            .getDetail(int.parse(widget.data['id']!), widget.data['type']!);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TodoDetailPage()));
      },
      child: Container(
        height: 80,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(
          //   color: BLUE_BLACK_COLOR,
          //   width: 1,
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border:
                      Border(right: BorderSide(width: 1, color: LIGHT_GREY_COLOR)),
                ),
                height: 60,
                width: 80,
                child: Image.asset(
                    'assets/character/calendarlist/${widget.data['category']}.gif',
                    scale: 0.2),
              ),
            ),
            ScheduleInfo(
              data: widget.data,
            ),
            Container(
                margin: EdgeInsets.only(right: 15),
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.data['type'] == '2') {
                      Provider.of<ScheduleProvider>(context, listen: false)
                          .achieveRoutine(int.parse(widget.data['id']!));
                    } else {
                      Provider.of<ScheduleProvider>(context, listen: false)
                          .achieveTodo(int.parse(widget.data['id']!));
                    }
                    int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
                    DateTime now = DateTime.now();
                    int year = now.year;
                    int month = now.month;
                    int day = now.day;
                    Provider.of<CalendarProvider>(context, listen: false).getMyCal(memberId!, year, month);
                    Provider.of<KingdomProvider>(context, listen: false).getKingdom(memberId!);
                    Provider.of<ScheduleProvider>(context, listen: false).getList(memberId!, year, month, day);
                    Provider.of<AchievementProvider>(context, listen: false).getAllData(memberId!);
                  },
                  child: (widget.data['achieved'] == '0')
                      ? Text('수행', style: TextStyle(color: BLUE_BLACK_COLOR, fontSize: 14.0))
                      : Text('완료', style: TextStyle(color: BLUE_BLACK_COLOR, fontSize: 14.0)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    backgroundColor: (widget.data['achieved'] == '0') ? LIGHT_YELLOW_COLOR : Color(0XFFC7F4B3),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
