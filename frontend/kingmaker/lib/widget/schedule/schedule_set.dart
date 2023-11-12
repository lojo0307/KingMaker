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
  static const category = ['전체', '집안일' ,'일 상', '학 습', '건 강', '업 무', '기 타'];
  static const idxs = ['0', '1' ,'2', '3', '4', '5', '6'];
  String idx = '0';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(top: 5),
          height: 50.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(3),
            children: [
              for (int i = 0; i < 6; i++)
                _buildButton(context, category[i], idxs[i], i),
            ],
          ),


          // child: Row(
          //   children: <Widget>[
          //     Expanded(
          //       child: CustomRadioButton(
          //         elevation: 0,
          //         unSelectedColor: Colors.transparent,
          //         buttonLables: category,
          //         buttonValues: idxs,
          //         selectedBorderColor: const Color(0xFF5792A4),
          //         buttonTextStyle: const ButtonTextStyle(
          //             selectedColor: Colors.white,
          //             unSelectedColor: Colors.black,
          //             textStyle: TextStyle(fontSize: 16)
          //         ),
          //         radioButtonValue: (value) {
          //           idx = value;
          //           setState(() {});
          //         },
          //         defaultSelected: idxs[0],
          //         unSelectedBorderColor: const Color(0xFF5792A4),
          //         horizontal: false,
          //         width: 120,
          //         selectedColor: const Color(0xFF5792A4),
          //         padding: 5,
          //         enableShape: true,
          //       ),
          //     ),
          //   ],
          // ),


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
                }).toList() + [const SizedBox(height: 70,)],

              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildButton(BuildContext context, String label, String value, int imageIndex) {
    bool isSelected = value == idx;
    String imagePath = 'assets/images/category/$imageIndex.png';

    return InkWell(
      onTap: () {
        idx = value;
        setState(() {});
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      splashFactory: InkRipple.splashFactory,
      radius: 20,

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF5792A4) : Colors.transparent,
          border: Border.all(
            color: const Color(0xFF5792A4),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              color: isSelected ? Colors.white : Colors.black,
              width: 24,
              height: 24,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
