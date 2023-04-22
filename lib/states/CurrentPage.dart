import 'package:flutter/material.dart';

class CurrentPage extends ChangeNotifier {
  int page = 0;
  void changePageNo(int page) {
    this.page = page;
    notifyListeners();
  }
}
