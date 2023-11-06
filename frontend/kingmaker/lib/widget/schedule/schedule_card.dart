import 'package:flutter/material.dart';
import 'package:kingmaker/page/todo_detail_page.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:kingmaker/widget/schedule/schedule_info.dart';
import 'package:provider/provider.dart';
class ScheduleCard extends StatefulWidget {
  const ScheduleCard({super.key, required this.data});
  final Map<String, String> data;
  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Provider.of<ScheduleProvider>(context, listen: false).getDetail(int.parse(widget.data['id']!), widget.data['type']!);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TodoDetailPage())
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(right: BorderSide(width: 1, color: Colors.black)),
                ),
                height: 100,
                width: 100,
                child: const Image(
                  image: AssetImage('assets/images/Slime.png'),
                ),
              ),
            ),
            ScheduleInfo(data: widget.data,),
            Container(
              margin: EdgeInsets.only(right: 15),
              child: ElevatedButton (
                onPressed: () {
                  if(widget.data['type'] == '2'){
                    Provider.of<ScheduleProvider>(context, listen: false).achieveRoutine(int.parse(widget.data['id']!));
                  }else{
                    Provider.of<ScheduleProvider>(context, listen: false).achieveTodo(int.parse(widget.data['id']!));
                  }
                },
                child: (widget.data['achieved'] == '0') ? Text('수행', style: TextStyle(color: Colors.black)) : Text('완료', style: TextStyle(color: Colors.black)),
                style: (widget.data['achieved'] == '0') ? ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0XFFFEE2AE)),) : ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0XFFC7F4B3))),
              )
            ),
          ],
        ),
      ),
    );
  }
}
