import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/routine/regist_routine_dayofweekbutton.dart';
import 'package:kingmaker/widget/routine/regist_routine_dayspicker.dart';
import 'package:kingmaker/widget/routine/regist_routine_monthspicker.dart';

class WeekDayButton extends StatefulWidget {
  const WeekDayButton({super.key});

  @override
  State<WeekDayButton> createState() => _WeekDayButtonState();
}

class _WeekDayButtonState extends State<WeekDayButton> {
  static const category = ['주 단위', '일 단위', '월 단위'];
  String selectedValue = category.first;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomRadioButton(
          width: 100,
          height: 30,
          buttonLables: category,
          buttonValues: category,

          radioButtonValue: (value) {
            setState(() {
              selectedValue = value;
            });
            print(value);
          },
          unSelectedColor: const Color(0xFFD9D9D9),
          selectedColor: const Color(0xFF5792A4),
          enableButtonWrap: true, // 중요: 버튼 래핑 비활성화
          defaultSelected: selectedValue,
          // ... 기타 속성들
        ),
        //selectedValue의 값이 바뀔 때 마다 다른 라디오 버튼 출력
        //첫번째 값이면 나올 위젯
        if (selectedValue == category.first)
          Container(
            child: DayOfWeekButton(),
            width: 380,
          )
        else if (selectedValue == category.last)
          Container(
            child: MonthsPicker(),
            width: 380,
          )
        else
          Container(
            child: DaysPicker(),
            width: 380,
          )
      ],
    );
  }
}
