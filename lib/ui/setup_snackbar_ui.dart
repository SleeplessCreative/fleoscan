import 'package:fleoscan/app/locator.dart';
import 'package:fleoscan/items/fleocolor.dart';
import 'package:stacked_services/stacked_services.dart';

import 'snackbar_type.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  /// Snackbar with green bg (success snackbar)
  service.registerCustomSnackbarConfig(
    variant: SnackbarType.greenAndWhite,
    config: SnackbarConfig(
      backgroundColor: FleoColor.c700(),
      titleColor: FleoColor.c200(),
      messageColor: FleoColor.c300(),
      borderRadius: 1,
    ),
  );

  /// Snackbar with grey bg (failed snackbar)
  service.registerCustomSnackbarConfig(
    variant: SnackbarType.defaultColor,
    config: SnackbarConfig(
      backgroundColor: FleoColor.c400(),
      titleColor: FleoColor.c200(),
      messageColor: FleoColor.c200(),
      borderRadius: 1,
    ),
  );
}
