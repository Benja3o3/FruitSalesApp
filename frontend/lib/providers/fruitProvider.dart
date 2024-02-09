import 'package:flutter/material.dart';

class fruitProvider with ChangeNotifier {
  List<int> _fruitSelected = [];

  List<int> get fruitSelected => _fruitSelected;

  void addFruit(int id) {
    _fruitSelected.add(id);
    notifyListeners();
  }

  void removeFruit(int id) {
    _fruitSelected.remove(id);
    notifyListeners();
  }

  void clearFruit() {
    _fruitSelected.clear();
    notifyListeners();
  }
}
