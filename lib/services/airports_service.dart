import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AirportsService {
  List<dynamic> _aL;
  List<dynamic> get aL => _aL;

  getList() async {
    _aL = json.decode(
        await rootBundle.loadString('assets/json/bandara_indonesia.json'));
  }

  String checkData(String code) {
    for (int i = 0; i < _aL.length; i++) {
      if (_aL[i]['iata'] == code) {
        return (_aL[i]['nama']);
      }
    }
    return '-';
  }
}
