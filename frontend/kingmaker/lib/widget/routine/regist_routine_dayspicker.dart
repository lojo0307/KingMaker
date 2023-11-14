import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/regist_provider.dart';
import 'package:provider/provider.dart';

class DaysPicker extends StatefulWidget {
  const DaysPicker({super.key});

  @override
  State<DaysPicker> createState() => _DaysPickerState();
}

class _DaysPickerState extends State<DaysPicker> {
  String customInputValue = '직접 입력';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 48.0,),
        Text('  매 '),
        Container(
          child:TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            keyboardType: TextInputType.number,
            onChanged: (value) {
              Provider.of<RegistProvider>(context, listen: false).setValue(value);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: 4.0, horizontal: 8.0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // 일반 상태에서는 테두리 없음
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none, // 비활성화 상태에서도 테두리 없음
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(width: 1), // 포커스 상태에서 두꺼운 테두리
              ),
              filled: true,
              fillColor: WHITE_COLOR,
            ),
          ),
          width: 56,
          height: 30,
        ),
        Text(' 일 마다'),
      ],
    );
  }
}
