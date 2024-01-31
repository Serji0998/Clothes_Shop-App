import 'package:first_app/components/products.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  //products for sale
  final List<Products> _shop = [
    Products(
      productName: "Product 1",
      price: 99.9,
      description: "For Sale..",
      image: '',
    ),
    Products(
      productName: "Product 2",
      price: 99.9,
      description: "For Sale..",
      image: '',
    ),
    Products(
      productName: "Product 3",
      price: 99.9,
      description: "For Sale..",
      image: '',
    ),
  ];

  //user cart
  List<Products> _cart = [];

  //get product list
  List<Products> get shop => _shop;

  //get user cart
  List<Products> get cart => _cart;

  //add item to cart
  void addToCart(Products item) {
    _cart.add(item);
    notifyListeners();
  }

  //remove item from cart
  void removeFromCart(Products item) {
    _cart.remove(item);
    notifyListeners();
  }
}
