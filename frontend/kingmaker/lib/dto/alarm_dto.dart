class AlarmDto{
  int notificationTypeId;
  String message;
  int notificationId;
  String sendtime;
  int type;

  AlarmDto({
    required this.notificationTypeId,
    required this.message,
    required this.notificationId,
    required this.sendtime,
    required this.type,
  });
  factory AlarmDto.fromJson(Map<String, dynamic> json) {
    return AlarmDto(
      notificationTypeId: json['notificationTypeId'] ?? 0,
      message: json['message'] ?? "",
      notificationId: json['notificationId'] ?? 0,
      sendtime: json['sendtime'] ?? "",
      type: json['type'] ?? 1,
    );
  }
}