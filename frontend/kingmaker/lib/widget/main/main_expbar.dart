import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:kingmaker/dto/kingdom_dto.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ExpBar extends StatelessWidget {
  const ExpBar({super.key});

  @override
  Widget build(BuildContext context) {
    final kingdomDto = context.watch<KingdomProvider>().kingdomDto;
    final int leftMonster = context.watch<ScheduleProvider>().leftMonster;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Container(
        margin: EdgeInsetsDirectional.only(top: 13),
        decoration: _boxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              _expIcon(),
              SizedBox(width: 7),
              _expBar(kingdomDto, context),
              SizedBox(width: 7),
              _monsterIcon(),
              _monsterCount(leftMonster),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 3),
        ),
      ],
    );
  }

  Widget _expIcon() {
    return Image.asset('assets/images/expbar/expicon.png', width: 27, height: 27);
  }

  Widget _expBar(KingdomDto? kingdomDto, BuildContext context) {
    final double percent = (kingdomDto?.citizen ?? 0) / 8000;
    return Expanded(
      child: LinearPercentIndicator(
        animation: true,
        lineHeight: 30.0,
        percent: percent > 1.0 ? 1.0 : percent,
        center: Text("${kingdomDto?.citizen ?? 0}명"),
        progressColor: Colors.green,
        barRadius: const Radius.circular(10),
      ),
    );
  }

  Widget _monsterIcon() {
    return Image.asset('assets/images/expbar/monstericon.png', width: 33, height: 33);
  }

  Widget _monsterCount(int leftMonster) {
    return Text('X $leftMonster', style: TextStyle(fontSize: 15));
  }
}
