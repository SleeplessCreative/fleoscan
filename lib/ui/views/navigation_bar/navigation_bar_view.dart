import 'package:fleoscan/items/fleocolor.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'navigation_bar_viewmodel.dart';

class NavigationBarView extends PreferredSize {
  final double height;

  @override
  NavigationBarView({this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationBarViewModel>.nonReactive(
        builder: (context, model, child) => Container(
              height: preferredSize.height,
              width: double.infinity,
              child: new Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        highlightColor: FleoColor.c100(),
                        customBorder: CircleBorder(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 70,
                          ),
                          child: model.cameraImage,
                        ),
                        onTap: () {
                          model.navigateToScan();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => NavigationBarViewModel());
  }
}
