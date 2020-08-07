import 'package:fleoscan/datamodels/flight_data.dart';
import 'package:fleoscan/items/airlines.dart';
import 'package:fleoscan/items/airports.dart';
import 'package:fleoscan/items/cabins.dart';
import 'package:fleoscan/items/months.dart';

class ParseResult {
  final String s;
  ParseResult(this.s);

  Airports listAirport = new Airports();
  Airlines listAirline = new Airlines();
  Cabins listCabin = new Cabins();
  Months listMonth = new Months();

  FlightData _process = new FlightData.initial();
  FlightData get process {
    //Name
    int pos = s.indexOf('/');
    String lastName = removeSpace(s.substring(2, pos));
    String firstName = removeSpace(s.substring(pos + 1, 22));
    _process.setName(firstName + ' ' + lastName);

    //Scan Date
    DateTime currentDate = new DateTime.now();
    String scannedDateY = currentDate.year.toString();
    String scannedDateM = currentDate.month.toString();
    String scannedDateD = currentDate.day.toString();
    _process
        .setScannedDate(scannedDateY + '-' + scannedDateM + '-' + scannedDateD);

    //Booking Code
    _process.setBookingCode(s.substring(23, 29));

    //Airport
    _process.setFromAirportCode(s.substring(30, 33));
    _process.setToAirportCode(s.substring(33, 36));
    _process.setFromAirportName(
        listAirport.airport[_process.fromAirportCode].toString().toUpperCase());
    _process.setToAirportName(
        listAirport.airport[_process.toAirportCode].toString().toUpperCase());

    //Airlines
    _process.setAirLineCode(s.substring(36, 38));
    _process.setAirLineName(
        listAirline.airline[_process.airLineCode].toString().toUpperCase());

    //Flight Number
    _process.setFlightNumber(_process.airLineCode + s.substring(39, 43));

    //Flight Date
    DateTime date = julianConvert(s.substring(44, 47));
    String flightDateYear = date.year.toString();
    String flightDateMonth = listMonth.month[date.month].toUpperCase();
    String flightDateDay = date.day.toString();
    _process.setFlightDate(
        flightDateDay + ' ' + flightDateMonth + ' ' + flightDateYear);

    //Cabin Class
    String cabinCode = s.substring(47, 48);
    _process.setCabinClass(listCabin.cabin[cabinCode].toString().toUpperCase());

    //Seat Number
    _process.setSeatNumber(s.substring(49, 52));

    //Sequence Number (check-in number)
    _process.setSequenceNumber(s.substring(53, 56));

    return _process;
  }

  DateTime julianConvert(String s) {
    int julianInt = int.parse(s);
    DateTime firstDay = new DateTime(2020, 01, 01);
    DateTime currentDay = firstDay.add(Duration(days: julianInt - 1));
    return currentDay;
  }

  String removeSpace(String s) => s.replaceAll(new RegExp(r"\s+"), " ").trim();
}
