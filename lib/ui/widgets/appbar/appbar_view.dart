import 'package:fleoscan/items/fleocolor.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'appbar_viewmodel.dart';

class AppbarView extends PreferredSize {
  final double height;
  final bool burgerButton;
  final String title;

  @override
  AppbarView({this.height = kToolbarHeight, this.burgerButton, this.title});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppbarViewModel>.nonReactive(
        builder: (context, model, child) => Container(
            height: preferredSize.height,
            color: Colors.transparent,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: FleoColor.c400(),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: burgerButton ? BergerButton() : Container(),
                ),
              ],
            )),
        viewModelBuilder: () => AppbarViewModel());
  }
}

class BergerButton extends ViewModelWidget<AppbarViewModel> {
  const BergerButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, AppbarViewModel model) {
    return Container(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 30.0,
          maxHeight: 25.0,
        ),
        child: FlatButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          padding: EdgeInsets.all(0.0),
          child: model.burgerSvgPicture,
        ),
      ),
    );
  }
}
