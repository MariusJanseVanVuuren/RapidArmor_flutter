import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/Storage/Storage.dart';
import 'package:http/http.dart' as http;


Future<http.Response> loginRequest(String email, String password) async {
  var url = "http://0.0.0.0:3000/login";
  var body = json.encode({
    'session' : { 'email': email, 'password': password, 'remember_me' : '1'}
  });
  Map<String, String> headers = {
    'Content-type' : 'application/json'
  };
  final response = await http.post(url, body: body, headers: headers);
  final responseJson = json.decode(response.body);
  print(responseJson);
  secureStorage().write(key: "token", value: responseJson["token"]);
  secureStorage().read(key: "token");
  return response;
}