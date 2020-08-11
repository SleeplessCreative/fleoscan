//=====================================
// Class untuk Objek data penerbangan
// Ada Getter-Setter, From Map - To Map
//=====================================

class FlightData {
  int id;
  String name;
  String scannedDate;
  String fromAirportName;
  String fromAirportCode;
  String toAirportName;
  String toAirportCode;
  String airLineName;
  String airLineCode;
  String flightNumber;
  String bookingCode;
  String flightDate;
  String cabinClass;
  String seatNumber;
  String sequenceNumber;

  FlightData({
    this.id,
    this.name,
    this.scannedDate,
    this.fromAirportName,
    this.fromAirportCode,
    this.toAirportName,
    this.toAirportCode,
    this.airLineName,
    this.airLineCode,
    this.flightNumber,
    this.bookingCode,
    this.flightDate,
    this.cabinClass,
    this.seatNumber,
    this.sequenceNumber,
  });
  FlightData.initial()
      : this.id = null,
        this.name = '-',
        this.scannedDate = '',
        this.fromAirportName = '-',
        this.fromAirportCode = '-',
        this.toAirportName = '-',
        this.toAirportCode = '',
        this.airLineName = '-',
        this.airLineCode = '',
        this.flightNumber = '-',
        this.bookingCode = '',
        this.flightDate = '-',
        this.cabinClass = '-',
        this.seatNumber = '-',
        this.sequenceNumber = '';

// Getter
  int get getId => id;
  String get getName => name;
  String get getScannedDate => scannedDate;
  String get getFromAirportName => fromAirportName;
  String get getFromAirportCode => fromAirportCode;
  String get getToAirportName => toAirportName;
  String get getToAirportCode => toAirportCode;
  String get getAirLineName => airLineName;
  String get getAirLineCode => airLineCode;
  String get getFlightNumber => flightNumber;
  String get getBookingCode => bookingCode;
  String get getFlightDate => flightDate;
  String get getCabinClass => cabinClass;
  String get getSeatNumber => seatNumber;
  String get getSequenceNumber => sequenceNumber;

// Setter
  void setName(String s) {
    this.name = s;
  }

  void setScannedDate(String s) {
    this.scannedDate = s;
  }

  void setFromAirportName(String s) {
    this.fromAirportName = s;
  }

  void setFromAirportCode(String s) {
    this.fromAirportCode = s;
  }

  void setToAirportName(String s) {
    this.toAirportName = s;
  }

  void setToAirportCode(String s) {
    this.toAirportCode = s;
  }

  void setAirLineName(String s) {
    this.airLineName = s;
  }

  void setAirLineCode(String s) {
    this.airLineCode = s;
  }

  void setFlightNumber(String s) {
    this.flightNumber = s;
  }

  void setBookingCode(String s) {
    this.bookingCode = s;
  }

  void setFlightDate(String s) {
    this.flightDate = s;
  }

  void setCabinClass(String s) {
    this.cabinClass = s;
  }

  void setSeatNumber(String s) {
    this.seatNumber = s;
  }

  void setSequenceNumber(String s) {
    this.sequenceNumber = s;
  }

//======================================
//Konversi Map dart ke Map database
//======================================
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'scannedDate': scannedDate,
      'fromAirportName': fromAirportName,
      'fromAirportCode': fromAirportCode,
      'toAirportName': toAirportName,
      'toAirportCode': toAirportCode,
      'airLineName': airLineName,
      'airLineCode': airLineCode,
      'flightNumber': flightNumber,
      'bookingCode': bookingCode,
      'flightDate': flightDate,
      'cabinClass': cabinClass,
      'seatNumber': seatNumber,
      'sequenceNumber': sequenceNumber,
    };
    return map;
  }

//======================================
//Konversi Map dari database ke Map dart
//======================================
  FlightData.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    scannedDate = map['scannedDate'];
    fromAirportName = map['fromAirportName'];
    fromAirportCode = map['fromAirportCode'];
    toAirportName = map['toAirportName'];
    toAirportCode = map['toAirportCode'];
    airLineName = map['airLineName'];
    airLineCode = map['airLineCode'];
    flightNumber = map['flightNumber'];
    bookingCode = map['bookingCode'];
    flightDate = map['flightDate'];
    cabinClass = map['cabinClass'];
    seatNumber = map['seatNumber'];
    sequenceNumber = map['sequenceNumber'];
  }

  String getIndex(int index) {
    switch (index) {
      case 1:
        return name;
      case 2:
        return bookingCode;
      case 3:
        return seatNumber;
      case 4:
        return sequenceNumber;
    }
    return '';
  }
}
