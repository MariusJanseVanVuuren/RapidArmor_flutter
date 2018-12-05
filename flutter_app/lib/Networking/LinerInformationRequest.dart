import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/Storage/Storage.dart';
import 'package:http/http.dart' as http;

var baseUrl = "https://rapidarmor.herokuapp.com";
var linerURL = baseUrl+"/liner";
var updateURL = baseUrl + "/measurement";
var swapURL = baseUrl + "/swap";
var replaceURL = baseUrl = "/replace";

Future<http.Response> updateLinerMeasurementRequest(
    String linerNumber, String thickness) async {
  String token = await secureStorage().read(key: "token");
  var body = json.encode({
    'user_id': token,
    'liner': {
      'liner_reference': linerNumber,
      'current_thickness': thickness,
    }
  });
  Map<String, String> headers = {'Content-type': 'application/json'};
  final response = await http.post(updateURL, body: body, headers: headers);
  return response;
}

Future<http.Response> swapLinersRequest(
    String previousLinerNumber, String newLinerNumber) async {
  String token = await secureStorage().read(key: "token");
  var body = json.encode({
    'user_id': token,
    'liner': {
      'previous_liner_reference': previousLinerNumber,
      'new_liner_reference': newLinerNumber,
    }
  });
  Map<String, String> headers = {'Content-type': 'application/json'};
  final response =
      await http.post(swapURL, body: body, headers: headers);
  return response;
}

Future<http.Response> replaceLinerRequest(
    String previousLinerNumber, String newLinerNumber) async {
  String token = await secureStorage().read(key: "token");
  var body = json.encode({
    'user_id': token,
    'liner': {
      'previous_liner_reference': previousLinerNumber,
      'new_liner_reference': newLinerNumber,
    }
  });
  Map<String, String> headers = {'Content-type': 'application/json'};
  final response =
      await http.post(replaceURL, body: body, headers: headers);
  return response;
}

Future<http.Response> linerInformationRequest(String linerNumber) async {
  String token = await secureStorage().read(key: "token");
  var body = json.encode({
    'user_id': token,
    'liner': {
      'liner_reference': linerNumber,
    }
  });
  Map<String, String> headers = {'Content-type': 'application/json'};
  final response = await http.post(linerURL, body: body, headers: headers);
  return response;
}

class Liner {
  final String linerReference;

  final int row;
  final int column;

  final double height;
  final double width;
  final double thickness;

  final String structure;
  final String plant;
  final String location;

  Liner(
      {this.linerReference,
      this.row,
      this.column,
      this.height,
      this.width,
      this.thickness,
      this.structure,
      this.plant,
      this.location});

  factory Liner.fromJson(Map<String, dynamic> json) {
    try {
      print(json);
      var row = int.parse(json['row'] ?? 0);
      var column = int.parse(json['collumn'] ?? "0");
      var width = double.parse(json['width'] ?? "0");
      var height = double.parse(json['height'] ?? "0");
      var thickness = json['current_thickness'];

      return Liner(
          linerReference: int.parse(json['liner_reference']).toString(),
          row: row,
          column: column,
          height: height,
          width: width,
          thickness: thickness,
          structure: json['structure'],
          plant: json['plant'],
          location: json['location']);
    } catch (error) {
      print(error);
    }
    return Liner();
  }
}
