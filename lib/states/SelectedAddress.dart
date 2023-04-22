import 'package:flutter/material.dart';

class SelectedAddress extends ChangeNotifier {
  String addressId = "";
  void changeSelectedAddress(String address) {
    addressId = address;
    notifyListeners();
  }
}
