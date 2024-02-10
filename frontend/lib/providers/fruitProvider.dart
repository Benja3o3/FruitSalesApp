import 'package:flutter/material.dart';

class fruitProvider with ChangeNotifier {
  List<int> _fruitSelected = [];
  int _totalPotes = 0;
  int _totalMoney = 0;

  List<int> get fruitSelected => _fruitSelected;
  int get totalPotes => _totalPotes;
  int get totalMoney => _totalMoney;

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

  void setTotalPotes(int potes) {
    _totalPotes = potes;
    notifyListeners();
  }

  void setTotalMoney(int money) {
    _totalMoney = money;
    notifyListeners();
  }
}
