import 'package:flutter/material.dart';
import 'package:flutter_app/CustomViews/textField.dart';
import 'package:flutter_app/Networking/LinerInformationRequest.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/CustomViews/LinerDetailsScreen.dart';
import 'package:path/path.dart';
import 'package:flutter_app/CustomViews/RapidArmorHomeListView.dart';

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
      return new Center(child: Text("Confirm"));
    }
  }

  void performLinerInformationRequest(BuildContext context) async {
    http.Response response =
        await linerInformationRequest(linerNumberTextFieldController.text);
    if (response.statusCode == 200) {
      Liner liner = Liner.fromJson(response);
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
