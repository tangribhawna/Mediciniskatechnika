import 'package:flutter/cupertino.dart';

class HomeModal extends ChangeNotifier {
  bool isLoading = false;
  List<Map<String, dynamic>> _allProducts = [];

  List<Map<String, dynamic>> get allProducts => _allProducts;

  List<Map<String, dynamic>> _products = [];

  List<Map<String, dynamic>> get products => _products;

  List<Map<String, dynamic>> _cartProducts = [];

  List<Map<String, dynamic>> get cartProducts => _cartProducts;

  List _categories = [];

  List get categories => _categories;

  int _amount;

  List<Map<String, dynamic>> _newData = [];

  set newData(List<Map<String, dynamic>> value) {
    _newData = value;
  }

  List<Map<String, dynamic>> get newData => _newData;

  void addAmount({int amount}) {
    _amount = amount;
  }

  List<String> _text = [];

  List<String> get text => _text;

  int get amount => _amount;
}
