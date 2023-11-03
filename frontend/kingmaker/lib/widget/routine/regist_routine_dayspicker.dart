import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      children: [
        Text('매 '),
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
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff292A37),
                ),
              ),
            ),
          ),
          width: 38,
          height: 30,
        ),
        Text('일 마다'),
      ],
    );
  }
}
