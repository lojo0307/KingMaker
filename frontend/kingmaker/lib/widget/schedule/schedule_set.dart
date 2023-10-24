import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
class ScheduleSet extends StatefulWidget {
  const ScheduleSet({super.key, this.type, required this.list});
  final type;
  final List<Map<String, String>> list;

  @override
  State<ScheduleSet> createState() => _ScheduleSetState();
}

class _ScheduleSetState extends State<ScheduleSet> {
  static const category = ['전체', '건 강' ,'학 습', '일 상', '업 무', '수 정', '집안일'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  CustomRadioButton(
                    elevation: 0,
                    unSelectedColor: Colors.transparent,
                    buttonLables: category,
                    buttonValues: category,
                    buttonTextStyle: const ButtonTextStyle(
                        selectedColor: Colors.black,
                        unSelectedColor: Colors.black,
                        textStyle: TextStyle(fontSize: 16)),
                    radioButtonValue: (value) {
                      print(value);
                    },
                    defaultSelected: category[0],
                    unSelectedBorderColor: const Color(0xFF5792A4),
                    horizontal: false,
                    width: 120,
                    // hight: 50,
                    selectedColor: const Color(0xFF5792A4),
                    padding: 5,
                    enableShape: true,
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
