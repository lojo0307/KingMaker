import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'dart:math';
final dio = Dio();
String? url = dotenv.env['URL'];

class UserApi{
  bool checkToken() {
    bool res = true;
    int number = Random().nextInt(100);
    if (number < 50)
      res = true;
    else
      res = false;
    return res;
  }
}

