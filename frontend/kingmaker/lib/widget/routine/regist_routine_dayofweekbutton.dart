import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/regist_provider.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:provider/provider.dart';

class DayOfWeekButton extends StatefulWidget {
  const DayOfWeekButton({super.key});

  @override
  State<DayOfWeekButton> createState() => _DayOfWeekButtonState();
}

class _DayOfWeekButtonState extends State<DayOfWeekButton> {
  Widget roundedButton({required Widget child, required bool isSelected}) {
    return Container(
        width: MediaQuery.of(context).size.width / 7 - 17,
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 30,
        decoration: BoxDecoration(
          color: isSelected ? BLUE_COLOR : GREY_COLOR,
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: Color(0xFFA7D790)),
        ),
        child: child,
      );
  }
  List<bool> _selections1 = List.generate(7, (index) => false);
  @override
  void initState() {
    Map<String, String> detail = Provider.of<ScheduleProvider>(context, listen: false).detail;
    print(detail['dateType']);
    print(detail['dateValue']);
    if (detail['dateType'] == 'day')
      _selections1 = json.decode(detail['dateValue']!).cast<bool>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
          children: [
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  _selections1[index] = !_selections1[index];
                  Provider.of<RegistProvider>(context, listen: false).setValue(_selections1);
                });
              },
              isSelected: _selections1,
              renderBorder: false,
              borderRadius: BorderRadius.all(Radius.circular(13)),
              fillColor: Colors.transparent,
              splashColor: Colors.transparent,
              selectedColor: Colors.black,

              children: <Widget>[
                roundedButton(child: Center(child: Text('일', style: TextStyle(color: _selections1[0] ? WHITE_COLOR : DARKER_GREY_COLOR)),), isSelected: _selections1[0]),
                roundedButton(child: Center(child: Text('월', style: TextStyle(color: _selections1[1] ? WHITE_COLOR : DARKER_GREY_COLOR)),), isSelected: _selections1[1]),
                roundedButton(child: Center(child: Text('화', style: TextStyle(color: _selections1[2] ? WHITE_COLOR : DARKER_GREY_COLOR)),), isSelected: _selections1[2]),
                roundedButton(child: Center(child: Text('수', style: TextStyle(color: _selections1[3] ? WHITE_COLOR : DARKER_GREY_COLOR)),), isSelected: _selections1[3]),
                roundedButton(child: Center(child: Text('목', style: TextStyle(color: _selections1[4] ? WHITE_COLOR : DARKER_GREY_COLOR)),), isSelected: _selections1[4]),
                roundedButton(child: Center(child: Text('금', style: TextStyle(color: _selections1[5] ? WHITE_COLOR : DARKER_GREY_COLOR)),), isSelected: _selections1[5]),
                roundedButton(child: Center(child: Text('토', style: TextStyle(color: _selections1[6] ? WHITE_COLOR : DARKER_GREY_COLOR)),), isSelected: _selections1[6]),
              ],
            ),
          ],
        )
    );
  }
}

