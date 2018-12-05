import 'package:flutter/material.dart';
import 'package:flutter_app/CustomViews/textField.dart';
import 'package:flutter_app/Networking/LinerInformationRequest.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/CustomViews/LinerDetailsScreen.dart';
import 'dart:convert';

class StatelessLinertNumberInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return statefullLinertNumberInputScreen();
  }

  Widget statefullLinertNumberInputScreen() {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          LinerNumberInputScreen(),
        ],
      ),
    );
  }
}

class LinerNumberInputScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LinerNumberInputScreenState();
  }
}

class LinerNumberInputScreenState extends State<LinerNumberInputScreen> {
  LinerNumberInputScreenState({key: Key});

  final linerNumberTextFieldController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          title: Text('Rapid Armor'),
          actions: <Widget>[confirmButton(context)],
        ),
        body: inputView());
  }

  Widget inputView() {
    return Container(
      decoration: new BoxDecoration(
          border: new BorderDirectional(
              bottom: BorderSide(color: Colors.grey[400]))),
      child: textField(linerNumberTextFieldController, false,
          "Please enter the number on the liner", "Liner Number :", null),
    );
  }

  Widget flatButtonContent() {
    if (isLoading == true) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return new Center(
          child: Text("Confirm", style: TextStyle(color: Colors.white)));
    }
  }

  void performLinerInformationRequest(BuildContext context) async {
    http.Response response =
        await linerInformationRequest(linerNumberTextFieldController.text);
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
      _showDialog("Retreiving liner data failed",
          "Please double check the liner number or contact your supplier");
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
