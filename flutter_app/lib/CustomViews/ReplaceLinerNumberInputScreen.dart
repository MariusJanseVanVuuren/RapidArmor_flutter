import 'package:flutter/material.dart';
import 'package:flutter_app/CustomViews/textField.dart';
import 'package:flutter_app/Networking/LinerInformationRequest.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/CustomViews/LinerDetailsScreen.dart';
import 'dart:convert';

class StatelessReplaceLinertInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return statefullReplaceLinertInputScreen();
  }

  Widget statefullReplaceLinertInputScreen() {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          ReplaceLinerInputScreen(),
        ],
      ),
    );
  }
}

class ReplaceLinerInputScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReplaceLinerInputScreenState();
  }
}

class ReplaceLinerInputScreenState extends State<ReplaceLinerInputScreen> {
  ReplaceLinerInputScreenState({key: Key});

  final previousLinerNumberTextFieldController = TextEditingController();
  final newLinerNumberTextFieldController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          title: Text('Replace Liner'),
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
      child: textField(previousLinerNumberTextFieldController, false,
          "Previous Liner Number", "Liner Number :", null),
    );
  }

  Widget newLinerInputView() {
    return Container(
      decoration: new BoxDecoration(
          border: new BorderDirectional(
              bottom: BorderSide(color: Colors.grey[400]))),
      child: textField(newLinerNumberTextFieldController, false,
          "New Liner Number ", "Liner Number :", null),
    );
  }

  Widget flatButtonContent() {
    if (isLoading == true) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return new Center(child: Text("Confirm"));
    }
  }

  void performLinerInformationRequest(BuildContext context) async {
    http.Response response = await replaceLinerRequest(
        previousLinerNumberTextFieldController.text,
        newLinerNumberTextFieldController.text);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      Liner liner = Liner.fromJson(responseJson);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LinerDetailsScreen(
                    liner: liner,
                  )));
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
}
