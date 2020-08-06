import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
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
