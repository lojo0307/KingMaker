import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/calendar_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/widget/calendar/day_list_set.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMain extends StatefulWidget {
  const CalendarMain({super.key});

  @override
  State<CalendarMain> createState() => _CalendarMainState();
}

class _CalendarMainState extends State<CalendarMain> {
  static const calColors = [Colors.white, Color(0xFFFFE9C1),Color(0xFFFEE2AE),Color(0xFFFFD78D),Color(0xFF89B0BC),Color(0xFF6895A3), ];
  static const borColors = [Color(0xFF9FC6D2), Color(0xFFE4CEA0),Color(0xFFE4CEA0),Color(0xFFE9C16E),Color(0xFF6895A3),Color(0xFF3F4A68), ];
  DateTime? _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();
  @override
  void initState() {
    int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    int day = now.day;
    Provider.of<CalendarProvider>(context, listen: false).getData(memberId!, year, month);
    Provider.of<CalendarProvider>(context, listen: false).getList(memberId!, year, month, day);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Map<String, int> levels = context.watch<CalendarProvider>().data;
    dynamic list = context.watch<CalendarProvider>().list;
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
                    int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
                    Provider.of<CalendarProvider>(context, listen: false).getList(memberId!, selectedDay.year, selectedDay.month, selectedDay.day);
                    setState(() {});
                  }
                },
                onPageChanged: (focusedDay) async {
                  int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
                  await Provider.of<CalendarProvider>(context, listen: false).getData(memberId!, focusedDay.year, focusedDay.month);
                  _focusedDay = focusedDay;
                },
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  headerPadding:const EdgeInsets.only(bottom: 10),
                  leftChevronIcon: SvgPicture.asset('assets/icon/ic_pixel_left.svg'),
                  rightChevronIcon: SvgPicture.asset('assets/icon/ic_pixel_right.svg'),
                ),
                calendarBuilders: CalendarBuilders(
                  headerTitleBuilder: (context, day) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${day.year} . ${day.month}", style: TextStyle(fontSize: 16),)
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
                  todayBuilder: (context, day, focusedDay) {
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
                  todayTextStyle:TextStyle(color: Colors.black,),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                    decoration: BoxDecoration(
                      color: Color(0xFF9FC6D2),
                      borderRadius: BorderRadiusDirectional.circular(0),
                    )
                ),
                daysOfWeekHeight: 30,
              ),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.fromLTRB(12, 4, 0, 4),
                color: BLUE_COLOR,
                child: Row(
                  children: [
                    Text('${_selectedDay?.month}월 ${_selectedDay?.day}일 일정', style: TextStyle(fontSize: 16, color: WHITE_COLOR)),
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
