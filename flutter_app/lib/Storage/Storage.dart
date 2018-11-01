import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _storage = new FlutterSecureStorage();
FlutterSecureStorage secureStorage() {
  return _storage;
}