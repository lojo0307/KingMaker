import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/widget/schedule/schedule_card.dart';
class ScheduleSet extends StatefulWidget {
  const ScheduleSet({super.key, this.type, required this.list});
  final type;
  final List<Map<String, String>> list;

  @override
  State<ScheduleSet> createState() => _ScheduleSetState();
}

class _ScheduleSetState extends State<ScheduleSet> {
  static const category = ['전체', '집안일' ,'일상', '학습', '건강', '업무', '기타'];
  static const idxs = ['0', '1' ,'2', '3', '4', '5', '6'];
  String idx = '0';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 44.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(3),
            children: [
              SizedBox(width: 20,),
              for (int i = 0; i < 7; i++)
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
        SizedBox(height: 8.0,),
        Expanded(
          child:widget.list.isEmpty
              ? Center(
                child: Column(
                    mainAxisSize: MainAxisSize.min, // Column을 내용 크기에 맞게
                    children: [
                      Image.asset(
                          'assets/images/empty.png',
                          width: 40,
                          fit: BoxFit.cover), // 이미지
                      SizedBox(height: 8.0),
                      Text("일정이 없습니다.",style: TextStyle(fontFamily: 'PretendardBold')), // 텍스트
                    ],
                  ),
                )
              : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
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
    String imagePath = 'assets/icon/category/ic_category_$imageIndex.svg';

    return InkWell(
      onTap: () {
        idx = value;
        setState(() {});
      },

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? DARKER_BLUE_COLOR : LIGHT_BLUE_COLOR,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            SvgPicture.asset(imagePath, color: isSelected ? WHITE_COLOR : BLUE_BLACK_COLOR),
            SizedBox(width: 4.0,),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? WHITE_COLOR : BLUE_BLACK_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
