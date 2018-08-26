import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:http/http.dart'  as http;
import 'dart:async';

class LinerDetailsScreen extends StatelessWidget {
  final String linerId;

  LinerDetailsScreen({Key key, @required this.linerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text("Liner Information"),
      ),
      body: linerDetailListView(),
    );
  }

  Widget linerDetailListView() {
    return Container(
      child: ListView(
        children: <Widget>[
          TitleSubtileTile("Client", "waffles"),
          TitleSubtileTile("Plant", ""),
          TitleSubtileTile("Structure", ""),
          TitleSubtileTile("Position", ""),
        ],
      ),
    );
  }

  Widget TitleSubtileTile(String title, String subTitle) {
    return Container(
      decoration: new BoxDecoration(
          border: new BorderDirectional(
              bottom: BorderSide(color: Colors.grey[400]))),
      child: Row(children: <Widget>[
        Padding(
          padding: new EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 17.0),
              ),
              Padding(
                padding: new EdgeInsets.all(5.0),
                child: Text(
                  subTitle,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 13.0, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

}