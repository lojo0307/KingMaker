import 'package:flutter/material.dart';

class ProfileKingdomWidget extends StatefulWidget {
  const ProfileKingdomWidget({super.key});

  @override
  State<ProfileKingdomWidget> createState() => _ProfileKingdomWidgetState();
}

class _ProfileKingdomWidgetState extends State<ProfileKingdomWidget> {
  Map<String, String> kingdom = {
    'kingdomName' : "버섯 왕국",
    'level':"6",
    'citizen' : "2145"
  };
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: constraints.maxWidth - 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  child: Image(image: AssetImage('assets/castle/tower.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth - 190,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(kingdom['kingdomName']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text('왕국 ${kingdom['level']!} 단계',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text('백성 : ${kingdom['citizen']!} 명',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )],
      );
    });
  }
}
