import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/dto/reward_dto.dart';

class AchievementModalWidget extends StatefulWidget {
  final RewardDto dto;

  const AchievementModalWidget({
    Key? key,
    required this.dto,
  }) : super(key: key);

  @override
  State<AchievementModalWidget> createState() => _AchievementModalWidgetState();
}

class _AchievementModalWidgetState extends State<AchievementModalWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Get the maximum width and height available from the parent constraints
        double maxWidth = constraints.maxWidth;
        double maxHeight = constraints.maxHeight;
        // You can adjust the width and height according to your requirement
        double dialogWidth = maxWidth * 0.8; // taking 80% of the screen width
        double dialogHeight = maxHeight * 0.4; // taking 50% of the screen height

        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: dialogWidth,
              height: 400, // Use the dialogHeight here
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 90,
                      backgroundImage: AssetImage('assets/achievement/${widget.dto.rewardId}.png'),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: maxHeight*0.04,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                          overflow: TextOverflow.clip,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: 'PretendardBold'
                      ),
                      child: Text(
                        '\"${widget.dto.rewardNm}\"',
                      ),
                    ),
                  ),
                  const DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    child: Text(
                      '획득', style: TextStyle(fontFamily: 'PretendardBold'),
                    ),
                  ),
                  SizedBox(height: 5),
                  DefaultTextStyle(
                    style: const TextStyle(overflow: TextOverflow.clip,fontSize: 14, color: Colors.black,),
                    child: Text(
                      widget.dto.rewardMsg,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'PretendardBold', color: DARKER_GREY_COLOR),
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(double.infinity, 36)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return LIGHTEST_BLUE_COLOR;
                            return Colors.transparent;
                          },
                        ),
                      ),
                      child: Text('확인',style: TextStyle(fontSize: 14, color: DARKER_BLUE_COLOR),),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),

          ],
        );
      },
    );
  }
}
