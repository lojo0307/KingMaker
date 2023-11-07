import 'package:flutter/material.dart';
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
    return  Scaffold(
        backgroundColor: Color(0xFFEDF1FF),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children:[
                SizedBox(height: 20,),
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
                      child: Center(child:Title(
                        color: Colors.black,
                        child: Text('할 일 등록'),
                      ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: SizedBox(),
                    ),
                    Flexible(
                      flex: 9,
                      fit: FlexFit.loose,
                      child: Container(
                        // color: Colors.red,
                        margin: EdgeInsetsDirectional.only(top: 10),
                        padding: EdgeInsetsDirectional.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        height: 60,
                        child: TextFormField(
                          onChanged: (value) {
                            Provider.of<RegistProvider>(context, listen: false).setTitle(value);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: '제목',
                            labelStyle: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: SizedBox(),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: SizedBox(),
                    ),
                    Flexible(
                      flex: 9,
                      fit: FlexFit.loose,
                      child: Container(
                        // width: 100,
                        // height: 170,
                        // color: Colors.red,
                        padding: EdgeInsetsDirectional.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (value) {
                            Provider.of<RegistProvider>(context, listen: false).setDetail(value);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(13),),
                            labelText: '상세내용',
                            labelStyle: TextStyle(
                              fontSize: 17,
                            ),
                          ),),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: SizedBox(),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('분류',style: TextStyle(
                        fontSize: 15
                    )),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                          ),
                        ),
                        Flexible(
                          flex: 9,
                          fit: FlexFit.loose,
                          child: Divider(
                              color: Colors.black,
                              thickness: 0.3),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                          ),
                        ),
                      ],
                    ),

                    Container(
                      width: 370,
                      height: 80,
                      child: CategoryButton(),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('시작 일자 & 종료 일자',
                        style: TextStyle(
                            fontSize: 15
                        )),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                          ),
                        ),
                        Flexible(
                          flex: 9,
                          fit: FlexFit.loose,
                          child: Divider(
                              color: Colors.black,
                              thickness: 0.3),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: DateInput(type: 'start',),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              child: TimeInput(type: 'start',),
                            ),
                          ],
                        ),
                        Text('  ~  ', style: TextStyle(fontSize: 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: DateInput(type: 'end',),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              child: TimeInput(type: 'end',),
                            ),
                          ],
                        ),
                      ],
                    )

                  ],
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: ImportanceCheck(),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: SizedBox()
                    ),
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 14,
                        child: ElevatedButton(
                            onPressed: () async {
                              int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
                              await Provider.of<RegistProvider>(context, listen: false).RegistTodo(memberId!);
                              DateTime now = DateTime.now();
                              Provider.of<ScheduleProvider>(context, listen: false).getList(now.year, now.month, now.day);
                              Navigator.pop(context);
                            },
                            child: Text('할 일 등록하기')
                        )
                    ),
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: SizedBox()
                    ),

                  ],
                )
              ],
            )
        )
    );
  }
}
