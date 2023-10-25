import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/main/main_game.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
<<<<<<< 8d4b2c4c3006cab2ee31141ee60e002cdd11d41a
    return Align(
      alignment: Alignment.center,
      child: GameWidget.controlled(
        gameFactory:()=> MyGame(context),
      ),
=======
    return Container(
      color: Colors.green,
>>>>>>> 40867789c7f58a27f67b6a90410d0926b4957083
    );
  }
}

