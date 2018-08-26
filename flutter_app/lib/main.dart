import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'Scanner.dart';
import 'package:barcode_scan/barcode_scan.dart';

enum HomePageAction {
  LocateLinerPosition,
  replaceLiner,
  MeasureLiner,
  ChangeLinerPosition
}

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rapid Armor',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          title: Text('Rapid Armor'),
        ),
        body: RapidArmorHomeListView(),
      ),
    ),
  );
}

class CustomListTile extends StatelessWidget {
  final String rowText;

  CustomListTile({Key key, @required this.rowText}) : super(key: key);

  Future scanQRCode(BuildContext context, HomePageAction action) async {
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
          child: materialContainer(rowText, context),
        ));
  }

  Widget materialContainer(String rowText, BuildContext context) {
    return InkWell(
      splashColor: Colors.red[400],
      highlightColor: Colors.redAccent[400],
      onTap: () {
        print('I was tapped!');
        scanQRCode(context, HomePageAction.LocateLinerPosition);
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

class RapidArmorHomeListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> rowStrings = [
      'Locate Liner Position',
      'replace Liner',
      'Measure Liner',
      'Change Liner Position'
    ];
    List<Widget> widgets = [];
    for (String rowString in rowStrings) {
      widgets.add(CustomListTile(rowText: rowString));
    }

    return ListView(
      children: widgets,
    );
  }
}
