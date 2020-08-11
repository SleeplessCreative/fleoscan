import 'package:fleoscan/datamodels/flight_data.dart';

class SavePdfProperties {
  final List<FlightData> data;
  final String code;
  final String origin;
  final String destination;
  final String flightNumber;
  final String cabinClass;
  final String flightDate;

  SavePdfProperties({
    this.data,
    this.code,
    this.origin,
    this.destination,
    this.flightNumber,
    this.cabinClass,
    this.flightDate,
  });
}
