import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/widget/routine/regist_routine.dart';
import 'package:kingmaker/widget/todo/regist_todo.dart';

class AddContent extends StatefulWidget {
  const AddContent({super.key});

  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return (flag)
        ? GestureDetector(
            onTap: () {
              flag = false;
              setState(() {});
            },
            child: Scaffold(
              backgroundColor: Colors.black.withOpacity(0.2),
              body: SafeArea(
                child: addPage(),
              ),
            ),
          )
        : addPage();
  }

  Widget addPage() {
    return Column(
      children: [
        const Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              (flag)
                  ? Container(
                      margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          TextButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(WHITE_COLOR),
                            ),
                            onPressed: () {
                              flag = !flag;
                              setState(() {});
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegistTodo()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset('assets/icon/ic_todo_regist.svg'),
                                SizedBox(width: 4.0,),
                                Text(
                                  '할일 등록하기',
                                  style: TextStyle(color: BLUE_BLACK_COLOR, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              (flag)
                  ? Container(
                      margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 1,),
                          TextButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(WHITE_COLOR),
                            ),
                            onPressed: () {
                              flag = !flag;
                              setState(() {});
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegistRoutine()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset('assets/icon/ic_routine.svg'),
                                SizedBox(width: 4,),
                                Text(
                                  '루틴 등록하기',
                                  style: TextStyle(color: BLUE_BLACK_COLOR, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      flag = !flag;
                      setState(() {});
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          color: BLUE_COLOR,
                          borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                              color: BLUE_BLACK_COLOR.withOpacity(0.15), // 그림자 색상
                            spreadRadius: 2, // 퍼짐 정도
                            blurRadius: 8, // 흐림 정도
                            offset: Offset(2, 5), // 그림자의 위치 조정 (가로, 세로)
                          ),
                        ],),
                      child: const Icon(
                        CupertinoIcons.plus,
                        color: WHITE_COLOR,
                        size: 40,
                      ),
                    ),
                  ),
                  SizedBox(width: 4,)
                ],
              ),
              SizedBox(height: 4,)
            ],
          ),
        )
      ],
    );
  }
}
