import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MonthsPicker extends StatefulWidget {
  const MonthsPicker({super.key});

  @override
  State<MonthsPicker> createState() => _DaysPickerState();
}

class _DaysPickerState extends State<MonthsPicker> {
  String customInputValue = '직접 입력';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Text('매 '),
        Container(
          width: 38,
          height: 30,
          child:TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff292A37),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff292A37),
                )
              )
            ),
          ),
        ),
        Text('개월 마다'),
      ],
    );
  }
}
