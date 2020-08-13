import 'package:stacked/stacked.dart';
import 'package:flutter_svg/svg.dart';

class AppbarViewModel extends BaseViewModel {
  String get appbarTitle => 'FLEOSCAN';

  SvgPicture _burgerSvgPicture = SvgPicture.asset(
    'assets/burger.svg',
    width: 17,
  );
  SvgPicture get burgerSvgPicture => _burgerSvgPicture;
}
