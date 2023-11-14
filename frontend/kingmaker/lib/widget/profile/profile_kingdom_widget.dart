import 'package:flutter/material.dart';
import 'package:kingmaker/dto/kingdom_dto.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:provider/provider.dart';

class ProfileKingdomWidget extends StatefulWidget {
  const ProfileKingdomWidget({super.key});

  @override
  State<ProfileKingdomWidget> createState() => _ProfileKingdomWidgetState();
}

class _ProfileKingdomWidgetState extends State<ProfileKingdomWidget> {
  @override
  Widget build(BuildContext context) {
    int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
    Provider.of<KingdomProvider>(context, listen: false).getKingdom(memberId!);
    KingdomDto? kingdom = context.watch<KingdomProvider>().kingdomDto;
    int citizen = 100;
    int mem = citizen < 0 ? -citizen : citizen;
    return LayoutBuilder(builder: (ctx, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image(image: AssetImage('assets/images/castle/Lv${kingdom?.level}.png',),
                      height: 100,
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth - 190,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(kingdom!.kingdomNm,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Text('왕국 ${kingdom?.level} 단계',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('백성 : ${kingdom?.citizen} 명',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(' (',
                              style: TextStyle(
                                color: citizen > 0 ? Colors.red : citizen == 0 ? Colors.black : Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                            getIcone(citizen),
                            Text('${mem == 0 ? "" : mem} )',
                              style: TextStyle(
                                color: citizen > 0 ? Colors.red : citizen == 0 ? Colors.black : Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )],
      );
    });
  }

  getIcone(int citizen) {
    if (citizen < 0) {
      return const Icon(Icons.arrow_drop_down, color: Colors.blue,);
    } else if (citizen > 0){
      return const Icon(Icons.arrow_drop_up, color: Colors.red,);
    } else{
      return const Text(" -", style: TextStyle(fontWeight: FontWeight.bold),);
    }
  }
}
