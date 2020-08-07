import 'package:fleoscan/app/locator.dart';
import 'package:fleoscan/ui/setup_dialog_ui.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/router.gr.dart';

void main() {
  setupLocator();
  setupDialogUi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Montserrat'),
      initialRoute: Routes.homeView,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
