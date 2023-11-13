import 'package:flutter/material.dart';
import 'package:kingmaker/dto/kingdom_dto.dart';
import 'package:kingmaker/repository/kingdom_repository.dart';

class KingdomProvider with ChangeNotifier {
  late final KingdomRepository _kingdomRepository;

  KingdomDto? _kingdomDto;
  KingdomDto? get kingdomDto => _kingdomDto;

  String _errorMessage = " ";
  String get errorMessage => _errorMessage;

  String _kingdomName = "";
  String get kingdomName => _kingdomName;

  KingdomProvider() {
    _kingdomRepository = KingdomRepository();
  }
  void setName(String name){
    _kingdomName = name;
    if (name.isEmpty)
      _errorMessage = "왕국 이름을 작성 하셔야 합니다.";
    else
      _errorMessage = " ";
  }

  getKingdom(int memberId) async{
    _kingdomDto = await _kingdomRepository.getKingdom(memberId);
  }
}