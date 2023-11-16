import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/regist_provider.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

class TimeInput extends StatefulWidget {
  const TimeInput({super.key, required this.type});
  final String type;
  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  DateTime dateTimeSelected = DateTime.now();
  String getHourString(int hour) {
    if (hour < 12) {
      return '오전  $hour';
    } else if (hour == 12) {
      return '오후  12';
    } else {
      return '오후  ${hour - 12}';
    }
  }

  void _openTimePickerSheet(BuildContext context) async {
    final result = await TimePicker.show<DateTime?>(
      context: context,
      sheet: TimePickerSheet(
        sheetTitle: (widget.type == 'start') ? '시작 시간을 선택해 주세요' : '종료 시간을 선택해 주세요',
        minuteTitle: '분',
        hourTitle: '시간',
        saveButtonText: '선택',
        saveButtonColor: BLUE_COLOR,
        sheetCloseIconColor: DARK_GREY_COLOR,
        hourTitleStyle: TextStyle(color: Colors.black),
        minuteTitleStyle: TextStyle(color: Colors.black),
        wheelNumberItemStyle: TextStyle(color:GREY_COLOR),
        wheelNumberSelectedStyle: TextStyle(color: Colors.black),
        initialDateTime: dateTimeSelected,
        minuteInterval: 1,
      ),
    );

    if (result != null) {
      String hour = (result.hour < 10)? '0${result.hour}' : '${result.hour}';
      String minute = (result.minute < 10)? '0${result.minute}' : '${result.minute}';
      if (widget.type == 'start'){
        Provider.of<RegistProvider>(context, listen: false).setStartTime('$hour:$minute');
      } else {
        Provider.of<RegistProvider>(context, listen: false).setEndTime('$hour:$minute');
      }
      setState(() {
        dateTimeSelected = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: WHITE_COLOR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),

              ),
              onPressed: () => _openTimePickerSheet(context),
              child: Text('${getHourString(dateTimeSelected.hour)}시 ${dateTimeSelected.minute}분', style: TextStyle(color: BLUE_BLACK_COLOR, fontSize: 12),),
            ),
          ],
        );
  }
}

