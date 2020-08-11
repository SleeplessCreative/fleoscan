import 'package:fleoscan/app/locator.dart';
import 'package:fleoscan/services/analytics_service.dart';
import 'package:fleoscan/ui/setup_dialog_ui.dart';
import 'package:fleoscan/ui/setup_snackbar_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/router.gr.dart' as rtr;
import 'items/fleocolor.dart';

void main() {
  setupLocator();
  setupDialogUi();
  setupSnackbarUi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: FleoColor.c300(),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fleoscan',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        accentColor: FleoColor.c100(),
        splashColor: FleoColor.c100(),
        highlightColor: FleoColor.c100(),
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
