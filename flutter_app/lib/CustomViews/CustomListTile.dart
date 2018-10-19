import 'package:flutter_app/main.dart';
import 'LinerDetailsScreen.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final HomeListViewItem rowItem;

  CustomListTile({Key key, @required this.rowItem}) : super(key: key);

  Future scanQRCode(BuildContext context, HomeListViewItem action) async {
    try {
      String qrCode = await BarcodeScanner.scan();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LinerDetailsScreen(
              linerId: qrCode,
            )),
      );
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Container(
          decoration: new BoxDecoration(
              border: new BorderDirectional(
                  bottom: BorderSide(color: Colors.grey[400]))),
          child: materialContainer(rowItem, context),
        ));
  }

  Widget materialContainer(HomeListViewItem rowItem, BuildContext context) {
    String rowText;
    switch (rowItem) {
      case (HomeListViewItem.LocateLiner):
        rowText = 'Locate Liner Position';
        break;
      case (HomeListViewItem.ReplaceLiner):
        rowText = 'Replace Liner';
        break;
      case (HomeListViewItem.MeasureLiner):
        rowText = 'Measure Liner';
        break;
      case (HomeListViewItem.ChangeLinerLocation):
        rowText = 'Change Liner Position';
        break;
      default:
        break;
    }

    return InkWell(
      splashColor: Colors.red[400],
      highlightColor: Colors.redAccent[400],
      onTap: () {
        scanQRCode(context, rowItem);
      },
      child: Row(
        children: <Widget>[centerTextWithPadding(rowText)],
      ),
    );
  }

  Widget centerTextWithPadding(String rowText) {
    return Center(
      child: Padding(
        padding: new EdgeInsets.all(16.0),
        child: Text(
          rowText,
          style: TextStyle(fontSize: 17.0),
        ),
      ),
    );
  }
}