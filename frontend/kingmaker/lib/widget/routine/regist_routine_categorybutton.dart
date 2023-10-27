import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/cupertino.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton({super.key});

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  static const category = ['전체', '건 강', '학 습', '일 상', '업 무', '수 정', '집안일'];
  String selectedValue = category.first; // '전체'로 초기값 설정


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        CustomRadioButton(
          unSelectedBorderColor: Color(0x0000000),
          selectedBorderColor: Color(0x0000000),
          elevation: 0,
          width: 80,
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

      ],
    );
  }
}
