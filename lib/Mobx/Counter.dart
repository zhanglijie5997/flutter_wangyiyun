
// part 'counter.g.dart';

import 'package:flutter/material.dart';

class CounterState with ChangeNotifier{
  int _counter = 3;
  Color _color = Color.fromRGBO(34, 35, 36, 1);
  Map<String, double> _local = {
    "lng": 0.0,
    "lat": 0.0
  };
  get local => _local;
  get color => _color;
  get counter => _counter;
  void update(int number) {
    _counter = number;
    notifyListeners();
  }

  void updateLocal(Map<String, double> _loc) {
    _local = _loc;
    notifyListeners();
  }
}