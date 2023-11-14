class FcmDto{
  int memberId;
  String token;
  FcmDto({
    required this.memberId,
    required this.token,
  });
  toRegistJson() {
    return {
      "memberId" : memberId,
      "token":token,
    };
  }
}