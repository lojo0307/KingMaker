import 'package:flutter/material.dart';

class AchievementModalWidget extends StatefulWidget {
  final String title;
  final String content;

  const AchievementModalWidget({
    Key? key,
    required this.title,
    required this.content,
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
              height: dialogHeight, // Use the dialogHeight here
              padding: const EdgeInsets.only(
                top: 60,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              margin: const EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: maxWidth*0.05),
                    DefaultTextStyle(
                      style: const TextStyle(
                        overflow: TextOverflow.clip,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      child: Text(
                        '\"${widget.title}\"',
                      ),
                    ),
                    const DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      child: Text(
                        '획득',
                      ),
                    ),
                    SizedBox(height: maxWidth*0.05),
                    DefaultTextStyle(
                      style: const TextStyle(overflow: TextOverflow.clip,fontSize: 14, color: Colors.black,),
                      child: Text(
                        widget.content,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: maxWidth*0.05),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(double.infinity, 36)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                          ),
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text('확인',style: TextStyle(fontSize: 14),),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              )
            ),
            Positioned(
              top: maxWidth*0.45,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                backgroundImage: AssetImage('assets/achievement/sample.png'),
              ),
            ),
          ],
        );
      },
    );
  }
}
