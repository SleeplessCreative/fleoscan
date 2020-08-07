import 'package:fleoscan/app/locator.dart';
import 'package:fleoscan/app/router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NavigationBarViewModel extends BaseViewModel {
  Image _cameraImage = Image.asset('assets/icon-button-cam.png');
  Image get cameraImage => _cameraImage;

  final NavigationService _navigationService = locator<NavigationService>();
  Future navigateToScan() async {
    await _navigationService.clearTillFirstAndShow(Routes.scanView);
  }
}
