
// part 'counter.g.dart';

import 'package:flutter/material.dart';

class IndexState with ChangeNotifier{
  List<dynamic> _banner = []; // 轮播
  List<dynamic> _list = []; // 横向列表
  double _offset = 0;
  get offset => _offset;
  get list => _list;
  get banner => _banner;
  void updateBanner(List<dynamic> banner) {
    _banner = banner;
    notifyListeners();
  }

  void updateList(List<dynamic> list) {
    _list = list;
    notifyListeners();
  }

  void updateOffset(double offset) {
    _offset = offset;
    notifyListeners();
  }
}