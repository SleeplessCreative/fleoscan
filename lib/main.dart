import 'package:fleoscan/app/locator.dart';
import 'package:fleoscan/services/analytics_service.dart';
import 'package:fleoscan/ui/setup_dialog_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/router.gr.dart' as rtr;
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
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fleoscan',
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      initialRoute: rtr.Routes.homeView,
      onGenerateRoute: rtr.Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      navigatorObservers: [
        locator<AnalyticsService>().getAnalyticsObserver(),
      ],
    );
  }
}
