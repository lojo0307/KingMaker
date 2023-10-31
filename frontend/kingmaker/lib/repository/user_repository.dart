import 'package:kingmaker/api/user_api.dart';

class UserRepository {
  final UserApi _userApi = UserApi();

  bool checkFreshToken() {
    return _userApi.checkToken();
  }
}