import 'package:flutter/material.dart';
import 'package:flutter_app/Networking/LinerInformationRequest.dart';

class LinerDetailsScreen extends StatelessWidget {
  final Liner liner;

  LinerDetailsScreen({Key key, @required this.liner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text("Liner : "+this.liner.linerReference.toString()),
      ),
      body: linerDetailListView(),
    );
  }

  Widget linerDetailListView() {
    print(this.liner);
    return Container(
      child: ListView(
        children: <Widget>[
          TitleSubtileTile("Plant : ", this.liner.plant ?? ""),
          TitleSubtileTile("Structure : ", this.liner.structure ?? ""),
          TitleSubtileTile("Row : ", this.liner.row.toString() ?? ""),
          TitleSubtileTile("Collumn : ", this.liner.column.toString() ?? ""),
          TitleSubtileTile("Height : ", this.liner.height.toString() ?? ""),
          TitleSubtileTile("Width : ", this.liner.width.toString()) ?? "",
          TitleSubtileTile("Thickness :", this.liner.thickness.toString() ?? "")
        ],
      ),
    );
  }

  Widget TitleSubtileTile(String title, String subTitle) {
    return Container(
      decoration: new BoxDecoration(
          border: new BorderDirectional(
              bottom: BorderSide(color: Colors.grey[400]))),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 17.0, color: Colors.grey[900], fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  subTitle,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 13.0, color: Colors.black),
                ),
              )
            ]),
      ),
    );
  }
}
