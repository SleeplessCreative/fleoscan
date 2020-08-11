import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AirlinesService {
  List<dynamic> _aL;
  List<dynamic> get aL => _aL;

  getList() async {
    _aL = json.decode(
        await rootBundle.loadString('assets/json/maskapai_indonesia.json'));
  }

  String checkData(String code) {
    for (int i = 0; i < _aL.length; i++) {
      if (_aL[i]['kode'] == code) {
        return (_aL[i]['nama']);
      }
    }
    return '-';
  }
}
