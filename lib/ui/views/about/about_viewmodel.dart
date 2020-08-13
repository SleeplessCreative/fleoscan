import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class AboutViewModel extends BaseViewModel {
  String _title = 'This is title';
  String get title => _title;

  Image _logoFleoScan = Image.asset(
    'assets/airportseclogo2.png',
  );
  Image get logoFleoscan => _logoFleoScan;

  String _aboutText = '''
Version 1.0

Copyright ©
2020 - Sleeplesscreative
                            ''';
  String get aboutText => _aboutText;
}
