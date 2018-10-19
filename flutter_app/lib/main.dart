import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/CustomViews/LoginView.dart';
import 'package:flutter_app/CustomViews/RapidArmorHomeListView.dart';
enum HomeListViewItem {
  LocateLiner,
  ReplaceLiner,
  MeasureLiner,
  ChangeLinerLocation
}

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rapid Armor',
      home: LoginView(),
    )
  );
}


