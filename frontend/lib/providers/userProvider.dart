import 'package:flutter/material.dart';

class userProvider with ChangeNotifier {
  String _username = "";
  String _type = "";
  String _token = "";

  String get username => _username;
  String get type => _type;
  String get token => _token;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setType(String type) {
    _type = type;
    notifyListeners();
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }
}
