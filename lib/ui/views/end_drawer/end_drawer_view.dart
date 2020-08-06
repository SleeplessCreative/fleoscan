import 'package:fleoscan/items/fleocolor.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'end_drawer_viewmodel.dart';

class EndDrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String currentRoute = ModalRoute.of(context).settings.name;

    return ViewModelBuilder<EndDrawerViewModel>.reactive(
        builder: (context, model, child) => Container(
              color: FleoColor.c300(),
              child: Drawer(
                child: ListView(padding: EdgeInsets.zero, children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 45, horizontal: 15),
                    child: model.endDrawerHeaderImage,
                  ),
                  Column(
                    children: <Widget>[
                      InkWell(
                        child: EndDrawerItem(
                            endDrawerItemText: model.endDrawerItemText1),
                        onTap: () {
                          currentRoute == '/'
                              ? Navigator.pop(context)
                              : model.navigateToHome();
                        },
                      ),
                      InkWell(
                        child: EndDrawerItem(
                            endDrawerItemText: model.endDrawerItemText2),
                        onTap: () {
                          currentRoute == '/history-view'
                              ? Navigator.pop(context)
                              : model.navigateToHistory();
                        },
                      ),
                      InkWell(
                        child: EndDrawerItem(
                            endDrawerItemText: model.endDrawerItemText3),
                        onTap: () {
                          currentRoute == '/about-view'
                              ? Navigator.pop(context)
                              : model.navigateToAbout();
                        },
                      ),
                    ],
                  ),
                ]),
              ),
            ),
        viewModelBuilder: () => EndDrawerViewModel());
  }
}

class EndDrawerItem extends ViewModelWidget<EndDrawerViewModel> {
  const EndDrawerItem({Key key, this.endDrawerItemText}) : super(key: key);

  final String endDrawerItemText;

  @override
  Widget build(BuildContext context, EndDrawerViewModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      color: FleoColor.c200(),
      child: ListTile(
        title: Text(
          endDrawerItemText,
          style: model.endDrawerItemTextStyle,
        ),
      ),
    );
  }
}
