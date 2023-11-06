import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:provider/provider.dart';

class TodoDetailPage extends StatefulWidget {
  const TodoDetailPage({super.key});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage>{
  static const category = ['집안일', '일 상', '학 습', '건 강', '업 무', '기타'];
  @override
  Widget build(BuildContext context){
    Map<String, String> data = context.watch<ScheduleProvider>().detail;
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
                    child: Text('몬스터 정보'),
                  ),
                  ),
                ),
              ],
            ),

            Image.asset('assets/images/Slime.png', height: 150, width: 150,), // 이미지 경로를 수정하세요.
            Container(
              padding: EdgeInsets.all(15),
              width: 350,
              // height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30), //모서리를 둥글게
                // border: Border.all(color: Colors.black, width: 3), //테두리
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Image.asset('assets/images/pixel_star.png', height: 30, width: 30,),
                            SizedBox(width: 3,),
                            Text(
                                data['title']!,
                                style: TextStyle(fontSize: 25,)),
                          ],
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(10), //모서리를 둥글게
                          // border: Border.all(color: Colors.black, width: 3), //테두리
                        ),
                        child:Center(child:Text(category[int.parse(data['category']!)], style: TextStyle(color: Colors.white)),)
                      ),
                    ],
                  ),
                  (data['place'] == null)? Text(' ') : Text(data['place']!),

                  Container(
                    margin: EdgeInsetsDirectional.only(top: 20),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xffdcdcdc),
                      borderRadius: BorderRadius.circular(10), //모서리를 둥글게
                      // border: Border.all(color: Colors.black, width: 3), //테두리
                    ),
                    child: Text(data['detail']!),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("시작일자"),
                      Text(data['startAt']!),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("종료일자"),
                      Text(data['endAt']!),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsetsDirectional.only(top: 10),
              width: 350,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      print(data);
                      int id = int.parse(data['id']!);
                      if(data['type'] == '2'){
                        Provider.of<ScheduleProvider>(context, listen: false).achieveRoutine(id);
                      }else{
                        Provider.of<ScheduleProvider>(context, listen: false).achieveTodo(id);
                      }
                      Provider.of<ScheduleProvider>(context, listen: false).changeAchieve();
                      print("버튼 클릭");
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(360, 50), // 여기서 원하는 크기로 조절
                      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 14.0),
                      backgroundColor: Color(0xff84CEA0),
                    ),
                    child: data['achievedYn'] == 'true'? Text('수행취소') :  Text('수행하기'),
                  ),
                  SizedBox(width: 20.0, height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: ()=>print("버튼 클릭"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(160, 45), // 여기서 원하는 크기로 조절
                            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                            backgroundColor: Color(0xff9FC6D2),
                          ),
                          child: Text('수정')
                      ),
                      ElevatedButton(
                          onPressed: ()=>print("버튼 클릭"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(160, 45), // 여기서 원하는 크기로 조절
                            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                            backgroundColor: Color(0xff9FC6D2),
                          ),
                          child: Text('삭제')
                      ),
                    ],
                  )
                ],
              ),
            )

          ],
        )
      )
    );
  }
}
