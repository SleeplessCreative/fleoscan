import 'dart:async';
import 'dart:io' as io;
import 'package:fleoscan/datamodels/flight_data.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
class DatabaseService {
  static Database _db;
  static const String TABLE = 'FlightData';
  static const String DB_NAME = 'flightdata.db';

  static const String ID = 'id';
  static const String NAME = 'name';
  static const String SCANNEDDATE = 'scannedDate';
  static const String FROMAIRPORTNAME = 'fromAirportName';
  static const String FROMAIRPORTCODE = 'fromAirportCode';
  static const String TOAIRPORTNAME = 'toAirportName';
  static const String TOAIRPORTCODE = 'toAirportCode';
  static const String AIRLINENAME = 'airLineName';
  static const String AIRLINECODE = 'airLineCode';
  static const String FLIGHTNUMBER = 'flightNumber';
  static const String BOOKINGCODE = 'bookingCode';
  static const String FLIGHTDATE = 'flightDate';
  static const String CABINCLASS = 'cabinClass';
  static const String SEATNUMBER = 'seatNumber';
  static const String SEQUENCENUMBER = 'sequenceNumber';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $TABLE(
      $ID INTEGER AUTO_INCREMENT,
      $NAME TEXT,
      $SCANNEDDATE TEXT,
      $FROMAIRPORTNAME TEXT,
      $FROMAIRPORTCODE TEXT,
      $TOAIRPORTNAME TEXT,
      $TOAIRPORTCODE TEXT,
      $AIRLINENAME TEXT,
      $AIRLINECODE TEXT,
      $FLIGHTNUMBER TEXT,
      $BOOKINGCODE TEXT,
      $FLIGHTDATE TEXT,
      $CABINCLASS TEXT,
      $SEATNUMBER TEXT,
      $SEQUENCENUMBER TEXT,
      PRIMARY KEY ($ID)
    )''');
  }

  Future<FlightData> save(FlightData flightData) async {
    var dbClient = await db;
    flightData.id = await dbClient.insert(TABLE, flightData.toMap());
    return flightData;
  }

  // Future<List<FlightData>> getFlightData() async {
  //   var dbClient = await db;
  //   List<Map> maps = await dbClient.rawQuery('''
  //     SELECT * FROM $TABLE
  //     ORDER BY $ID DESC
  //   ''');
  //   List<FlightData> flightDatas = [];
  //   if (maps.length > 0) {
  //     for (int i = 0; i < maps.length; i++) {
  //       flightDatas.add(FlightData.fromMap(maps[i]));
  //     }
  //   }
  //   return flightDatas;
  // }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

//Custom function
  /// Duplicate check
  Future<bool> checkDuplicate(String check) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery('''
    SELECT * FROM $TABLE WHERE $NAME = '$check'
    ''');
    if (maps.length > 0) {
      return true;
    } else
      return false;
  }

  /// Get list of date available on table
  Future<List<String>> getDateList() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery('''
    SELECT * FROM $TABLE 
    GROUP BY $FLIGHTDATE
    ''');
    List<String> dateList = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        dateList.add(FlightData.fromMap(maps[i]).flightDate);
      }
    }
    return dateList;
  }

  /// Get list of flight at choosenDate
  Future<List<String>> getFlightList(String choosenDate) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery('''
      SELECT * FROM $TABLE 
      WHERE $FLIGHTDATE='$choosenDate' 
      GROUP BY $FLIGHTNUMBER  
    ''');
    List<String> flightList = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        flightList.add(FlightData.fromMap(maps[i]).flightNumber);
      }
    }
    return flightList;
  }

  /// Get all available Flight Number
  Future<List<String>> getFlightListNoDate() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery('''
      SELECT * FROM $TABLE 
      GROUP BY $FLIGHTNUMBER  
    ''');
    List<String> flightList = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        flightList.add(FlightData.fromMap(maps[i]).flightNumber);
      }
    }
    return flightList;
  }

  /// Get data for listview
  //// Get data with choosenDate and choosenFlight
  Future<List<FlightData>> getDateFlightData(
      String choosenDate, String choosenFlight) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery('''
      SELECT * FROM $TABLE 
      WHERE $FLIGHTDATE='$choosenDate' AND $FLIGHTNUMBER='$choosenFlight'
      ORDER BY $NAME ASC   
    ''');
    List<FlightData> flightDatas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        flightDatas.add(FlightData.fromMap(maps[i]));
      }
    }
    return flightDatas;
  }

//// Get data with choosenDate
  Future<List<FlightData>> getDateData(String choosenDate) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery('''
      SELECT * FROM $TABLE 
      WHERE $FLIGHTDATE='$choosenDate'
      ORDER BY $NAME ASC   
    ''');
    List<FlightData> flightDatas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        flightDatas.add(FlightData.fromMap(maps[i]));
      }
    }
    return flightDatas;
  }

//// Get data with choosenFlight
  Future<List<FlightData>> getFlightData(String choosenFlight) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery('''
      SELECT * FROM $TABLE 
      WHERE $FLIGHTNUMBER='$choosenFlight'
      ORDER BY $NAME ASC   
    ''');
    List<FlightData> flightDatas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        flightDatas.add(FlightData.fromMap(maps[i]));
      }
    }
    return flightDatas;
  }

  //// Get data with
  Future<List<FlightData>> getData() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery('''
      SELECT * FROM $TABLE 
      ORDER BY $ID DESC   
    ''');
    List<FlightData> flightDatas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        flightDatas.add(FlightData.fromMap(maps[i]));
      }
    }
    return flightDatas;
  }

  /// Delete row in table
  //// Delete by choosenDate and choosenFlight
  Future clearDbDateFlight(String choosenDate, String choosenFlight) async {
    var dbClient = await db;
    return dbClient.delete(
      TABLE,
      where: '$FLIGHTDATE=? AND $FLIGHTNUMBER=?',
      whereArgs: ['$choosenDate', '$choosenFlight'],
    );
  }

//// Delete by choosenDate
  Future clearDbDate(String choosenDate) async {
    var dbClient = await db;
    return dbClient.delete(
      TABLE,
      where: '$FLIGHTDATE=?',
      whereArgs: ['$choosenDate'],
    );
  }

//// Delete by choosenFlight
  Future clearDbFlight(String choosenFlight) async {
    var dbClient = await db;
    return dbClient.delete(
      TABLE,
      where: '$FLIGHTNUMBER=?',
      whereArgs: ['$choosenFlight'],
    );
  }

//// Delete All
  Future clearDb() async {
    var dbClient = await db;
    return dbClient.delete(TABLE);
  }
}
