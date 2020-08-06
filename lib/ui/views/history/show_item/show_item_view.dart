import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'show_item_viewmodel.dart';

class ShowItemView extends StatelessWidget {
  const ShowItemView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShowItemViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Text(model.title),
              ),
            ),
        viewModelBuilder: () => ShowItemViewModel());
  }
}
