import 'package:fleoscan/app/locator.dart';
import 'package:fleoscan/datamodels/flight_data.dart';
import 'package:fleoscan/services/database_service.dart';
import 'package:fleoscan/ui/views/history/show_item/show_item_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../dialog_type.dart';

class HistoryViewModel extends BaseViewModel {
  final DatabaseService _databaseService = locator<DatabaseService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<FlightData> _flightDatas;
  List<String> _dateList;
  List<String> _flightList = [];
  bool _isThereData;
  bool _isDateChoosen;
  bool _isFlightChoosen;
  String _choosenDate;
  String _choosenFlight;
  String _semua = 'SEMUA';

// Getter
  List<FlightData> get flightDatas => _flightDatas;
  List<String> get dateList => _dateList;
  List<String> get flightList => _flightList;
  bool get isThereData => _isThereData;
  bool get isDateChoosen => _isDateChoosen;
  bool get isFlightChoosen => _isFlightChoosen;
  String get choosenDate => _choosenDate;
  String get choosenFlight => _choosenFlight;

  String get dateDropdownText => 'TANGGAL';
  String get flightDropdownText => 'KODE';
  String get emptyContainerText => 'TIDAK ADA DATA!';
  String get deleteDatabaseDialogDescription =>
      'Anda yakin ingin menghapus seluruh data?';

// Setter
  void setFlightDatas(List<FlightData> flightDatas) {
    _flightDatas = flightDatas;
  }

  void setDateList(List<String> dateList) {
    _dateList = dateList;
    _dateList.insert(0, _semua);
  }

  void setFlightList(List<String> flightList) {
    _flightList = flightList;
    _flightList.insert(0, _semua);
  }

  void setIsThereData(bool isThereData) {
    _isThereData = isThereData;
  }

  void setIsDateChoosen(bool isDateChoosen) {
    _isDateChoosen = isDateChoosen;
  }

  void setIsFlightChoosen(bool isFlightChoosen) {
    _isFlightChoosen = isFlightChoosen;
  }

  void setChoosenDate(String choosenDate) {
    _choosenDate = choosenDate;
  }

  void setChoosenFlight(String choosenFlight) {
    _choosenFlight = choosenFlight;
  }

  // Viewmodel Function
  initialise() async {
    setIsThereData(false);
    setIsDateChoosen(false);
    setIsFlightChoosen(false);
    await getData();
    if (_isThereData) {
      setChoosenDate(null);
      setChoosenFlight(null);
      getDateList();
      getFlightList();
    }
  }

  // Logical value setter
  Future getData() async {
    if (_isDateChoosen && _isFlightChoosen) {
      setFlightDatas(await dbGetDateFlightData());
    } else if (_isDateChoosen && !_isFlightChoosen) {
      setFlightDatas(await dbGetDateData());
    } else if (!_isDateChoosen && _isFlightChoosen) {
      setFlightDatas(await dbGetFlightData());
    } else {
      setFlightDatas(await dbGetData());
    }
    if (_flightDatas != null && _flightDatas.length != 0) {
      setIsThereData(true);
    }
    notifyListeners();
  }

  Future getDateList() async {
    setDateList(await dbGetDateList());
    notifyListeners();
  }

  Future getFlightList() async {
    if (isDateChoosen) {
      setFlightList(await dbGetFlightListWithDate());
    } else {
      setFlightList(await dbGetFlightListNoDate());
    }
    notifyListeners();
  }

  // Connect to database services
  Future<List<FlightData>> dbGetDateFlightData() async {
    return await _databaseService.getDateFlightData(
        _choosenDate, _choosenFlight);
  }

  Future<List<FlightData>> dbGetDateData() async {
    return await _databaseService.getDateData(_choosenDate);
  }

  Future<List<FlightData>> dbGetFlightData() async {
    return await _databaseService.getFlightData(_choosenFlight);
  }

  Future<List<FlightData>> dbGetData() async {
    return await _databaseService.getData();
  }

  Future<List<String>> dbGetDateList() async {
    return await _databaseService.getDateList();
  }

  Future<List<String>> dbGetFlightListWithDate() async {
    return await _databaseService.getFlightList(_choosenDate);
  }

  Future<List<String>> dbGetFlightListNoDate() async {
    return await _databaseService.getFlightListNoDate();
  }

  //onTap function
  void onChangedDateList(dynamic value) {
    setChoosenDate(value);
    setIsFlightChoosen(false);
    if (value == 'SEMUA') {
      setIsDateChoosen(false);
      setChoosenFlight(null);
    } else {
      setChoosenFlight('SEMUA');
      setIsDateChoosen(true);
    }
    getFlightList();
    getData();
  }

  void onChangedFlightList(dynamic value) {
    setChoosenFlight(value);
    if (value == 'SEMUA') {
      setIsFlightChoosen(false);
    } else {
      setIsFlightChoosen(true);
    }
    getData();
  }

  void onTapDeleteIcon(String message) async {
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.base,
      description: message,
    );
    if (response.confirmed) {
      await _databaseService.clearDb();
      setIsThereData(false);
      setChoosenDate(null);
      setChoosenFlight(null);
      notifyListeners();
    } else {
      _navigationService.popRepeated(1);
    }
  }

  Future onTapContainerData(FlightData value) async {
    await _navigationService.navigateToView(ShowItemView(
      passData: value,
    ));
  }
}
