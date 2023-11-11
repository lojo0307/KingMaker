import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
class AlarmCard extends StatelessWidget {
  const AlarmCard({super.key, required this.data, required this.delFlag});
  final Map<String, String> data;
  final delFlag;
  @override
  Widget build(BuildContext context) {
    return
    Container(
      // decoration: BoxDecoration(color: Colors.red),
      margin: EdgeInsets.fromLTRB(24.0,0.0,24.0,24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(data['title'].toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BLUE_BLACK_COLOR),),
              Row(
                children: [
                  Text(data['time'].toString(), style: const TextStyle(fontSize: 16, color: DARK_GREY_COLOR ),),
                  (delFlag)? TextButton( onPressed: () { }, child: Image.asset('assets/icon/delete.png',), ): const SizedBox.shrink()
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(data['message'].toString(), style: const TextStyle(fontSize: 16, color: BLUE_BLACK_COLOR
          ),),
        ],
      ),
    );
  }
}
