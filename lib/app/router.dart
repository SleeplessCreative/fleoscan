import 'package:auto_route/auto_route_annotations.dart';
import 'package:fleoscan/ui/views/about/about_view.dart';
import 'package:fleoscan/ui/views/history/history_view.dart';
import 'package:fleoscan/ui/views/history/show_item/show_item_view.dart';
import 'package:fleoscan/ui/views/home/home_view.dart';
import 'package:fleoscan/ui/views/scan/scan_view.dart';
//import 'package:fleoscan/ui/views/startup/startup_view.dart';

@MaterialAutoRouter(routes: [
  //MaterialRoute(page: StartupView, initial: true),
  MaterialRoute(page: HomeView, initial: true),
  MaterialRoute(page: ScanView),
  MaterialRoute(page: HistoryView),
  MaterialRoute(page: ShowItemView),
  MaterialRoute(page: AboutView),
])
class $Router {}
