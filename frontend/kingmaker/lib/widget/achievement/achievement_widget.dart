import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AchievementWidget extends StatefulWidget {
  const AchievementWidget({super.key, required this.data});
  final Map<String, String> data;
  @override
  State<AchievementWidget> createState() => _AchievementWidgetState();
}

class _AchievementWidgetState extends State<AchievementWidget> {
  @override
  Widget build(BuildContext context) {
    print('${widget.data['reward_nm']}');
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        // color: Colors.red,
        border: Border.all(width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          const Flexible(
              child: Image(
                image: AssetImage('assets/achievement/sample.png'),
                height: 100,
                width: 100,
              )
          ),
          Flexible(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.data['reward_nm']}', style: TextStyle(fontSize: 20)),
                    Text('${widget.data['reward_cont']}')
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
