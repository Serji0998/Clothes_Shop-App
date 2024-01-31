import 'package:first_app/components/products.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List<Products> _products = [];

  List<Products> get products => _products;

  void setProducts(List<Products> newProducts) {
    _products = newProducts;
    notifyListeners();
  }

  // Clear existing products
  void clearProducts() {
    _products.clear();
    notifyListeners();
  }

  // Add new products
  void addProducts(List<Products> newProducts) {
    _products.addAll(newProducts);
    notifyListeners();
  }
}
