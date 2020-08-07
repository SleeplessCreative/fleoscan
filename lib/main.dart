import 'package:Fleoscan/app/locator.dart';
import 'package:Fleoscan/ui/setup_dialog_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/router.gr.dart';
import 'items/fleocolor.dart';

void main() {
  setupLocator();
  setupDialogUi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: FleoColor.c300(),
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Montserrat'),
      initialRoute: Routes.homeView,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
