import 'package:flutter/material.dart';
import 'package:flutter_app/Networking/LinerInformationRequest.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/CustomViews/LinerDetailsScreen.dart';
import 'dart:convert';
import 'package:flutter_app/CustomViews/textField.dart';

class StatelessMeasureLinerInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return statefullMeasureLinertInputScreen();
  }

  Widget statefullMeasureLinertInputScreen() {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          MeasureLinerInputScreen(),
        ],
      ),
    );
  }
}

class MeasureLinerInputScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MeasureLinersInputScreenState();
  }
}

class MeasureLinersInputScreenState extends State<MeasureLinerInputScreen> {
  final previousLinerNumberTextFieldController = TextEditingController();
  final linerMeasurementTextFieldController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          title: Text('Measure Liners'),
          actions: <Widget>[confirmButton(context)],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[previousLinerInputView(), newLinerInputView()],
        ));
  }

  Widget previousLinerInputView() {
    return Container(
      decoration: new BoxDecoration(
          border: new BorderDirectional(
              bottom: BorderSide(color: Colors.grey[400]))),
      child: textField(previousLinerNumberTextFieldController, false, "Liner Number :",
          "Liner Number", null),
    );
  }

  Widget newLinerInputView() {
    return Container(
      decoration: new BoxDecoration(
          border: new BorderDirectional(
              bottom: BorderSide(color: Colors.grey[400]))),
      child: textField(linerMeasurementTextFieldController, false,
          "millimeters", "Measurement in millimeters :", null),
    );
  }

  Widget flatButtonContent() {
    if (isLoading == true) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return new Center(child: Text("Confirm", style: TextStyle(color: Colors.white)));
    }
  }

  void performLinerInformationRequest(BuildContext context) async {
    http.Response response = await updateLinerMeasurementRequest(
        previousLinerNumberTextFieldController.text,
        linerMeasurementTextFieldController.text);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      Liner liner = Liner.fromJson(responseJson);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LinerDetailsScreen(
                liner: liner,
              )));
    } else {
      _showDialog("Measuring liner failed", "Please double check the liner number and ensure you have enetred the liner measurement in millimeters or contact your supplier");
    }
  }

  Widget confirmButton(BuildContext context) {
    return FlatButton(
        onPressed: () {
          performLinerInformationRequest(context);
        },
        child: flatButtonContent());
  }

  void updateState(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  void _showDialog(String title, String subtitle) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(subtitle),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
