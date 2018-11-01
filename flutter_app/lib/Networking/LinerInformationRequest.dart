import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/Storage/Storage.dart';
import 'package:http/http.dart' as http;

Future<http.Response> linerInformationRequest(String linerNumber) async {
  var url = "http://0.0.0.0:3000/liner";
  String token = await secureStorage().read(key: "token");

  var body = json.encode({
      'user_id': token,
      'liner': {
        'liner_reference': linerNumber,
      }
  });
  print(body);
  Map<String, String> headers = {'Content-type': 'application/json'};
  final response = await http.post(url, body: body, headers: headers);
  final responseJson = json.decode(response.body);
  return responseJson
}

class Liner {
  final int row;
  final int collumn;

  final int height;
  final int width;
  final int thickness;

  final String structure;
  final String plant;
  final String location;


  Liner({this.row, this.collumn, this.height, this.width, this.thickness, this.structure, this.plant, this.location});

  factory Liner.fromJson(Map<String, dynamic> json) {
    return Liner(
      row: json['row'],
      collumn: json['collumn'],
      height: json['height'],
      width: json['width'],
      thickness: json['thickness'],
      structure: json['structure'],
      plant: json['plant'],
      location: json['location']
    );
  }
}