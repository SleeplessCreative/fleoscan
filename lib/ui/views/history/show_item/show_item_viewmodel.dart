import 'package:fleoscan/datamodels/flight_data.dart';
import 'package:stacked/stacked.dart';

class ShowItemViewModel extends BaseViewModel {
  final FlightData flightData;

  ShowItemViewModel({this.flightData});

  FlightData get data => flightData;
  String get nameText => 'NAMA';
  String get fromText => 'ASAL';
  String get toText => 'TUJUAN';
  String get dateText => 'TANGGAL';
  String get seatText => 'TEMPAT DUDUK';
  String get flightText => 'NOMOR PENERBANGAN';
  String get sequenceText => 'SEQUENCE';
  String get bookingCodeText => 'KODE BOOKING';
}
