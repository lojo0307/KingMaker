import 'package:flutter/cupertino.dart';
import 'package:kingmaker/dto/reward_dto.dart';

class ProfileAchievementIconWidget extends StatefulWidget {
  const ProfileAchievementIconWidget({super.key, required this.data});
  final RewardDto data;
  @override
  State<ProfileAchievementIconWidget> createState() => _ProfileAchievementIconWidgetState();
}

class _ProfileAchievementIconWidgetState extends State<ProfileAchievementIconWidget> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 4 - 36;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Image(
            width: size,
            height: size,
            image: AssetImage('assets/achievement/${widget.data.rewardId}.png'),
            fit: BoxFit.cover,
          ),
        ),
        // Text('${widget.data.rewardNm}',
        //   overflow: TextOverflow.ellipsis,
        //   style: TextStyle(
        //     fontSize: 12, // 조정 가능한 폰트 크기
        //   ),
        //   maxLines: 1,
        // )
      ],
    );
  }
}
