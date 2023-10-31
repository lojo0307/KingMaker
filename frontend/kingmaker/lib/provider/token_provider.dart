import 'package:flutter/material.dart';
import 'package:kingmaker/repository/user_repository.dart';

class TokenProvider with ChangeNotifier {
  late final UserRepository _userRepository;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  TokenProvider() {
    _userRepository = UserRepository();
    checkToken();
  }
  void checkToken() async {
    _isLoggedIn = (await _userRepository.checkFreshToken()) as bool;
  }
}