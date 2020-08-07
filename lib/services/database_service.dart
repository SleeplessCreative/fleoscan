import 'dart:async';
import 'dart:io' as io;
import 'package:Fleoscan/datamodels/flight_data.dart';
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

  Future<List<FlightData>> getFlightData() async {
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

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(FlightData flightData) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, flightData.toMap(),
        where: '$ID = ?', whereArgs: [flightData.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  Future clearDb() async {
    var dbClient = await db;
    return dbClient.delete(TABLE);
  }

  //================
  //-Custom function
  //================
  //--Untuk cek duplikat di database, return boolean
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

  //--Untuk fetch tanggal penerbangan yang pernah discan, return Array String
  Future<List<String>> getFlightDateList() async {
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

  //--Untuk fetch kode penerbangan sesuai tanggal, return Array String
  Future<List<String>> getFlightList(String _flightDate) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery('''
      SELECT * FROM $TABLE 
      WHERE $FLIGHTDATE='$_flightDate' 
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

  //--Untuk fetch data history sesuai dengan tanggal dan kode penerbangan
  Future<List<FlightData>> getFlightDataFiltered(
      String _flightDate, String _flightNumber) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery('''
      SELECT * FROM $TABLE 
      WHERE $FLIGHTDATE='$_flightDate' AND $FLIGHTNUMBER='$_flightNumber'
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
}
