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
  List<String> _flightDateList;
  List<String> _flightList;
  bool _isThereData;
  bool _isDateChoosen;
  bool _isFlightChoosen;
  String _choosenDate;
  String _choosenFlight;

// Getter
  List<FlightData> get flightDatas => _flightDatas;
  List<String> get flightDateList => _flightDateList;
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

  void setFlightDateList(List<String> flightDateList) {
    _flightDateList = flightDateList;
  }

  void setFlightList(List<String> flightList) {
    _flightList = flightList;
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
  initialise() {
    setIsThereData(false);
    setIsDateChoosen(false);
    setIsFlightChoosen(false);
    notifyListeners();
    getBasicDataList();
  }

  Future getBasicDataList() async {
    setFlightDatas(await _databaseService.getFlightData());
    setFlightDateList(await _databaseService.getFlightDateList());
    if (_flightDatas != null && _flightDatas.length != 0) {
      setIsThereData(true);
    }
    notifyListeners();
  }

  Future getFlightList(String choosenDate) async {
    setFlightList(await _databaseService.getFlightList(choosenDate));
  }

  Future getFilteredDataList(String _choosenDate, String _choosenFlight) async {
    if (_isDateChoosen && _isFlightChoosen) {
      setFlightDatas(await _databaseService.getFlightDataFiltered(
          choosenDate, choosenFlight));
      notifyListeners();
    }
  }

  void onChangedDateList(dynamic value) {
    setChoosenDate(value);
    setChoosenFlight(null);
    setIsDateChoosen(true);
    notifyListeners();
    getFlightList(_choosenDate);
  }

  void onChangedFlightList(dynamic value) {
    setChoosenFlight(value);
    setIsFlightChoosen(true);
    notifyListeners();
    getFilteredDataList(_choosenDate, _choosenFlight);
  }

  void onTapDeleteIcon(String message) async {
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.base,
      description: message,
    );
    if (response.confirmed) {
      await _databaseService.clearDb();
      setIsThereData(false);
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
