import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayOfWeekButton extends StatefulWidget {
  const DayOfWeekButton({super.key});

  @override
  State<DayOfWeekButton> createState() => _DayOfWeekButtonState();
}

class _DayOfWeekButtonState extends State<DayOfWeekButton> {
  Widget roundedButton({required Widget child, required bool isSelected}) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFA7D790) : Colors.white,
        borderRadius: BorderRadius.circular(13),
        // border: Border.all(color: Color(0xFFA7D790)),
      ),
      child: child,
    );
  }



  List<bool> _selections1 = List.generate(7, (index) => false);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: (int index) {
        setState(() {
          _selections1[index] = !_selections1[index];
        });
      },
      isSelected: _selections1,
      renderBorder: false,
      borderRadius: BorderRadius.all(Radius.circular(13)),
      fillColor: Colors.transparent,
      splashColor: Colors.transparent,
      selectedColor: Colors.black,
      children: <Widget>[
        roundedButton(child: Center(child: Text('일', style: TextStyle(color: Colors.red)),), isSelected: _selections1[0]),
        roundedButton(child: Center(child: Text('월'),), isSelected: _selections1[1]),
        roundedButton(child: Center(child: Text('화'),), isSelected: _selections1[2]),
        roundedButton(child: Center(child: Text('수'),), isSelected: _selections1[3]),
        roundedButton(child: Center(child: Text('목'),), isSelected: _selections1[4]),
        roundedButton(child: Center(child: Text('금'),), isSelected: _selections1[5]),
        roundedButton(child: Center(child: Text('토'),), isSelected: _selections1[6]),
      ],
    );
  }
}

