import 'package:barcode_scan/barcode_scan.dart';
import 'package:fleoscan/app/locator.dart';
import 'package:fleoscan/datamodels/flight_data.dart';
import 'package:fleoscan/services/analytics_service.dart';
import 'package:fleoscan/services/database_service.dart';
import 'package:fleoscan/services/device_info_services.dart';
import 'package:fleoscan/services/scan_service.dart';
import 'package:fleoscan/ui/dialog_type.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ScanViewModel extends BaseViewModel {
  final ScanService _scanService = locator<ScanService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final DeviceInfoService _deviceInfoService = locator<DeviceInfoService>();

  String get nameText => 'NAMA';
  String get fromText => 'ASAL';
  String get toText => 'TUJUAN';
  String get dateText => 'TANGGAL';
  String get seatText => 'TEMPAT DUDUK';
  String get flightText => 'NOMOR PENERBANGAN';

  List<String> deviceInfo;

  bool _scanned = true;
  bool get scanned => _scanned;

  String _errorMesage;
  String get errorMessage => _errorMesage;

  FlightData _flightData = new FlightData.initial();
  FlightData get data => _flightData;

  void setData(FlightData flightData) {
    _flightData = flightData;
    notifyListeners();
  }

  initialise() async {
    await getDeviceInfo();
    await getScanParsedResult();
  }

  Future getScanParsedResult() async {
    FlightData result;

    try {
      result = await _scanService.result;
      _scanned = true;
    } on PlatformException catch (ex) {
      _scanned = false;
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        _errorMesage = 'Akses kamera ditolak';
      } else {
        _errorMesage = 'Error tidak dikenal!\n$ex';
      }
    } on FormatException {
      _scanned = false;
      _errorMesage = 'Anda belum memindai apapun';
    } catch (ex) {
      _scanned = false;
      _errorMesage = 'Error tidak dikenal!\n$ex';
    }
    if (_scanned) {
      logScanResult(
          '${result.getName} ${result.getFlightNumber} ${result.getSeatNumber}');
      setData(result);
      bool duplicate =
          await _databaseService.checkDuplicate(_flightData.getName);
      if (!duplicate) {
        _databaseService.save(_flightData);
      }
    } else {
      logScanResult(_errorMesage);
      errorDialog(_errorMesage);
    }
  }

  Future errorDialog(String failedMessage) async {
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.base,
      description: failedMessage,
    );
    if (response.confirmed) {
      await getScanParsedResult();
    } else {
      _navigationService.popUntil((route) => route.isFirst);
    }
  }

  getDeviceInfo() async {
    deviceInfo = await _deviceInfoService.deviceDetails;
    _analyticsService.setUserProperties(userId: deviceInfo[0].toString());
  }

  logScanResult(String s) {
    if (_scanned) {
      _analyticsService.logScanSuccess(scanResult: s);
    } else {
      _analyticsService.logScanFailed(errorMessage: s);
    }
  }
}
