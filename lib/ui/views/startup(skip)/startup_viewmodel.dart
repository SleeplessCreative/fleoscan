import 'dart:async';

import 'package:Fleoscan/app/locator.dart';
import 'package:Fleoscan/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel implements Initialisable {
  final NavigationService _navigationService = locator<NavigationService>();
  String _title = 'Waiting';
  String get title => _title;

  //
  @override
  initialise() {
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 10);
    return new Timer(duration, await navigateToHome());
  }

  Future navigateToHome() async {
    await _navigationService.navigateTo(Routes.homeView);
  }
}
