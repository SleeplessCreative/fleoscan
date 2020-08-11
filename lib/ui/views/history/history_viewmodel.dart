import 'package:fleoscan/app/locator.dart';
import 'package:fleoscan/datamodels/flight_data.dart';
import 'package:fleoscan/datamodels/save_pdf_properties.dart';
import 'package:fleoscan/services/database_service.dart';
import 'package:fleoscan/services/pdf_create_services.dart';
import 'package:fleoscan/ui/snackbar_type.dart';
import 'package:fleoscan/ui/views/history/show_item/show_item_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../dialog_type.dart';

class HistoryViewModel extends BaseViewModel {
  final DatabaseService _databaseService = locator<DatabaseService>();
  final DialogService _dialogService = locator<DialogService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CreatePdfService _createPdfService = locator<CreatePdfService>();

  List<FlightData> _flightDatas;
  List<String> _dateList;
  List<String> _flightList;
  List<String> _flightNumber = [];
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
  List<String> get flightNumber => _flightNumber;
  bool get isThereData => _isThereData;
  bool get isDateChoosen => _isDateChoosen;
  bool get isFlightChoosen => _isFlightChoosen;
  String get choosenDate => _choosenDate;
  String get choosenFlight => _choosenFlight;

  String get dateDropdownText => 'TANGGAL';
  String get flightDropdownText => 'KODE';
  String get emptyContainerText => 'TIDAK ADA DATA!';

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

  void setFlightNumber(List<String> flightNumber) {
    _flightNumber = flightNumber;
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

// Logical state base on dropdown
  int dropdownCase() {
    if (_isDateChoosen && _isFlightChoosen) {
      return 0;
    } else if (_isDateChoosen && !_isFlightChoosen) {
      return 1;
    } else if (!_isDateChoosen && _isFlightChoosen) {
      return 2;
    } else {
      return 3;
    }
  }

// Viewmodel Function
  initialise() {
    refreshPage();
  }

  refreshPage() async {
    setIsThereData(false);
    setIsDateChoosen(false);
    setIsFlightChoosen(false);
    setChoosenDate(null);
    setChoosenFlight(null);
    await getData();
    if (_isThereData) {
      getDateList();
      getFlightList();
      getFlightNumber();
    }
  }

// Logical value setter
  /// Get data for the Listview builder (flightDatas)
  Future getData() async {
    switch (dropdownCase()) {
      case 0:
        setFlightDatas(await dbGetDateFlightData());
        break;
      case 1:
        setFlightDatas(await dbGetDateData());
        break;
      case 2:
        setFlightDatas(await dbGetFlightData());
        break;
      case 3:
        setFlightDatas(await dbGetData());
        break;
    }
    if (_flightDatas != null && _flightDatas.length != 0) {
      getFlightNumber();
      setIsThereData(true);
    }
    notifyListeners();
  }

  /// Get available flight based on FlighDatas, for the Listview grouping
  getFlightNumber() {
    List<String> _fn = [];
    _flightDatas.forEach((element) => _fn.add(element.getFlightNumber));
    List<String> distinctFN = _fn.toSet().toList();
    setFlightNumber(distinctFN);
    notifyListeners();
  }

  /// Get all available date on dropdown
  Future getDateList() async {
    setDateList(await dbGetDateList());
    notifyListeners();
  }

  /// Get all available flight on dropdown
  Future getFlightList() async {
    if (isDateChoosen) {
      setFlightList(await dbGetFlightListWithDate());
    } else {
      setFlightList(await dbGetFlightListNoDate());
    }
    notifyListeners();
  }

// Connect to database services
  /// Get data from database for each case
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

  ///Get date list from database for the dropdown
  Future<List<String>> dbGetDateList() async {
    return await _databaseService.getDateList();
  }

  ///Get flight list from database for the dropdown
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

  Future onTapContainerData(FlightData value) async {
    await _navigationService.navigateToView(ShowItemView(
      passData: value,
    ));
  }

  onTapDeleteIcon() async {
    String dialogMessage;
    switch (dropdownCase()) {
      case 0:
        dialogMessage =
            'Anda ingin menghapus data $_choosenFlight tanggal $_choosenDate?';
        break;
      case 1:
        dialogMessage = 'Anda ingin menghapus data tanggal $_choosenDate?';
        break;
      case 2:
        dialogMessage = 'Anda ingin menghapus data $_choosenFlight?';
        break;
      case 3:
        dialogMessage = 'Anda ingin menghapus semua data?';
        break;
    }
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.base,
      description: dialogMessage,
    );
    String snackBarMessage;
    String snackBarTitle = 'Berhasil';
    if (response.confirmed) {
      switch (dropdownCase()) {
        case 0:
          await _databaseService.clearDbDateFlight(
              _choosenDate, _choosenFlight);
          snackBarMessage =
              'Data $_choosenFlight tanggal $_choosenDate telah dihapus.';
          break;
        case 1:
          await _databaseService.clearDbDate(_choosenDate);
          snackBarMessage = 'Data tanggal $_choosenDate telah dihapus.';
          break;
        case 2:
          await _databaseService.clearDbFlight(_choosenFlight);
          snackBarMessage = 'Data $_choosenFlight telah dihapus.';
          break;
        case 3:
          await _databaseService.clearDb();
          snackBarMessage = 'Semua data telah dihapus.';
          break;
      }
      showSnackbarService(snackBarTitle, snackBarMessage);
      refreshPage();
    }
  }

  onTapSaveIcon() async {
    String snackBarMessage;
    String snackBarTitle = 'Gagal';
    switch (dropdownCase()) {
      case 0:
        SavePdfProperties savePdfProperties = new SavePdfProperties(
          data: _flightDatas,
          code: _flightDatas.first.getAirLineCode,
          origin: _flightDatas.first.getFromAirportName,
          destination: _flightDatas.first.getToAirportName,
          cabinClass: _flightDatas.first.getCabinClass,
          flightNumber: _choosenFlight,
          flightDate: _choosenDate,
        );
        await _createPdfService.startPdfService(savePdfProperties);
        snackBarMessage = 'Berhasil menyimpan PDF.';
        snackBarTitle = 'Berhasil';
        break;
      case 1:
        snackBarMessage = 'Silahkan pilih kode penerbangan!';
        break;
      case 2:
        snackBarMessage = 'Silahkan pilih tanggal!';
        break;
      case 3:
        snackBarMessage = 'Silahkan pilih tanggal dan kode penerbangan!';
        break;
    }
    showSnackbarService(snackBarTitle, snackBarMessage);
  }

  showSnackbarService(String title, String message) {
    _snackbarService.showCustomSnackBar(
      variant: title == 'Gagal'
          ? SnackbarType.defaultColor
          : SnackbarType.greenAndWhite,
      title: title,
      message: message,
      duration: Duration(seconds: 3),
    );
  }
}
