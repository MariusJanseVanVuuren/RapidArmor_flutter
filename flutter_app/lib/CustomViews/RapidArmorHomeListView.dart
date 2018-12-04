import 'package:flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'LoginView.dart';
import 'CustomListTile.dart';
import 'package:flutter_app/Storage/Storage.dart';

class RapidArmorHomeListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeListViewState();
  }
}

class _HomeListViewState extends State<RapidArmorHomeListView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showLoginIfRequired());
  }


  @override
  Widget build(BuildContext context) {
    List<HomeListViewItem> rowItems = [
      HomeListViewItem.LocateLiner,
      HomeListViewItem.ReplaceLiner,
      HomeListViewItem.MeasureLiner,
      HomeListViewItem.ChangeLinerLocation
    ];

    List<Widget> widgets = [];
    for (HomeListViewItem rowItem in rowItems) {
      widgets.add(CustomListTile(rowItem: rowItem));
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          title: Text('Rapid Armor'),
        ),
        body: ListView(
          children: widgets,
        ));
  }

  void showLoginIfRequired() {
    var requestKey = secureStorage().read(key: "token");
    if (requestKey != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginView()),
      );
    }
  }

}
