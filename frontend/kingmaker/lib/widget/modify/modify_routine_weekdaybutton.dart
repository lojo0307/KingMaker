import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/regist_provider.dart';
import 'package:kingmaker/widget/routine/regist_routine_dayofweekbutton.dart';
import 'package:kingmaker/widget/routine/regist_routine_dayspicker.dart';
import 'package:kingmaker/widget/routine/regist_routine_monthspicker.dart';
import 'package:provider/provider.dart';

class ModifyWeekDayButton extends StatefulWidget {
  const ModifyWeekDayButton({super.key});

  @override
  State<ModifyWeekDayButton> createState() => _ModifyWeekDayButtonState();
}

class _ModifyWeekDayButtonState extends State<ModifyWeekDayButton> {
  static const category = ['주 단위', '일 단위', '월 단위'];
  String selectedValue = category.first;
  @override
  void initState() {
    String? type = Provider.of<RegistProvider>(context, listen: false).type;
    if (type == 'day')
      selectedValue = category.first;
    else if (type == 'num')
      selectedValue = '일 단위';
    else
      selectedValue = category.last;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomRadioButton(
          width: MediaQuery.of(context).size.width / 3 - 24,
          padding: 1,
          height: 36,
          buttonLables: category,
          buttonValues: category,
          radioButtonValue: (value) {
            Provider.of<RegistProvider>(context, listen: false).setValue(0);
            setState(() {
              selectedValue = value;
              Provider.of<RegistProvider>(context, listen: false).setType(value);
            });
          },
          elevation: 0,
          unSelectedColor: GREY_COLOR,
          selectedColor: BLUE_COLOR,
          buttonTextStyle: ButtonTextStyle(selectedColor: WHITE_COLOR, unSelectedColor: DARKER_GREY_COLOR),
          unSelectedBorderColor: LIGHTEST_BLUE_COLOR,
          selectedBorderColor: LIGHTEST_BLUE_COLOR,
          enableButtonWrap: true, // 중요: 버튼 래핑 비활성화
          defaultSelected: selectedValue,

        ),
        //selectedValue의 값이 바뀔 때 마다 다른 라디오 버튼 출력
        //첫번째 값이면 나올 위젯
        // SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedValue == category.first)
              Container(
                child: DayOfWeekButton(),
                // width: 380,
              )
            else if (selectedValue == category.last)
              Expanded(
                child: MonthsPicker(),
                // width: 380,
              )
            else
              Expanded(
                // width: double.infinity,
                child: DaysPicker(),
                // width: 380,
              )
          ],
        )

      ],
    );
  }
}
