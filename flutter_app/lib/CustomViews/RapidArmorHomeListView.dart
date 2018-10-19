import 'package:flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'CustomListTile.dart';

class RapidArmorHomeListView extends StatelessWidget {
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
}
