import 'package:flutter/material.dart';
import 'package:kingmaker/widget/common/header.dart';
import 'package:kingmaker/widget/routine/regist_routine_categorybutton.dart';
import 'package:kingmaker/widget/routine/resgist_routine_dateinput.dart';
class RegistRoutine extends StatefulWidget {
  const RegistRoutine({super.key});

  @override
  State<RegistRoutine> createState() => _RegistRoutineState();
}

class _RegistRoutineState extends State<RegistRoutine> {
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
                        icon: const Icon(Icons.navigate_before,),
                        tooltip: '이 전 페이지',
                        onPressed: () {
                          print("click");
                        },
                        iconSize: 30,
                      ),
                    ),
                    Container(
                      height: 44,
                      child: Center(child:Title(
                        color: Colors.black,
                        child: Text('루틴 등록'),
                      ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('제목'),
                    Container(
                      width: 100,
                      height: 30,
                      child: TextFormField(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('상세\n'
                        '정보'),
                    Container(
                      width: 100,
                      height: 30,
                      child: TextFormField(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('분류'),
                    Container(
                      width: 370,
                      height: 80,
                      child: CategoryButton(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('시작 일자'),
                    Container(
                      child: DateInput(),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('시작 일자'),
                    Container(
                      child: DateInput(),
                    )
                  ],
                )

              ],
            )
        )
    );
  }
}
