import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMain extends StatefulWidget {
  const CalendarMain({super.key});

  @override
  State<CalendarMain> createState() => _CalendarMainState();
}

class _CalendarMainState extends State<CalendarMain> {
  DateTime? _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            late String dayStr;
            switch(day.weekday){
              case 1: dayStr = 'Mon'; break;
              case 2: dayStr = 'Tue'; break;
              case 3: dayStr = 'Wed'; break;
              case 4: dayStr = 'Thu'; break;
              case 5: dayStr = 'Fri'; break;
              case 6: dayStr = 'Sat'; break;
              case 7: dayStr = 'Sun'; break;
            }
            return Center(
              child: Text(
                '$dayStr', style: TextStyle().copyWith(
                color: dayStr == 'Sun' ? Colors.red : dayStr == 'Sat' ? Colors.blue : Colors.black,
              ),
              ),
            );
          },
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          decoration: BoxDecoration(
            color: Color(0xFF9FC6D2),
            borderRadius: BorderRadiusDirectional.circular(13),
          )
        ),
        daysOfWeekHeight: 30,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
          });
        },
      )
    );
  }
}
