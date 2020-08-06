import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'scan_viewmodel.dart';

class ScanView extends StatelessWidget {
  const ScanView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScanViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Text(model.title),
              ),
            ),
        viewModelBuilder: () => ScanViewModel());
  }
}
