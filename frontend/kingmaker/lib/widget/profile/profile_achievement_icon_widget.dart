import 'package:flutter/cupertino.dart';

class ProfileAchievementIconWidget extends StatefulWidget {
  const ProfileAchievementIconWidget({super.key, required this.data});
  final Map<String, String> data;
  @override
  State<ProfileAchievementIconWidget> createState() => _ProfileAchievementIconWidgetState();
}

class _ProfileAchievementIconWidgetState extends State<ProfileAchievementIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage('assets/achievement/${widget.data['award_img']}.png'), width: 50,height: 50,),
        Text('${widget.data['award_nm']}',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12, // 조정 가능한 폰트 크기
          ),
          maxLines: 1,
        )
      ],
    );
  }
}
