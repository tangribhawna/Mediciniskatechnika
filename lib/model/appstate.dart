import 'package:flutter/material.dart';
import 'package:medicinskatechnika/model/homemodal.dart';

class AppState with ChangeNotifier {
  final homemodal = HomeModal();

  notifyChange() {
    notifyListeners();
  }

  AppState();
}
