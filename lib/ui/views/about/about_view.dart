import 'package:fleoscan/items/fleocolor.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'about_viewmodel.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AboutViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Container(
                width: double.infinity,
                decoration: new BoxDecoration(
                  color: FleoColor.c200(),
                  boxShadow: [defaultShadow],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.all(10.0),
                        child: model.logoFleoscan,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                          decoration: BoxDecoration(
                            color: FleoColor.c600(),
                            boxShadow: [defaultShadow],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16.0,
                                    color: FleoColor.c200(),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: model.aboutText),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => AboutViewModel());
  }
}
