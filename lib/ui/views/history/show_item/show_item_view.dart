import 'package:fleoscan/datamodels/flight_data.dart';
import 'package:fleoscan/items/fleocolor.dart';
import 'package:fleoscan/ui/widgets/appbar/appbar_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'show_item_viewmodel.dart';

class ShowItemView extends StatelessWidget {
  const ShowItemView({Key key, this.passData}) : super(key: key);

  final FlightData passData;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShowItemViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppbarView(
                title: 'DETAIL',
                height: 100,
                burgerButton: false,
              ),
              body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: new BoxDecoration(
                  color: FleoColor.c300(),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  boxShadow: [defaultShadow],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 25,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              model.data.getAirLineName,
                              style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                                color: FleoColor.c400(),
                              ),
                            ),
                            Text(
                              model.data.getCabinClass,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: FleoColor.c400(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: containerItem(
                          insideContainer(model.nameText, model.data.getName)),
                    ),
                    Expanded(
                      flex: 20,
                      child: containerItem(insideContainer(
                          model.fromText, model.data.getFromAirportName)),
                    ),
                    Expanded(
                      flex: 20,
                      child: containerItem(insideContainer(
                          model.toText, model.data.getToAirportName)),
                    ),
                    Expanded(
                      flex: 20,
                      child: containerItem(insideContainer(
                          model.dateText, model.data.getFlightDate)),
                    ),
                    Expanded(
                      flex: 20,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: containerItem(insideContainer(
                                model.seatText, model.data.getSeatNumber)),
                          ),
                          Expanded(
                            flex: 6,
                            child: containerItem(insideContainer(
                                model.flightText, model.data.getFlightNumber)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: containerItem(insideContainer(
                                model.sequenceText,
                                model.data.getSequenceNumber)),
                          ),
                          Expanded(
                            flex: 6,
                            child: containerItem(insideContainer(
                                model.bookingCodeText,
                                model.data.getBookingCode)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => ShowItemViewModel(flightData: passData));
  }

  //Container untuk item
  Widget containerItem(Widget childLayout) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      margin: EdgeInsets.symmetric(vertical: 3.0),
      color: Colors.white,
      child: childLayout,
    );
  }

  //Isi didalam kontainer
  Widget insideContainer(String topText, String bottomText) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          topText,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w300,
            height: 2,
            color: FleoColor.c400(),
          ),
        ),
        Text(
          bottomText,
          style: TextStyle(
            fontSize: 16,
            color: FleoColor.c400(),
          ),
        ),
      ],
    );
  }
}
