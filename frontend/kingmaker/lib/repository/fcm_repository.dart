import 'package:kingmaker/api/fcm_api.dart';

class FcmRepository{
  final FcmApi _fcmApi=FcmApi();

  void registFcmToken(int memberId){
    _fcmApi.registFcmToken(memberId);
    return;
  }

  void deleteFcmTokenFromDB(){
    _fcmApi.deleteFcmTokenFromDB();
    return;
  }

  void deleteDevicecFcmToken(){
    _fcmApi.deleteDeviceFcmToken();
    return;
  }

  void initializeNotification(){
    _fcmApi.initializeNotification();
    return;
  }
}