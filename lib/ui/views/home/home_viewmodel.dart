import 'package:fleoscan/app/locator.dart';
import 'package:fleoscan/services/airlines_service.dart';
import 'package:fleoscan/services/airports_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final AirportsService _airportsService = locator<AirportsService>();
  final AirlinesService _airlinesService = locator<AirlinesService>();

  initialise() async {
    // seharusnya bagian ini di loading screen
    // sekalian database
    if (_airportsService.aL == null) {
      await _airportsService.getList();
    }
    if (_airlinesService.aL == null) {
      await _airlinesService.getList();
    }
  }

  SvgPicture _logoFleoscan = SvgPicture.asset(
    'assets/logo-white.svg',
    height: 169,
  );
  SvgPicture get logoFleoscan => _logoFleoscan;

  List<String> _hint = [
    'Ketuk',
    ' tombol kuning ',
    'untuk memindai barcode tiket pesawat.'
  ];
  List<String> get hint => _hint;
}
