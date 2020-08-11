import 'package:barcode_scan/barcode_scan.dart';
import 'package:fleoscan/datamodels/flight_data.dart';
import 'package:fleoscan/services/parsing_result_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ScanService {
  FlightData parseResult = new FlightData.initial();

  Future<FlightData> get result async {
    await startScan();
    return parseResult;
  }

  Future startScan() async {
    String scanResult = await BarcodeScanner.scan();
    await parseScanResult(scanResult);
  }

  parseScanResult(String scanResult) async {
    parseResult = await ParseResult(scanResult).process;
  }
}
