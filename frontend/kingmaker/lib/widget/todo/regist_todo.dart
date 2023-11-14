import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/achievement_provider.dart';
import 'package:kingmaker/provider/calendar_provider.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/provider/regist_provider.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:provider/provider.dart';

import '../routine/regist_routine_categorybutton.dart';
import '../routine/regist_routine_importancecheck.dart';
import '../routine/regist_routine_timeinput.dart';

import '../routine/resgist_routine_dateinput.dart';

class RegistTodo extends StatefulWidget {
  const RegistTodo({super.key});

  @override
  State<RegistTodo> createState() => _RegistTodoState();
}

class _RegistTodoState extends State<RegistTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LIGHTEST_BLUE_COLOR,
        body:SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 12,),
                Stack(
                  children: [
                    Container(
                      height: 40,
                      child: IconButton(
                        icon: Image.asset('assets/icon/left.png'),
                        tooltip: '이 전 페이지',
                        onPressed: () {
                          print("click");
                          Navigator.pop(
                            context,
                          );
                        },
                        iconSize: 30,
                      ),
                    ),
                    Container(
                      height: 44,
                      child: Center(
                        child: Title(
                          color: Colors.black,
                          child: Text(
                            '할 일 등록',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'EsamanruMedium',
                                color: BLUE_BLACK_COLOR,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            Provider.of<RegistProvider>(context, listen: false)
                                .setTitle(value);
                          },
                          decoration: InputDecoration(
                            hintText: '제목',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16.0),
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
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (value) {
                            Provider.of<RegistProvider>(context, listen: false)
                                .setDetail(value);
                          },
                          style: TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 12),

                            hintText: '상세내용',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16.0),
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
                        SizedBox(
                          height: 20,
                        ),
                        ImportanceCheck(),
                        SizedBox(
                          height: 24,
                        ),
                        Text('분류',
                            style: TextStyle(
                                fontSize: 14, color: BLUE_BLACK_COLOR)),
                        Divider(color: DARKER_GREY_COLOR, thickness: 0.3),
                        Container(
                          width: double.infinity,
                          child: CategoryButton(),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('시작 일자   ~   종료 일자',
                                style: TextStyle(
                                    fontSize: 14, color: BLUE_BLACK_COLOR)),
                            Divider(color: DARKER_GREY_COLOR, thickness: 0.3),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: DateInput(
                                        type: 'start',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      child: TimeInput(
                                        type: 'start',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('  ~  ',
                                        style: TextStyle(fontSize: 18)),
                                    Container(
                                      child: DateInput(
                                        type: 'end',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: TimeInput(
                                        type: 'end',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ElevatedButton(
                onPressed: () async {
                  int? memberId =
                      Provider.of<MemberProvider>(context, listen: false)
                          .member
                          ?.memberId;
                  await Provider.of<RegistProvider>(context, listen: false)
                      .RegistTodo(memberId!);
                  DateTime now = DateTime.now();
                  int year = now.year;
                  int month = now.month;
                  int day = now.day;
                  Provider.of<CalendarProvider>(context, listen: false).getMyCal(memberId!, year, month);
                  Provider.of<CalendarProvider>(context, listen: false).getData(memberId!, year, month);
                  Provider.of<CalendarProvider>(context, listen: false).getList(memberId!, year, month, day);
                  Provider.of<ScheduleProvider>(context, listen: false).getList(memberId!, year, month, day);
                  Provider.of<KingdomProvider>(context, listen: false).getKingdom(memberId!);
                  Provider.of<AchievementProvider>(context, listen: false).getAllData(memberId!);
                  Provider.of<ScheduleProvider>(context, listen: false)
                      .getList(memberId, now.year, now.month, now.day);
                  Navigator.pop(context);
                },
                child: Text('할 일 등록하기',
                    style: TextStyle(color: WHITE_COLOR, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    backgroundColor: BLUE_COLOR)
            )
        )
    );
  }
}
