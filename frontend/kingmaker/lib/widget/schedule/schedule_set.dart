import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/schedule/schedule_card.dart';
class ScheduleSet extends StatefulWidget {
  const ScheduleSet({super.key, this.type, required this.list});
  final type;
  final List<Map<String, String>> list;

  @override
  State<ScheduleSet> createState() => _ScheduleSetState();
}

class _ScheduleSetState extends State<ScheduleSet> {
  static const category = ['전체', '건 강' ,'학 습', '일 상', '업 무', '수 정', '집안일', '기 타'];
  static const idxs = ['0', '1' ,'2', '3', '4', '5', '6', '7'];
  String idx = '0';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: CustomRadioButton(
                  elevation: 0,
                  unSelectedColor: Colors.transparent,
                  buttonLables: category,
                  buttonValues: idxs,
                  selectedBorderColor: const Color(0xFF5792A4),
                  buttonTextStyle: const ButtonTextStyle(
                      selectedColor: Colors.black,
                      unSelectedColor: Colors.black,
                      textStyle: TextStyle(fontSize: 16)
                  ),
                  radioButtonValue: (value) {
                    idx = value;
                    setState(() {});
                  },
                  defaultSelected: idxs[0],
                  unSelectedBorderColor: const Color(0xFF5792A4),
                  horizontal: false,
                  width: 120,
                  selectedColor: const Color(0xFF5792A4),
                  padding: 5,
                  enableShape: true,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children:
                widget.list.map ((Map<String, String> res){
                  if (widget.type == '0' || widget.type == res['type']) {
                    if (idx == '0' || idx == res['category']) {
                      return ScheduleCard(data: res,);
                    } else {
                      return const SizedBox.shrink();
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                }).toList(),

              ),
            ),
          ),
        ),
      ],
    );
  }
}
