// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../datamodels/flight_data.dart';
import '../ui/views/about/about_view.dart';
import '../ui/views/history/history_view.dart';
import '../ui/views/history/show_item/show_item_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/scan/scan_view.dart';

class Routes {
  static const String homeView = '/';
  static const String scanView = '/scan-view';
  static const String historyView = '/history-view';
  static const String showItemView = '/show-item-view';
  static const String aboutView = '/about-view';
  static const all = <String>{
    homeView,
    scanView,
    historyView,
    showItemView,
    aboutView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.scanView, page: ScanView),
    RouteDef(Routes.historyView, page: HistoryView),
    RouteDef(Routes.showItemView, page: ShowItemView),
    RouteDef(Routes.aboutView, page: AboutView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    ScanView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ScanView(),
        settings: data,
      );
    },
    HistoryView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HistoryView(),
        settings: data,
      );
    },
    ShowItemView: (data) {
      final args = data.getArgs<ShowItemViewArguments>(
        orElse: () => ShowItemViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ShowItemView(
          key: args.key,
          passData: args.passData,
        ),
        settings: data,
      );
    },
    AboutView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AboutView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ShowItemView arguments holder class
class ShowItemViewArguments {
  final Key key;
  final FlightData passData;
  ShowItemViewArguments({this.key, this.passData});
}
