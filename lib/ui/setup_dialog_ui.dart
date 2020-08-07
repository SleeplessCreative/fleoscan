import 'package:Fleoscan/app/locator.dart';
import 'package:Fleoscan/items/fleocolor.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'dialog_type.dart';

void setupDialogUi() {
  var dialogService = locator<DialogService>();

  dialogService.registerCustomDialogBuilder(
    variant: DialogType.base,
    builder: (BuildContext context, DialogRequest dialogRequest) => AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(25, 20, 30, 25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 25),
              child: Text(
                dialogRequest.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: FleoColor.c400(),
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Icon(
                      Icons.close,
                      color: FleoColor.c400(),
                    ),
                    onPressed: () => dialogService
                        .completeDialog(DialogResponse(confirmed: false)),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    child: Icon(
                      Icons.check,
                      color: FleoColor.c800(),
                    ),
                    onPressed: () => dialogService
                        .completeDialog(DialogResponse(confirmed: true)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
