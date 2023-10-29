import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ProfileCalendarWidget extends StatefulWidget {
  const ProfileCalendarWidget({super.key});

  @override
  State<ProfileCalendarWidget> createState() => _ProfileCalendarWidgetState();
}

class _ProfileCalendarWidgetState extends State<ProfileCalendarWidget> {
  static const calColors = [Colors.white, Color(0xFFFFF0CF),Color(0xFFFEE1CF),Color(0xFFFED0D0),Color(0xFFFFBFCF),Color(0xFFFEADDE), Color(0xFFFEADCE),];
  static const Map<String, int> levels = {'9' : 1, '10' : 2, '11' : 3, '12' : 4, '13' : 5, '1': 6};
  DateTime? _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(13),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          headerPadding:EdgeInsets.only(bottom: 10),
          // leftChevronIcon: const Icon(CupertinoIcons.square_list),
          // rightChevronIcon: const Icon(CupertinoIcons.square_list),
        ),
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, day) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${day.year}년 ${day.month}월", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
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
          // selectedBuilder: (context, day, focusedDay) {
          //   int idx = 0;
          //   if (levels.containsKey(day.day.toString())) {
          //     idx = levels['${day.day}']!.toInt();
          //   }
          //   return Container(
          //     margin: EdgeInsets.all(5),
          //     decoration: BoxDecoration(
          //       color: calColors[idx],
          //       border: Border(top: BorderSide(color: borColors[idx], width: 2), left: BorderSide(color: borColors[idx], width: 2)),
          //     ),
          //     child: Center(
          //       child: Text(day.day.toString(), style: TextStyle(color: borColors[0])),
          //     ),
          //   );
          // },
          // outsideBuilder: (context, day, focusedDay) {
          //   return Container(
          //     margin: EdgeInsets.all(5),
          //     decoration: BoxDecoration(
          //       color: calColors[0],
          //       border: Border(top: BorderSide(color: borColors[0], width: 2), left: BorderSide(color: borColors[0], width: 2)),
          //     ),
          //     child: Center(
          //       child: Text(day.day.toString(), style: TextStyle(color: Colors.grey)),
          //     ),
          //   );
          // },

        ),
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
              color: Color(0xFF7EC4D9),
              border: Border(left: BorderSide(width: 1, color: Color(0xFF9FC6D2)), top: BorderSide(width: 1, color: Color(0xFF9FC6D2)))
          ),
          todayTextStyle:TextStyle(color: Colors.white,),
        ),
        daysOfWeekHeight: 30,
      ),
    );
  }
}
