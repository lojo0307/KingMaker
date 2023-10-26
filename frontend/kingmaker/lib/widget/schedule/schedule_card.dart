import 'package:flutter/material.dart';
import 'package:kingmaker/page/todo_detail_page.dart';
import 'package:kingmaker/widget/schedule/schedule_info.dart';
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
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TodoDetailPage())
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          // color: (widget.data['achieved'] == '0') ? Colors.white : Colors.grey,
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
              child: (widget.data['achieved'] == '0') ?
              ElevatedButton (
                onPressed: () {},
                child: Text('수행', style: TextStyle(color: Colors.black)),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0XFFFEE2AE)),
                ),
              )
                  : ElevatedButton (onPressed: () {},
                child: Text('완료', style: TextStyle(color: Colors.black)),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0XFFC7F4B3))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
