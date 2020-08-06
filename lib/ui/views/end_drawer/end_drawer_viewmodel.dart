import 'package:fleoscan/app/locator.dart';
import 'package:fleoscan/app/router.gr.dart';
import 'package:fleoscan/items/fleocolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EndDrawerViewModel extends BaseViewModel {
  Image _endDrawerHeaderImage = Image.asset('assets/logo-ap2.png');
  Image get endDrawerHeaderImage => _endDrawerHeaderImage;

  String _endDrawerItemText1 = 'BERANDA';
  String get endDrawerItemText1 => _endDrawerItemText1;

  String _endDrawerItemText2 = 'RIWAYAT';
  String get endDrawerItemText2 => _endDrawerItemText2;

  String _endDrawerItemText3 = 'TENTANG';
  String get endDrawerItemText3 => _endDrawerItemText3;

  TextStyle _endDrawerItemTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: FleoColor.c400(),
  );
  TextStyle get endDrawerItemTextStyle => _endDrawerItemTextStyle;

  final NavigationService _navigationService = locator<NavigationService>();
  Future navigateToHome() async {
    await _navigationService.clearTillFirstAndShow(Routes.homeView);
  }

  Future navigateToHistory() async {
    await _navigationService.clearTillFirstAndShow(Routes.historyView);
  }

  Future navigateToAbout() async {
    await _navigationService.clearTillFirstAndShow(Routes.aboutView);
  }
}
