import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/regist_provider.dart';
import 'package:provider/provider.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton({super.key});

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  static const category = ['집안일', '일 상', '학 습', '건 강', '업 무', '기타'];
  static const categoryId = [1, 2, 3, 4, 5, 6];
  int selectedValue = categoryId.first; // '전체'로 초기값 설정
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        CustomRadioButton(
          unSelectedBorderColor: LIGHTEST_BLUE_COLOR,
          selectedBorderColor: LIGHTEST_BLUE_COLOR,
          elevation: 0,
          width: 80,
          // height: 30,
          buttonLables: category,
          buttonValues: categoryId,
          radioButtonValue: (value) {
            Provider.of<RegistProvider>(context, listen: false).setCategoryId(value);
            setState(() {
              selectedValue = value;
            });
          },
          unSelectedColor: GREY_COLOR,
          selectedColor: BLUE_COLOR,
          buttonTextStyle: ButtonTextStyle(selectedColor: WHITE_COLOR, unSelectedColor: DARKER_GREY_COLOR),
          enableButtonWrap: true, // 중요: 버튼 래핑 비활성화
          defaultSelected: selectedValue,
          // ... 기타 속성들
        ),

      ],
    );
  }
}
