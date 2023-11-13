import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/provider/regist_provider.dart';
import 'package:kingmaker/provider/schedule_provider.dart';

import 'package:kingmaker/widget/routine/regist_routine_categorybutton.dart';
import 'package:kingmaker/widget/routine/regist_routine_importancecheck.dart';

import 'package:kingmaker/widget/routine/regist_routine_weekdaybutton.dart';
import 'package:kingmaker/widget/routine/resgist_routine_dateinput.dart';
import 'package:provider/provider.dart';

class RegistRoutine extends StatefulWidget {
  const RegistRoutine({super.key});

  @override
  State<RegistRoutine> createState() => _RegistRoutineState();
}

class _RegistRoutineState extends State<RegistRoutine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LIGHTEST_BLUE_COLOR,
        body: SafeArea(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
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
                              '루틴 등록',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: BLUE_BLACK_COLOR,
                                  fontWeight: FontWeight.w500),
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
                          onChanged: (value) {
                            Provider.of<RegistProvider>(context, listen: false)
                                .setDetail(value);
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
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
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('분류',
                                style: TextStyle(
                                    fontSize: 16, color: BLUE_BLACK_COLOR)),
                            Divider(color: DARKER_GREY_COLOR, thickness: 0.3),
                            Container(
                              width: double.infinity,
                              child: CategoryButton(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text('시작 일자 ~ 종료 일자', style: TextStyle(fontSize: 15)),
                        Divider(color: DARKER_GREY_COLOR, thickness: 0.3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DateInput(
                              type: 'start',
                            ),
                            Text('  ~  ', style: TextStyle(fontSize: 18)),
                            DateInput(
                              type: 'end',
                            ),
                            // Container(
                            //   child: TimeInput(),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text('주기', style: TextStyle(fontSize: 15)),
                        Divider(color: DARK_GREY_COLOR, thickness: 0.3),
                        WeekDayButton(),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  )

                  // Column(
                  //   // mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text('분류', style: TextStyle(fontSize: 15)),
                  //     Row(
                  //       children: [
                  //         Flexible(
                  //           flex: 1,
                  //           fit: FlexFit.loose,
                  //           child: Container(),
                  //         ),
                  //         Flexible(
                  //           flex: 9,
                  //           fit: FlexFit.loose,
                  //           child: Divider(color: Colors.black, thickness: 0.3),
                  //         ),
                  //         Flexible(
                  //           flex: 1,
                  //           fit: FlexFit.loose,
                  //           child: Container(),
                  //         ),
                  //       ],
                  //     ),
                  //     Container(
                  //       width: 370,
                  //       height: 80,
                  //       child: CategoryButton(),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text('시작 일자 & 종료 일자', style: TextStyle(fontSize: 15)),
                  //     Row(
                  //       children: [
                  //         Flexible(
                  //           flex: 1,
                  //           fit: FlexFit.loose,
                  //           child: Container(),
                  //         ),
                  //         Flexible(
                  //           flex: 9,
                  //           fit: FlexFit.loose,
                  //           child: Divider(color: Colors.black, thickness: 0.3),
                  //         ),
                  //         Flexible(
                  //           flex: 1,
                  //           fit: FlexFit.loose,
                  //           child: Container(),
                  //         ),
                  //       ],
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Container(
                  //           child: DateInput(
                  //             type: 'start',
                  //           ),
                  //         ),
                  //         Text('  ~  ', style: TextStyle(fontSize: 18)),
                  //         Container(
                  //           child: DateInput(
                  //             type: 'end',
                  //           ),
                  //         ),
                  //         // Container(
                  //         //   child: TimeInput(),
                  //         // ),
                  //       ],
                  //     )
                  //   ],
                  // ),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text('주기', style: TextStyle(fontSize: 15)),
                  //     Row(
                  //       children: [
                  //         Flexible(
                  //           flex: 1,
                  //           fit: FlexFit.loose,
                  //           child: Container(),
                  //         ),
                  //         Flexible(
                  //           flex: 9,
                  //           fit: FlexFit.loose,
                  //           child: Divider(color: Colors.black, thickness: 0.3),
                  //         ),
                  //         Flexible(
                  //           flex: 1,
                  //           fit: FlexFit.loose,
                  //           child: Container(),
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         Container(
                  //           child: WeekDayButton(),
                  //         ),
                  //       ],
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       child: ImportanceCheck(),
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Flexible(fit: FlexFit.tight, flex: 1, child: SizedBox()),
                  //     Flexible(
                  //         fit: FlexFit.tight,
                  //         flex: 14,
                  //         child: ),
                  //     Flexible(fit: FlexFit.tight, flex: 1, child: SizedBox()),
                  //   ],
                  // )
                ],
              )),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
          child: ElevatedButton(
              onPressed: () async {
                print('click');
                int? MemberId =
                    Provider.of<MemberProvider>(context, listen: false)
                        .member
                        ?.memberId;
                await Provider.of<RegistProvider>(context, listen: false)
                    .RegistRoutine(MemberId!);
                DateTime now = DateTime.now();
                Provider.of<ScheduleProvider>(context, listen: false)
                    .getList(MemberId, now.year, now.month, now.day);
                Navigator.pop(context);
              },
              child: Text('루틴 등록하기',
                  style: TextStyle(color: WHITE_COLOR, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: BLUE_COLOR)),
        ),
      );
  }
}
