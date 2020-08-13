import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class AboutViewModel extends BaseViewModel {
  String _title = 'This is title';
  String get title => _title;

  Image _logoFleoscan = Image.asset(
    'assets/logo_fleo.png',
    width: 169,
  );
  Image get logoFleoscan => _logoFleoscan;

  String _aboutText = '''
Version 1.0

Copyright (c) 
2020 - Sleeplesscreative
                            ''';
  String get aboutText => _aboutText;
}
