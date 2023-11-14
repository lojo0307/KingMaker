import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/calendar_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ProfileCalendarWidget extends StatefulWidget {
  const ProfileCalendarWidget({super.key});

  @override
  State<ProfileCalendarWidget> createState() => _ProfileCalendarWidgetState();
}

class _ProfileCalendarWidgetState extends State<ProfileCalendarWidget> {
  static const calColors = [Colors.white, Color(0xFFFFF0CF),Color(0xFFFEE1CF),Color(0xFFFFBFCF),Color(0xFFFFA9E0),Color(0xFFFFACF0),];
  DateTime? _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    int day = now.day;
    Provider.of<CalendarProvider>(context, listen: false).getMyCal(memberId!, year, month);
    Map<String, int> levels = context.watch<CalendarProvider>().mypage;
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        onPageChanged: (focusedDay) async {
          int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
          await Provider.of<CalendarProvider>(context, listen: false).getMyCal(memberId!, focusedDay.year, focusedDay.month);
          _focusedDay = focusedDay;
        },

        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          headerPadding:EdgeInsets.only(bottom: 8),
          leftChevronIcon: SvgPicture.asset('assets/icon/ic_left.svg', height: 24),
          rightChevronIcon: SvgPicture.asset('assets/icon/ic_right.svg', height: 24),
        ),
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, day) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${day.year}년 ${day.month}월", style: TextStyle(fontSize: 16),),
              ],
            );
          },
          dowBuilder: (context, day) {
            late String dayStr;
            switch(day.weekday){
              case 1: dayStr = 'M'; break;
              case 2: dayStr = 'T'; break;
              case 3: dayStr = 'W'; break;
              case 4: dayStr = 'T'; break;
              case 5: dayStr = 'F'; break;
              case 6: dayStr = 'S'; break;
              case 7: dayStr = 'S'; break;
            }
            return Center(
              child: Text(
                dayStr, style: TextStyle().copyWith(
                color: day.weekday == 7 ? Colors.red : day.weekday == 6 ? Colors.blue : Colors.black,
              ),
              ),
            );
          },
          defaultBuilder: (context, day, focusedDay) {
            int idx = 0;
            if (levels.containsKey(day.day.toString())) {
              idx = levels['${day.day}']!.toInt();
            }
            return Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: calColors[idx],
              ),
              child: Center(
                child: Text(day.day.toString()),
              ),
            );
          },
        ),
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
              color: Color(0xFF7EC4D9),
              border: Border(left: BorderSide(width: 1, color: Color(0xFF9FC6D2)), top: BorderSide(width: 1, color: Color(0xFF9FC6D2)))
          ),
          outsideDaysVisible: false,
          todayTextStyle:TextStyle(color: Colors.white,),
        ),
        daysOfWeekHeight: 30,
      ),
    );
  }
}
