import 'package:fleoscan/items/fleocolor.dart';
import 'package:fleoscan/ui/widgets/appbar/appbar_view.dart';
import 'package:fleoscan/ui/widgets/end_drawer/end_drawer_view.dart';
import 'package:fleoscan/ui/widgets/navigation_bar/navigation_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return Scaffold(
            extendBody: true,
            appBar: AppbarView(
              height: 100,
              burgerButton: true,
            ),
            bottomNavigationBar: NavigationBarView(
              height: 110,
            ),
            endDrawer: EndDrawerView(),
            body: Container(
              width: double.infinity,
              decoration: new BoxDecoration(
                color: FleoColor.c100(),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                boxShadow: [defaultShadow],
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Container(
                      child: model.logoFleoscan,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        boxShadow: [defaultShadow],
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          top: 0,
                          left: 30,
                          right: 30,
                          bottom: 60,
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: model.hint[0],
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              color: FleoColor.c400(),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: model.hint[1],
                                style: TextStyle(
                                  color: FleoColor.c100(),
                                ),
                              ),
                              TextSpan(
                                text: model.hint[2],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => HomeViewModel());
  }
}
