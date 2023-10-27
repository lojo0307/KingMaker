import 'package:flutter/material.dart';
import 'package:kingmaker/widget/calendar/day_list_set.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMain extends StatefulWidget {
  const CalendarMain({super.key});

  @override
  State<CalendarMain> createState() => _CalendarMainState();
}

class _CalendarMainState extends State<CalendarMain> {
  static const List<Map<String, String>> list =[
    // {'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '1'},{'title' : '15'}
    {
      'title' : 'title11',
      'achieve' : '0',
    },
    {'title' : 'title12',
      'achieve' : '1',},
    {'title' : 'title13',
      'achieve' : '0',},
    {'title' : 'title14',
      'achieve' : '1',},
    {'title' : 'title15',
      'achieve' : '1',},
    {'title' : 'title16',
      'achieve' : '0',},
  ];
  static const calColors = [Colors.white, Color(0xFFFFE9C1),Color(0xFFFEE2AE),Color(0xFFFFD78D),Color(0xFF89B0BC),Color(0xFF6895A3), ];
  static const borColors = [Color(0xFF9FC6D2), Color(0xFFE4CEA0),Color(0xFFE4CEA0),Color(0xFFE9C16E),Color(0xFF6895A3),Color(0xFF3F4A68), ];
  static const Map<String, int> levels = {'9' : 1, '10' : 2, '11' : 3, '12' : 4, '13' : 5, '1': 1};
  DateTime? _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    _selectedDay = selectedDay;
                    if ((_focusedDay.month)%12 == (selectedDay.month + 11)%12) {
                      _focusedDay = DateTime(selectedDay.year,selectedDay.month,1);
                    } else if ((_focusedDay.month) % 12 == (selectedDay.month + 1) % 12) {
                      _focusedDay = DateTime(selectedDay.year,selectedDay.month,1);
                    } else {
                      _focusedDay = focusedDay;
                    }
                    setState(() {});
                  }
                },
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
                        Text("${day.year} . ${day.month}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                      ],
                    );
                  },
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
                        dayStr, style: TextStyle().copyWith(
                        color: dayStr == 'Sun' ? Colors.red : dayStr == 'Sat' ? Colors.blue : Colors.white,
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
                        border: Border(top: BorderSide(color: borColors[idx], width: 2), left: BorderSide(color: borColors[idx], width: 2)),
                      ),
                      child: Center(
                        child: Text(day.day.toString()),
                      ),
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    int idx = 0;
                    if (levels.containsKey(day.day.toString())) {
                      idx = levels['${day.day}']!.toInt();
                    }
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: calColors[idx],
                        border: Border(top: BorderSide(color: borColors[idx], width: 2), left: BorderSide(color: borColors[idx], width: 2)),
                      ),
                      child: Center(
                        child: Text(day.day.toString(), style: TextStyle(color: borColors[0])),
                      ),
                    );
                  },
                  outsideBuilder: (context, day, focusedDay) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: calColors[0],
                        border: Border(top: BorderSide(color: borColors[0], width: 2), left: BorderSide(color: borColors[0], width: 2)),
                      ),
                      child: Center(
                        child: Text(day.day.toString(), style: TextStyle(color: Colors.grey)),
                      ),
                    );
                  },

                ),
                calendarStyle: const CalendarStyle(
                  defaultDecoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(left: BorderSide(width: 1, color: Color(0xFF9FC6D2)), top: BorderSide(width: 1, color: Color(0xFF9FC6D2)))
                  ),
                  weekendDecoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(left: BorderSide(width: 1, color: Color(0xFF9FC6D2)), top: BorderSide(width: 1, color: Color(0xFF9FC6D2)))
                  ),
                  outsideDecoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(left: BorderSide(width: 1, color: Color(0xFF9FC6D2)), top: BorderSide(width: 1, color: Color(0xFF9FC6D2)))
                  ),
                  selectedTextStyle: TextStyle(color: Color(0xFF9FC6D2),),
                  selectedDecoration: BoxDecoration(),
                  todayDecoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(left: BorderSide(width: 1, color: Color(0xFF9FC6D2)), top: BorderSide(width: 1, color: Color(0xFF9FC6D2)))
                  ),
                  todayTextStyle:TextStyle(color: Colors.black,),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                    decoration: BoxDecoration(
                      color: Color(0xFF9FC6D2),
                      borderRadius: BorderRadiusDirectional.circular(13),
                    )
                ),
                daysOfWeekHeight: 30,
              ),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.only(left: 10),
                color: Color(0xFF9FC6D2),
                child: Row(
                  children: [
                    Text('${_selectedDay?.month}월 ${_selectedDay?.day}일 일정', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child : DayListSet(list: list),
              ),
            ],
          ),
        ),
    );
  }
}
