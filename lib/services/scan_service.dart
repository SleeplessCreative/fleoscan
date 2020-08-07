import 'package:barcode_scan/barcode_scan.dart';
import 'package:Fleoscan/datamodels/flight_data.dart';
import 'package:Fleoscan/services/parsing_result_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ScanService {
  FlightData parseResult = new FlightData();

  Future<FlightData> get result async {
    await startScan();
    return parseResult;
  }

  Future startScan() async {
    String scanResult = await BarcodeScanner.scan();
    parseScanResult(scanResult);
  }

  parseScanResult(String scanResult) {
    parseResult = ParseResult(scanResult).process;
  }
}
