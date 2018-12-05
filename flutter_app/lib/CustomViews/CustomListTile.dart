import 'package:flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'LinerNumberInputScreen.dart';
import 'ReplaceLinerNumberInputScreen.dart';
import 'SwapLinerNumberInputScreen.dart';
import 'MeasureLinerInputScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomListTile extends StatelessWidget {
  final HomeListViewItem rowItem;

  CustomListTile({Key key, @required this.rowItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: new BoxDecoration(
              border: new BorderDirectional(
                  bottom: BorderSide(color: Colors.grey[400]))),
          child: materialContainer(rowItem, context),
        );
  }

  void displayEnterLinerScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LinerNumberInputScreen()),
    );
  }

  void displayReplaceLinerNumbersScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ReplaceLinerInputScreen()),
    );
  }

  void displaySwapLinerNumbersScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SwapLinerInputScreen()),
    );
  }

  void displayMeasureLinerInputScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MeasureLinerInputScreen()),
    );
  }

  void openAugmentForLiner(BuildContext context) {
    _launchURL();
  }

  _launchURL() async {
    const url = 'https://agmt.it/m/aYRQjjUt';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void empty() {

  }

  Widget materialContainer(HomeListViewItem rowItem, BuildContext context) {
    String rowText;
    Function functionForRowItem;
    switch (rowItem) {
      case (HomeListViewItem.LocateLiner):
        rowText = 'Locate Liner Position';
        // ignore: use_of_void_result
        functionForRowItem = displayEnterLinerScreen;
        break;
      case (HomeListViewItem.ReplaceLiner):
        rowText = 'Replace Liner';
        functionForRowItem = displayReplaceLinerNumbersScreen;
        break;
      case (HomeListViewItem.MeasureLiner):
        rowText = 'Measure Liner';
        functionForRowItem = displayMeasureLinerInputScreen; // TODO
        break;
      case (HomeListViewItem.ChangeLinerLocation):
        rowText = 'Change Liner Position';
        functionForRowItem = displaySwapLinerNumbersScreen;
        break;
      case (HomeListViewItem.AugmentLink):
        rowText = 'AR Pulping box view';
        functionForRowItem = openAugmentForLiner;
        break;
      default:
        rowText = "";
        functionForRowItem = empty;
        break;
    }

    return InkWell(
      splashColor: Colors.red[400],
      highlightColor: Colors.redAccent[400],
      onTap: () {
        functionForRowItem(context);
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