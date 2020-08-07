import 'package:fleoscan/items/fleocolor.dart';
import 'package:fleoscan/ui/widgets/appbar/appbar_view.dart';
import 'package:fleoscan/ui/widgets/end_drawer/end_drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'history_viewmodel.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) => Scaffold(
              appBar: AppbarView(
                height: 100,
                burgerButton: false,
              ),
              endDrawer: EndDrawerView(),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 55,
                          child: DateDropDownButton(),
                        ),
                        Expanded(
                          flex: 45,
                          child: FlightDropDownButton(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: model.isThereData
                        ? NotEmptyContainer()
                        : EmptyContainer(),
                  ),
                  model.isThereData
                      ? Expanded(child: BottomButton())
                      : Container(),
                ],
              ),
            ),
        viewModelBuilder: () => HistoryViewModel());
  }
}

class DateDropDownButton extends ViewModelWidget<HistoryViewModel> {
  const DateDropDownButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, HistoryViewModel model) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: model.choosenDate,
          items: model.flightDateList?.map((value) {
                return DropdownMenuItem(
                  child: Center(
                    child: new Text(
                      value,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  value: value,
                );
              })?.toList() ??
              [],
          onChanged: (newValue) {
            model.onChangedDateList(newValue);
          },
          hint: Container(
            child: Text(
              model.dateDropdownText,
              style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class FlightDropDownButton extends ViewModelWidget<HistoryViewModel> {
  const FlightDropDownButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, HistoryViewModel model) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 20),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: model.choosenFlight,
          items: model.flightList?.map((value) {
                return DropdownMenuItem(
                  child: Center(
                    child: new Text(
                      value,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  value: value,
                );
              })?.toList() ??
              [],
          onChanged: (newValue) {
            model.onChangedFlightList(newValue);
          },
          hint: Container(
            child: Text(
              model.flightDropdownText,
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyContainer extends ViewModelWidget<HistoryViewModel> {
  const EmptyContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, HistoryViewModel model) {
    return Container(
      alignment: Alignment(0, 0),
      padding: EdgeInsets.symmetric(vertical: 50.0),
      child: Text(
        model.emptyContainerText,
        style: TextStyle(
          fontSize: 16.0,
          color: FleoColor.c400(),
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class NotEmptyContainer extends ViewModelWidget<HistoryViewModel> {
  const NotEmptyContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, HistoryViewModel model) {
    return ListView.builder(
      itemCount: model.flightDatas.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            model.onTapContainerData();
          },
          child: Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
            margin: EdgeInsets.symmetric(vertical: 7),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    model.flightDatas[index].getName,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: FleoColor.c400(),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${model.flightDatas[index].getFromAirportCode} - ${model.flightDatas[index].getToAirportCode}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: FleoColor.c400(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${model.flightDatas[index].getFlightDate}',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                            color: FleoColor.c400(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BottomButton extends ViewModelWidget<HistoryViewModel> {
  const BottomButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, HistoryViewModel model) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: FleoColor.c800(),
              boxShadow: [defaultShadow],
            ),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                model.onTapDeleteIcon(model.deleteDatabaseDialogDescription);
              },
            ),
          ),
        ),
      ],
    );
  }
}
