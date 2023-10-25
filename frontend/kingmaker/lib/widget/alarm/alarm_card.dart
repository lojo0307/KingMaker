import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AlarmCard extends StatelessWidget {
  const AlarmCard({super.key, required this.data, required this.delFlag});
  final Map<String, String> data;
  final delFlag;
  @override
  Widget build(BuildContext context) {
    return
    SizedBox(
      width: 300,
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
                  (delFlag)? TextButton( onPressed: () { }, child: const Icon(CupertinoIcons.delete), ): const SizedBox.shrink()
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
