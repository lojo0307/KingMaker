import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AlarmCard extends StatelessWidget {
  const AlarmCard({super.key, required this.data, required this.delFlag});
  final Map<String, String> data;
  final delFlag;
  @override
  Widget build(BuildContext context) {
    return
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(data['title'].toString(), style: const TextStyle(fontSize: 25 ),),
              Row(
                children: [
                  Text(data['time'].toString(), style: const TextStyle(fontSize: 15, color: Colors.grey ),),
                  (delFlag)? TextButton( onPressed: () { }, child: Image.asset('assets/icon/delete.png',), ): const SizedBox.shrink()
                ],
              ),
            ],
          ),
          Text(data['message'].toString(), style: const TextStyle(fontSize: 15 ),),
          const SizedBox(height: 15,)
        ],
      ),
    );
  }
}
