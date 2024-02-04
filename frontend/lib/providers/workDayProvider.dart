import 'package:flutter/material.dart';
import 'dart:math';

class workDayProvider with ChangeNotifier {
  Random random = Random();
  int _id = 0;

  int get id => _id;

  void setId(int id) {
    _id = id;
    notifyListeners();
  }

  void generateId() {
    _id = (100000 + random.nextInt(900000));
  }
}
